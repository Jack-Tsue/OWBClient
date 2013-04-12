//
//  HomeViewController.m
//  OwbClient
//
//  Created by  tsgsz on 4/7/13.
//  Copyright (c) 2013 tsgsz. All rights reserved.
//

#import "HomeViewController.h"
#import "LoginViewController.h"

@interface HomeViewController()

@property (strong, nonatomic) LoginViewController *login_view_controller_;

// test
@property (strong, nonatomic) UIView *testView_; 

@property (strong, nonatomic) UIButton *loginBtn;
@property (strong, nonatomic) UIButton *createBtn;
@property (strong, nonatomic) UIButton *joinBtn;

@end

@implementation HomeViewController

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.login_view_controller_ = [[LoginViewController alloc]initWithStyle:UITableViewStyleGrouped];
    [self.view addSubview:self.login_view_controller_.view];
    [self.login_view_controller_.view setHidden:YES];
    
    self.loginBtn = [[UIButton alloc] initWithFrame:LOGIN_BTN_FRAME];
    self.loginBtn.backgroundColor = [UIColor grayColor];
    [self.loginBtn addTarget:self action:@selector(loginBtnPress:) forControlEvents:UIControlEventTouchUpInside];
    self.createBtn = [[UIButton alloc] initWithFrame:CREATE_BTN_FRAME];
    self.createBtn.backgroundColor = [UIColor grayColor];
    self.joinBtn = [[UIButton alloc] initWithFrame:JOIN_BTN_FRAME];
    self.joinBtn.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.loginBtn];
    [self.view addSubview:self.createBtn];
    [self.view addSubview:self.joinBtn];
    
    // test
    self.testView_ = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default.png"]];
    self.testView_.frame = TESTVIEW_FRAME;
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]
                                                initWithTarget:self  
                                                action:@selector(handlePan:)];
    [self.testView_ setUserInteractionEnabled:YES];
    [self.testView_ addGestureRecognizer:panGestureRecognizer];
    [self.view setBackgroundColor:[UIColor whiteColor]];  
    [self.view addSubview:self.testView_];
    
}

# warning "just for test"
- (void) handlePan:(UIPanGestureRecognizer*) recognizer
{
    ;
    if( ([recognizer state] == UIGestureRecognizerStateBegan) ||
       ([recognizer state] == UIGestureRecognizerStateChanged) )
    {
        CGPoint movement = [recognizer translationInView:self.view];
        CGRect oldRect = self.testView_.frame;
        
        oldRect.origin.y = oldRect.origin.y + movement.y;
        if(oldRect.origin.y < TESTVIEW_OPEN_FRAME.origin.y)
        {
            self.testView_.frame = TESTVIEW_OPEN_FRAME;
        }
        else if(oldRect.origin.y > TESTVIEW_CLOSE_FRAME.origin.y)
        {
            self.testView_.frame = TESTVIEW_CLOSE_FRAME;
        }
        else
        {
            self.testView_.frame = oldRect;
        }
        
        [recognizer setTranslation:CGPointZero inView:self.view];
    }
    else if(recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled)
    {
        CGFloat halfPoint = (TESTVIEW_CLOSE_FRAME.origin.y + TESTVIEW_OPEN_FRAME.origin.y)/ 2;
        if(self.testView_.frame.origin.y > halfPoint)
        {
            [UIView animateWithDuration:DURATION delay:0.0f options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseOut animations:^{
                
                self.testView_.frame = TESTVIEW_CLOSE_FRAME;
            } completion:^(BOOL finished) {
                
            }];
        }
        else
        {
            [UIView animateWithDuration:DURATION delay:0.0f options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseOut animations:^{
                
                self.testView_.frame = TESTVIEW_OPEN_FRAME;
            } completion:^(BOOL finished) {
                
            }];
        }
    }
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
    if (self.login_view_controller_.view.isHidden == YES) {
        [self.login_view_controller_.view setHidden:NO];
    }
}

@end
