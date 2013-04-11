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

@property (strong, nonatomic) LoginViewController* login_view_controller_;

@property (strong, nonatomic) UIView *testView; // test

@end

@implementation HomeViewController

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.login_view_controller_ = [[LoginViewController alloc]initWithStyle:UITableViewStyleGrouped];
    [self.view addSubview:self.login_view_controller_.view];
    
    // test
    self.testView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default.png"]];
    self.testView.frame = CGRectMake(0, 726, 1024, 100);
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]
                                                initWithTarget:self  
                                                action:@selector(handlePan:)];
    [self.testView setUserInteractionEnabled:YES];
    [self.testView addGestureRecognizer:panGestureRecognizer];
    [self.view setBackgroundColor:[UIColor whiteColor]];  
    [self.view addSubview:self.testView];
    
}

# warning "just for test"
- (void) handlePan:(UIPanGestureRecognizer*) recognizer
{  
    /*
     CGPoint translation = [recognizer translationInView:self.view];
    if(recognizer.view.center.y + translation.y<=750) {
       recognizer.view.center = CGPointMake(512, recognizer.view.center.y + translation.y); 
    }
    [recognizer setTranslation:CGPointZero inView:self.view];  
    */
    CGRect openFrame = CGRectMake(0, 700, 1024, 100);
    CGRect closeFrame = CGRectMake(0, 726, 1024, 100);
    if( ([recognizer state] == UIGestureRecognizerStateBegan) ||
       ([recognizer state] == UIGestureRecognizerStateChanged) )
    {
        CGPoint movement = [recognizer translationInView:self.view];
        CGRect old_rect = self.testView.frame;
        
        old_rect.origin.y = old_rect.origin.y + movement.y;
        if(old_rect.origin.y < openFrame.origin.y)
        {
            self.testView.frame = openFrame;
        }
        else if(old_rect.origin.y > closeFrame.origin.y)
        {
            self.testView.frame = closeFrame;
        }
        else
        {
            self.testView.frame = old_rect;
        }
        
        [recognizer setTranslation:CGPointZero inView:self.view];
    }
    else if(recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled)
    {
        CGFloat halfPoint = (closeFrame.origin.y + openFrame.origin.y)/ 2;
        if(self.testView.frame.origin.y > halfPoint)
        {
            [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseOut animations:^{
                
                self.testView.frame = closeFrame;
            } completion:^(BOOL finished) {
                
            }];
        }
        else
        {
            [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseOut animations:^{
                
                self.testView.frame = openFrame;
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


@end
