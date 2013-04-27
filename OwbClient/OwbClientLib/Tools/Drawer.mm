/*************************************************************************
     ** File Name: Drawer.mm
    ** Author: tsgsz
    ** Mail: cdtsgsz@gmail.com
    ** Created Time: Mon Apr 22 16:02:52 2013
    **Copyright [2013] <Copyright tsgsz>  [legal/copyright]
 ************************************************************************/

#import "./Drawer.h"
#import "../Models/MessageModel.h"
#import "./ColorMaker.h"
#import "../SupportFiles/common.h"
#import "./OperationQueue.h"

#define DRAWER_CHECK_TYPE(type, Op_type)            \
if (Op_type != Operation_OperationData_OperationDataType_##type)   \
    @throw [NSException exceptionWithName:@"錯誤的類型" reason:@"..." userInfo:nil]


#pragma mark - LineDrawer

@implementation LineDrawer

- (void)draw:(OwbClientOperation *)operation InCanvas:(CGContextRef)canvas
{
    DRAWER_CHECK_TYPE(LINE, operation.operationType_);
    DrawLine* op = (DrawLine *) operation;
    // 設置畫線的屬性
    CGContextSetStrokeColorWithColor(canvas, Kingslanding::OnlineWhiteBoard::Client::Tools::CGColorMake(op.color_, op.alpha_));
    CGContextSetLineCap(canvas, kCGLineCapRound);
    CGContextSetLineWidth(canvas, op.thinkness_);
    CGContextSetAlpha(canvas, op.alpha_);
    
    // 將線條畫在畫布上
    CGContextMoveToPoint(canvas, op.startPoint_.x, op.startPoint_.y);
    CGContextAddLineToPoint(canvas, op.endPoint_.x, op.endPoint_.y);
    CGContextStrokePath(canvas);
    [op release];
}

- (void)sliceOpertion:(OwbClientOperation *)operation IntoQueue:(OperationQueue*) queue
{
    DRAWER_CHECK_TYPE(LINE, operation.operationType_);
    [queue enqueue:operation];
}
@end

#pragma mark - EllipseDrawer
@implementation EllipseDrawer

- (void)draw:(OwbClientOperation *)operation InCanvas:(CGContextRef)canvas
{
    DRAWER_CHECK_TYPE(ELLIPSE, operation.operationType_);
    DrawEllipse* op = (DrawEllipse*) operation;
    
    CGContextSetAlpha(canvas, op.alpha_);
    CGRect ellipse_rect = CGRectMake(op.center_.x-op.a_/2, op.center_.y-op.b_/2, op.a_, op.b_);
    if (op.fill_) {
        CGContextSetFillColorWithColor(canvas, Kingslanding::OnlineWhiteBoard::Client::Tools::CGColorMake(op.color_, op.alpha_));
        CGContextFillEllipseInRect(canvas, ellipse_rect);
    } else {
        CGContextSetStrokeColorWithColor(canvas, Kingslanding::OnlineWhiteBoard::Client::Tools::CGColorMake(op.color_, op.alpha_));
        CGContextSetLineWidth(canvas, op.thinkness_);
        CGContextStrokeEllipseInRect(canvas, ellipse_rect);
    }
    [op release];
}

- (void)sliceOpertion:(OwbClientOperation *)operation IntoQueue:(OperationQueue*) queue
{
    DRAWER_CHECK_TYPE(ELLIPSE, operation.operationType_);
    [queue enqueue:operation];
}

@end

#pragma mark - RectangeDrawer
@implementation RectangeDrawer

- (void)draw:(OwbClientOperation *)operation InCanvas:(CGContextRef)canvas
{
    DRAWER_CHECK_TYPE(RECTANGE, operation.operationType_);
    DrawRectange* op = (DrawRectange*) operation;
    
    CGContextSetAlpha(canvas, op.alpha_);
    CGRect rect = CGRectMake(op.topLeftCorner_.x, op.topLeftCorner_.y, op.topLeftCorner_.x - op.bottomRightCorner_.x, op.topLeftCorner_.y - op.bottomRightCorner_.y);
    if (op.fill_) {
        CGContextSetFillColorWithColor(canvas, Kingslanding::OnlineWhiteBoard::Client::Tools::CGColorMake(op.color_, op.alpha_));
        CGContextFillEllipseInRect(canvas, rect);
    } else {
        CGContextSetStrokeColorWithColor(canvas, Kingslanding::OnlineWhiteBoard::Client::Tools::CGColorMake(op.color_, op.alpha_));
        CGContextSetLineWidth(canvas, op.thinkness_);
        CGContextStrokeEllipseInRect(canvas, rect);
    }
    [op release];
}

- (void)sliceOpertion:(OwbClientOperation *)operation IntoQueue:(OperationQueue*) queue
{
    DRAWER_CHECK_TYPE(RECTANGE, operation.operationType_);
    [queue enqueue:operation];
}

@end

#pragma mark - PointDrawer

@implementation PointDrawer

- (void)draw:(OwbClientOperation *)operation InCanvas:(CGContextRef)canvas
{
    DRAWER_CHECK_TYPE(POINT, operation.operationType_);
    DrawPoint* op = (DrawPoint *) operation;

    CGContextSetStrokeColorWithColor(canvas, Kingslanding::OnlineWhiteBoard::Client::Tools::CGColorMake(op.color_, op.alpha_));
    CGContextSetLineCap(canvas, kCGLineCapRound);
    CGContextSetLineWidth(canvas, op.thinkness_);
    CGContextSetAlpha(canvas, op.alpha_);
    
    CGContextMoveToPoint(canvas, op.position_.x, op.position_.y);
    CGContextAddLineToPoint(canvas, op.position_.x, op.position_.y);
    CGContextStrokePath(canvas);
    [op release];
}

- (void)sliceOpertion:(OwbClientOperation *)operation IntoQueue:(OperationQueue*) queue
{
    DRAWER_CHECK_TYPE(POINT, operation.operationType_);
    [queue enqueue:operation];
}
@end

#pragma mark - Eraser

@implementation Eraser

- (void)draw:(OwbClientOperation *)operation InCanvas:(CGContextRef)canvas
{
    DRAWER_CHECK_TYPE(ERASER, operation.operationType_);
    Erase* op = (Erase *) operation;
    
    CGContextSetStrokeColorWithColor(canvas, Kingslanding::OnlineWhiteBoard::Client::Tools::CGEraserColor());
    CGContextSetLineCap(canvas, kCGLineCapRound);
    CGContextSetLineWidth(canvas, op.thinkness_);

    CGContextMoveToPoint(canvas, op.position_.x, op.position_.y);
    CGContextAddLineToPoint(canvas, op.position_.x, op.position_.y);
    CGContextStrokePath(canvas);
    [op release];
}

- (void)sliceOpertion:(OwbClientOperation *)operation IntoQueue:(OperationQueue*) queue
{
    DRAWER_CHECK_TYPE(ERASER, operation.operationType_);
    [queue enqueue:operation];
}
@end
