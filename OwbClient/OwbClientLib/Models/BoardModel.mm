/*************************************************************************
 ** File Name: BoardModel.mm
 ** Author: tsgsz
 ** Mail: cdtsgsz@gmail.com
 ** Created Time: Tue Apr 16 20:07:05 2013
 **Copyright [2013] <Copyright tsgsz>  [legal/copyright]
 ************************************************************************/
#import "./BoardModel.h"
#import "../Tools/OperationQueue.h"
#import "../SupportFiles/common.h"

@interface BoardModel()
- (void)readOperationQueue;
- (void)drawSelf;
@end

static BoardModel* boardInstance = nil;

@implementation BoardModel

@synthesize inHostMode_ = _inHostMode_;

- (id) init
{
    self = [super init];
    if (nil != self) {
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        context_ = CGBitmapContextCreate(NULL, BOARD_WIDTH, BOARD_HEIGHT, BOARD_BITS_PER_COMPONENT, BOARD_BYTES_PER_PER_ROW, colorSpace, kCGImageAlphaPremultipliedLast);
        CFRelease(colorSpace);
        latestSnapshot_ = CGBitmapContextCreateImage(context_);
        realOperationQueue_ = [[OperationQueue alloc]init];
    }
    return self;
}

- (void) dealloc {
    [super dealloc];
    if (nil != displayer_) {
        [displayer_ release];
    }
    if (nil != operationQueue_) {
        [operationQueue_ release];
    }
    if (nil != realOperationQueue_) {
        [realOperationQueue_ release];
    }
}

+ (BoardModel *) SharedBoard
{
    if (nil == boardInstance) {
        boardInstance = [[BoardModel alloc]init];
    }
    return boardInstance;
}

- (void) attachCanvas:(Canvas *)canvas
{
    displayer_ = canvas;
}

- (void) attachOpeartionQueue:(OperationQueue *)operationQueue
{
    operationQueue_ = operationQueue;
}

- (void) drawMiddleOperation:(OwbClientOperation *)operation
{
    CGContextDrawImage(context_, BOARD_RECT, latestSnapshot_);
    [[operation drawer_]draw:operation InCanvas:context_];
    [displayer_ display];
}

- (void) drawOperation:(OwbClientOperation *)operation
{
    [[operation drawer_]draw:operation InCanvas:context_];
    latestSnapshot_ = CGBitmapContextCreateImage(context_);
    [displayer_ display];
}

- (void) loadDocument:(OwbClientDocument *)document
{
    CFDataRef imgData = (CFDataRef)document.data_;
    CGDataProviderRef imgDataProvider = CGDataProviderCreateWithCFData(imgData);
    size_t width = CGImageGetWidth(latestSnapshot_);
    size_t height = CGImageGetHeight(latestSnapshot_);
    size_t bitsPerComponent = CGImageGetBitsPerComponent(latestSnapshot_);
    size_t bitsPerPixel = CGImageGetBitsPerPixel(latestSnapshot_);
    size_t bytesPerRow = CGImageGetBytesPerRow(latestSnapshot_);
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(latestSnapshot_);
    CGBitmapInfo info = CGImageGetBitmapInfo(latestSnapshot_);
    CGFloat *decode = NULL;
    BOOL shouldInteroplate = NO;
    CGColorRenderingIntent intent = CGImageGetRenderingIntent(latestSnapshot_);
    
    CGImageRef image_ref = CGImageCreate(width, height, bitsPerComponent, bitsPerPixel, bytesPerRow, colorSpace, info, imgDataProvider, decode, shouldInteroplate, intent);
    CGDataProviderRelease(imgDataProvider);
    CGContextDrawImage(context_, BOARD_RECT, image_ref);
    CGImageRelease(image_ref);
    [displayer_ display];
}

- (void) saveSnapshot
{
    latestSnapshot_ = CGBitmapContextCreateImage(context_);
}

- (CGImageRef) getData
{
    return CGBitmapContextCreateImage(context_);
}

- (CGImageRef) getLatestSnapshot
{
    return latestSnapshot_;
}

- (void)readOperationQueue
{
    while (![operationQueue_ isEmpty]) {
        OwbClientOperation* op = [operationQueue_ dequeue];
        [op.drawer_ sliceOpertion:op IntoQueue:realOperationQueue_];
    }
    isReading_ = false;
}

- (void)trigerReadOperationQueue
{
    if (isReading_) {
        [operationQueue_ lock];
        if ([operationQueue_ isEmpty])
            [self performSelectorInBackground:@selector(readOperationQueue) withObject:nil];
        [operationQueue_ unLock];
    } else {
        isReading_ = true;
        [self performSelectorInBackground:@selector(readOperationQueue) withObject:nil];
    }
}

- (void)drawSelf
{
    while (![realOperationQueue_ isEmpty]) {
        OwbClientOperation* op = [realOperationQueue_ dequeue];
        [self drawOperation:op];
    }
    isDrawing_ = false;
}

- (void)trigerDrawSelf
{
    if (isDrawing_) {
        [realOperationQueue_ lock];
        if (![realOperationQueue_ isEmpty])
            [self performSelectorInBackground:@selector(drawSelf) withObject:nil];
        [realOperationQueue_ unLock];
    } else {
        isDrawing_ = true;
        [self performSelectorInBackground:@selector(drawSelf) withObject:nil];
    }
}

@end
