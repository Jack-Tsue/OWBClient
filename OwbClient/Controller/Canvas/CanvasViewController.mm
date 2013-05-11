//
//  CanvasViewController.m
//  OwbClient
//
//  Created by Jack on 13/4/13.
//  Copyright (c) 2013 tsgsz. All rights reserved.
//

#import "CanvasViewController.h"
#import "MenuViewController.h"
#import "MenuViewController.h"
#import "MenuViewController.h"
#import "MoveScaleImageView.h"

@interface CanvasViewController ()
@property bool isHost;
@property (strong, nonatomic) OwbClientOperationQueue *opQ_;
@property (strong, nonatomic) UserListViewController *userListVC_;
@property (strong, nonatomic) SnapshotListViewController *snapshotListVC_;
@property (strong, nonatomic) MoveScaleImageView *scaleView;
@end

@implementation CanvasViewController
- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:CANVAS_DEFAULT_FRAME];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.scaleView = [[MoveScaleImageView alloc]initWithFrame:CANVAS_OPEN_FRAME];
    self.scaleView.displayerDelegate_ = self;
    self.scaleView.drawerDelegate_ = [QueueHandler SharedQueueHandler];
    self.scaleView.dataSource_ = [BoardModel SharedBoard];

//    UIImage* image=[UIImage imageNamed:@"background.jpg"];
    
//    [self.canvas_ initViewWithFrame:CANVAS_OPEN_FRAME withImage:image.CGImage];
//    
//    [self.view addSubview:self.canvas_.scaleImageView];
//    self.canvas_.scaleImageView.drawable = true;
    
    [self.view setUserInteractionEnabled:YES];
    [self.view setMultipleTouchEnabled:YES];
    
    // menu
    self.menuVC_ = [[MenuViewController alloc] init];
    self.menuVC_.moveScaleDelegate_ = self;

    // user list
    self.userListVC_ = [[UserListViewController alloc] init];
    
    // snapshot list
    self.snapshotListVC_ = [[SnapshotListViewController alloc] init];
    
    [self.view addSubview:self.menuVC_.view];
    [self.view addSubview:self.userListVC_.view];
    [self.view addSubview:self.snapshotListVC_.view];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}
- (bool)switchDrawMethods{
    self.isHost=!self.isHost;
    return self.isHost;
}

#pragma mark - delegate
- (void)setMovable {
    if ([[BoardModel SharedBoard] inHostMode_]&&self.scaleView.isDrawable_) {
        self.scaleView.isDrawable_ = NO;
        SUCCESS_HUD(@"可以缩放拖拽了");
    } else if ([[BoardModel SharedBoard] inHostMode_]&&!self.scaleView.isDrawable_) {
        self.scaleView.isDrawable_ = YES;
        SUCCESS_HUD(@"现在可以画画了");
    }
}

- (void)setStartDraw {
    if ([[BoardModel SharedBoard] inHostMode_]&&!self.scaleView.isDrawable_) {
        self.scaleView.isDrawable_ = YES;
        SUCCESS_HUD(@"现在可以画画了");
    }
}

- (void)scaleSmaller {
    int tmpBoardIndex = [self.scaleView getBoardIndex];
//    NSLog(@"0: %d", tmpBoardIndex);
    if (0==tmpBoardIndex) {
        ERROR_HUD(MIN_HINT);
    } else {
        [self.scaleView setScale:(tmpBoardIndex-1)];
    }
}

- (void)scaleBigger {
    int tmpBoardIndex = [self.scaleView getBoardIndex];
//    NSLog(@"0: %d", tmpBoardIndex);
    if (4==tmpBoardIndex) {
        ERROR_HUD(MAX_HINT);
    } else {
        [self.scaleView setScale:(tmpBoardIndex+1)];
//        NSLog(@"02 scale: %f", tmpScale);
    }
}

- (void)alert
{
    ERROR_HUD(NETWORK_ERROR);
}

- (void)displayerWillRefresh:(id<DisplayerDataSource>) dataSouce_
{
    
    CGImageRef image = [[BoardModel SharedBoard] getData:self.boardIndex];
//    NSLog(@"start to refresh canvas.");
    [self.snapshotListVC_.snapshotCurrentBtn_ setBackgroundImage:[UIImage imageWithCGImage:image] forState:UIControlStateNormal];
    [self.scaleView setImage:image];

//    NSString *aPath=[NSString stringWithFormat:@"/Users/xujack/%@.jpg",@"test"];
//    NSData *imgData = UIImageJPEGRepresentation([UIImage imageWithCGImage:image],0);
//    [imgData writeToFile:aPath atomically:YES];
    
    CGImageRelease(image);

}

- (void)scaleDisplayer:(float)scale
{
    [self.scaleView scaleTo:scale];
}

- (void)moveDisplayerX:(int) x withY:(int)y
{
}

- (bool)startMeeting:(NSString *)meetingCode withUserName:(NSString *)userName
{
    [[BoardModel SharedBoard]attachCanvas:self.scaleView];
     self.opQ_ = [[OwbClientOperationQueue alloc] init];
    [[QueueHandler SharedQueueHandler] setMeetingCode:meetingCode];
    [[QueueHandler SharedQueueHandler] attachQueue:self.opQ_];
    [[BoardModel SharedBoard] attachOpeartionQueue:self.opQ_];
    [HBController SharedHBController].hbDelegate_ = self;
    [[HBController SharedHBController] hearHBWithUserName:userName withMeetingCode:meetingCode];    
    
    return [self setBoardLatedDoc:meetingCode withTriedTimes:0];
    
//    self.scaleView.drawable = true;
    //    self.scaleView.drawable = [[BoardModel SharedBoard] inHostMode_];
}

- (bool) setBoardLatedDoc:(NSString *)meetingCode withTriedTimes:(int)times
{
    BOOL _return = NO;
    try {
        OwbClientDocument *latestSnapshot = [[OwbClientServerDelegate sharedServerDelegate] getLatestDocument:meetingCode];
//        NSLog(@"latest snapshot: %d", latestSnapshot.serialNumber_);
        [[QueueHandler SharedQueueHandler]setLatestSeriaNumber:latestSnapshot.serialNumber_];
        [[BoardModel SharedBoard] loadDocumentSync:latestSnapshot];
        [self.view addSubview:self.scaleView];
        [self.view sendSubviewToBack:self.scaleView];
        [self.scaleView display];
        _return = YES;
    } catch (std::exception e) {
        if (times>=MAX_TIMES) {
            [[HBController SharedHBController] stopHear];
            return NO;
        }
        _return = [self setBoardLatedDoc:meetingCode withTriedTimes:++times];
    }
    return _return;
}

@end
