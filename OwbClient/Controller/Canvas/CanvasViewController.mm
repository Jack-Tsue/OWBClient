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

@property (strong, nonatomic) MenuViewController *menuVC_;
@property (strong, nonatomic) UserListViewController *userListVC_;
@property (strong, nonatomic) SnapshotListViewController *snapshotListVC_;
@property (strong, nonatomic) OperationWrapper *wrapper_;
@property (strong, nonatomic) MoveScaleImageView *scaleView;
@end

@implementation CanvasViewController

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:CANVAS_DEFAULT_FRAME];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
//    UIImage* image=[UIImage imageNamed:@"background.jpg"];
    
//    [self.canvas_ initViewWithFrame:CANVAS_OPEN_FRAME withImage:image.CGImage];
//    
//    [self.view addSubview:self.canvas_.scaleImageView];
//    self.canvas_.scaleImageView.drawable = true;
    
    [self.view setUserInteractionEnabled:YES];
    [self.view setMultipleTouchEnabled:YES];
    
    self.canvas_.displayerDelegate_ = self;
    self.scaleView.drawerDelegate_ = [QueueHandler SharedQueueHandler];
    self.canvas_.dataSource_ = [BoardModel SharedBoard];
    [[BoardModel SharedBoard]attachCanvas:self.scaleView];
    
    // menu
    self.menuVC_ = [[MenuViewController alloc] init];
    [self.view addSubview:self.menuVC_.view];
    
    // user list
    self.userListVC_ = [[UserListViewController alloc] init];
    [self.view addSubview:self.userListVC_.view];
    
    // snapshot list
    self.snapshotListVC_ = [[SnapshotListViewController alloc] init];
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
- (void)alert
{
    ERROR_HUD(NETWORK_ERROR);
}

- (CGImageRef)displayerWillRefresh:(id<DisplayerDataSource>) dataSouce_
{
    return [self.scaleView resetImage:[[BoardModel SharedBoard] getData]];
}

- (void)scaleDisplayer:(float)scale
{
    [self.scaleView scaleTo:scale];
}

- (void)moveDisplayerX:(int) x withY:(int)y
{
    [self.canvas_.scaleImageView moveToX:x ToY:y];
}

- (bool)startMeeting:(NSString *)meetingCode withUserName:(NSString *)userName
{
    OperationQueue *opQ = [[OperationQueue alloc] init];
    [[QueueHandler SharedQueueHandler] attachQueue:opQ];
    [[BoardModel SharedBoard] attachOpeartionQueue:opQ];
    [HBController SharedHBController].hbDelegate_ = self;
    [[HBController SharedHBController] hearHBWithUserName:userName withMeetingCode:meetingCode];
    
    self.scaleView = [[MoveScaleImageView alloc]initWithFrame:CANVAS_OPEN_FRAME];
    
    return [self setBoardLatedDoc:meetingCode withTriedTimes:0];
    
//    self.scaleView.drawable = true;
    //    self.scaleView.drawable = [[BoardModel SharedBoard] inHostMode_];
}

- (bool) setBoardLatedDoc:(NSString *)meetingCode withTriedTimes:(int)times
{
    BOOL _return = NO;
    try {
        sleep(1000);
        OwbClientDocument *latestSnapshot = [[OwbClientServerDelegate sharedServerDelegate] getLatestDocument:meetingCode];
        [[BoardModel SharedBoard] loadDocument:latestSnapshot];
        [self.view addSubview:self.scaleView];
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
