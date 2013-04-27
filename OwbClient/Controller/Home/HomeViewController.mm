//
//  HomeViewController.m
//  OwbClient
//
//  Created by  tsgsz on 4/7/13.
//  Copyright (c) 2013 tsgsz. All rights reserved.
//

#import "HomeViewController.h"
#import "LoginViewController.h"
#import "MeetingCodeViewController.h"
#import "CanvasViewController.h"

@interface HomeViewController()

@property (strong, nonatomic) LoginViewController *loginViewController_;
@property (strong, nonatomic) MeetingCodeViewController *createMeetingCodeView_;
@property (strong, nonatomic) MeetingCodeViewController *joinMeetingCodeView_;
@property (strong, nonatomic) CanvasViewController *canvasView_;

@property (strong, nonatomic) UIButton *loginBtn;
@property (strong, nonatomic) UIButton *createBtn;
@property (strong, nonatomic) UIButton *joinBtn;

@end

@implementation HomeViewController

- (void)loadView
{
    NSLog(@"FUCK");
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background.jpg"]];
    [self.view setBackgroundColor:background];
    
    // login view
    self.loginViewController_ = [[LoginViewController alloc]initWithStyle:UITableViewStyleGrouped];
    [self.view addSubview:self.loginViewController_.view];
    [self.loginViewController_.view setHidden:YES];
    
    // create meeting code view
    self.createMeetingCodeView_ = [[MeetingCodeViewController alloc]initWithStyle:UITableViewStyleGrouped withType:CREATE_BTN_STR];
    [self.view addSubview:self.createMeetingCodeView_.view];
    [self.createMeetingCodeView_.view setHidden:YES];
    
    // join meeting code view
    self.joinMeetingCodeView_ = [[MeetingCodeViewController alloc]initWithStyle:UITableViewStyleGrouped withType:JOIN_BTN_STR];
    [self.view addSubview:self.joinMeetingCodeView_.view];
    [self.joinMeetingCodeView_.view setHidden:YES];

    // buttons
    self.loginBtn = [[UIButton alloc] initWithFrame:LOGIN_BTN_FRAME];
    [self.loginBtn setBackgroundImage:[UIImage imageNamed:@"login.png"] forState:UIControlStateNormal];
    [self.loginBtn addTarget:self action:@selector(loginBtnPress:) forControlEvents:UIControlEventTouchUpInside];
    self.createBtn = [[UIButton alloc] initWithFrame:CREATE_BTN_FRAME];
    [self.createBtn setBackgroundImage:[UIImage imageNamed:@"create.png"] forState:UIControlStateNormal];
    [self.createBtn setBackgroundImage:[UIImage imageNamed:@"createHighlight.png"] forState:UIControlStateHighlighted];
    [self.createBtn addTarget:self action:@selector(createBtnPress:) forControlEvents:UIControlEventTouchUpInside];
    self.joinBtn = [[UIButton alloc] initWithFrame:JOIN_BTN_FRAME];
    [self.joinBtn setBackgroundImage:[UIImage imageNamed:@"join.png"] forState:UIControlStateNormal];
    [self.joinBtn addTarget:self action:@selector(joinBtnPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginBtn];
    [self.view addSubview:self.createBtn];
    [self.view addSubview:self.joinBtn];

    // canvas
    self.canvasView_ =[[CanvasViewController alloc] init];
    [self.view addSubview:self.canvasView_.view];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

#pragma mark - btn action listeners
- (void)loginBtnPress:(id) sender
{
    if (self.loginViewController_.view.isHidden == YES) {
        [self.createMeetingCodeView_.view setHidden:YES];
        [self.joinMeetingCodeView_.view setHidden:YES];
        [self.loginViewController_.view setAlpha:0];
        [self.loginViewController_.view setHidden:NO];
        [UIView animateWithDuration:DURATION delay:0.0f options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationCurveLinear animations:^{
            [self.loginViewController_.view setAlpha:1];
        } completion:^(BOOL finished) {
            
        }];
    } else {
        [UIView animateWithDuration:DURATION delay:0.0f options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseOut animations:^{
            
            self.canvasView_.view.frame = CANVAS_OPEN_FRAME;
        } completion:^(BOOL finished) {
            
        }];

    }
}

- (void)createBtnPress:(id) sender
{    
    [self.loginViewController_.view setHidden:YES];
    [self.joinMeetingCodeView_.view setHidden:YES];
    [self.createMeetingCodeView_.view setAlpha:0];
    [self.createMeetingCodeView_.view setHidden:NO];
    [UIView animateWithDuration:DURATION delay:0.0f options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationCurveLinear animations:^{
        [self.createMeetingCodeView_.view setAlpha:1];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)joinBtnPress:(id) sender
{
    [self.loginViewController_.view setHidden:YES];
    [self.createMeetingCodeView_.view setHidden:YES];
    [self.joinMeetingCodeView_.view setAlpha:0];
    [self.joinMeetingCodeView_.view setHidden:NO];
    [UIView animateWithDuration:DURATION delay:0.0f options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationCurveLinear animations:^{
        [self.joinMeetingCodeView_.view setAlpha:1];
    } completion:^(BOOL finished) {
        
    }];
}
@end
