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
@property (strong, nonatomic) MenuViewController *menuVC_;
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
- (void)alert
{
    ERROR_HUD(NETWORK_ERROR);
}

- (void)displayerWillRefresh:(id<DisplayerDataSource>) dataSouce_
{
    NSLog(@"start to refresh canvas.");
    [self.snapshotListVC_.snapshotCurrentBtn_ setBackgroundImage:[UIImage imageWithCGImage:[[BoardModel SharedBoard] getData]] forState:UIControlStateNormal];
    [self.scaleView setImage:[[BoardModel SharedBoard] getData]];
//    NSString *aPath=[NSString stringWithFormat:@"/Users/xujack/%@.jpg",@"test"];
//    NSData *imgData = UIImageJPEGRepresentation([UIImage imageWithCGImage:[[BoardModel SharedBoard] getData]],0);
//    [imgData writeToFile:aPath atomically:YES];
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
    [[BoardModel SharedBoard]attachCanvas:self.scaleView];
     self.opQ_ = [[OwbClientOperationQueue alloc] init];
    
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
//        OwbClientDocument *latestSnapshot = [[OwbClientServerDelegate sharedServerDelegate] getLatestDocument:meetingCode];
//        [[BoardModel SharedBoard] loadDocument:latestSnapshot];
        [self.view addSubview:self.scaleView];
        [self.view sendSubviewToBack:self.scaleView];
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
