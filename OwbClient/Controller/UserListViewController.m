//
//  UserListViewController.m
//  OwbClient
//
//  Created by Jack on 21/4/13.
//  Copyright (c) 2013 tsgsz. All rights reserved.
//

#import "UserListViewController.h"

@interface UserListViewController ()

@end

@implementation UserListViewController

- (id)init
{
    if (self) {
        self.view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default.png"]];
        self.view.frame = USER_LIST_FRAME;
        UIPanGestureRecognizer *userListGestureRecognizer = [[UIPanGestureRecognizer alloc]
                                                             initWithTarget:self  
                                                             action:@selector(handleUserListPan:)];
        [self.view setUserInteractionEnabled:YES];
        [self.view addGestureRecognizer:userListGestureRecognizer];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

# pragma mark - guesture handler
- (void) handleUserListPan:(UIPanGestureRecognizer*) recognizer
{
    if( ([recognizer state] == UIGestureRecognizerStateBegan) ||
       ([recognizer state] == UIGestureRecognizerStateChanged) )
    {
        CGPoint movement = [recognizer translationInView:self.view];
        CGRect oldRect = self.view.frame;
        
        oldRect.origin.x = oldRect.origin.x + movement.x;
        if(oldRect.origin.x > USER_LIST_OPEN_FRAME.origin.x)
        {
            self.view.frame = USER_LIST_OPEN_FRAME;
        }
        else if(oldRect.origin.x < USER_LIST_CLOSE_FRAME.origin.x)
        {
            self.view.frame = USER_LIST_CLOSE_FRAME;
        }
        else
        {
            self.view.frame = oldRect;
        }
        
        [recognizer setTranslation:CGPointZero inView:self.view];
    }
    else if(recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled)
    {
        CGFloat halfPoint = (USER_LIST_CLOSE_FRAME.origin.x + USER_LIST_OPEN_FRAME.origin.x)/ 2;
        if(self.view.frame.origin.x < halfPoint)
        {
            [UIView animateWithDuration:DURATION delay:0.0f options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseOut animations:^{
                
                self.view.frame = USER_LIST_CLOSE_FRAME;
            } completion:^(BOOL finished) {
                
            }];
        }
        else
        {
            [UIView animateWithDuration:DURATION delay:0.0f options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseOut animations:^{
                
                self.view.frame = USER_LIST_OPEN_FRAME;
            } completion:^(BOOL finished) {
                
            }];
        }
    }
}

@end
