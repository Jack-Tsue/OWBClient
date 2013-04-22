//
//  MenuViewController.m
//  OwbClient
//
//  Created by Jack on 21/4/13.
//  Copyright (c) 2013 tsgsz. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (id)init
{
    if (self) {
        [self.view setBackgroundColor:[UIColor lightGrayColor]];
        self.view.frame = MENU_FRAME;
        UIPanGestureRecognizer *menuGestureRecognizer = [[UIPanGestureRecognizer alloc]
                                                         initWithTarget:self  
                                                         action:@selector(handleMenuPan:)];
        [self.view setUserInteractionEnabled:YES];
        [self.view addGestureRecognizer:menuGestureRecognizer];
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

# pragma mark - gesture handler
- (void) handleMenuPan:(UIPanGestureRecognizer*) recognizer
{
    if( ([recognizer state] == UIGestureRecognizerStateBegan) ||
       ([recognizer state] == UIGestureRecognizerStateChanged) )
    {
        CGPoint movement = [recognizer translationInView:self.view];
        CGRect oldRect = self.view.frame;
        
        oldRect.origin.y = oldRect.origin.y + movement.y;
        if(oldRect.origin.y < MENU_OPEN_FRAME.origin.y)
        {
            self.view.frame = MENU_OPEN_FRAME;
        }
        else if(oldRect.origin.y > MENU_CLOSE_FRAME.origin.y)
        {
            self.view.frame = MENU_CLOSE_FRAME;
        }
        else
        {
            self.view.frame = oldRect;
        }
        
        [recognizer setTranslation:CGPointZero inView:self.view];
    }
    else if(recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled)
    {
        CGFloat halfPoint = (MENU_CLOSE_FRAME.origin.y + MENU_OPEN_FRAME.origin.y)/ 2;
        if(self.view.frame.origin.y > halfPoint)
        {
            [UIView animateWithDuration:DURATION delay:0.0f options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseOut animations:^{
                
                self.view.frame = MENU_CLOSE_FRAME;
            } completion:^(BOOL finished) {
                
            }];
        }
        else
        {
            [UIView animateWithDuration:DURATION delay:0.0f options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseOut animations:^{
                
                self.view.frame = MENU_OPEN_FRAME;
            } completion:^(BOOL finished) {
                
            }];
        }
    }
}

@end
