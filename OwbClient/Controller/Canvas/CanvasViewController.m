//
//  CanvasViewController.m
//  OwbClient
//
//  Created by Jack on 13/4/13.
//  Copyright (c) 2013 tsgsz. All rights reserved.
//

#import "CanvasViewController.h"

@interface CanvasViewController ()

@property (strong, nonatomic) UIView *menuView_;

@end

@implementation CanvasViewController

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:CANVAS_DEFAULT_FRAME];
    
    // menu
    self.menuView_ = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default.png"]];
    self.menuView_.frame = TESTVIEW_FRAME;
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]
                                                    initWithTarget:self  
                                                    action:@selector(handleMenuPan:)];
    [self.menuView_ setUserInteractionEnabled:YES];
    [self.menuView_ addGestureRecognizer:panGestureRecognizer];
    [self.view setBackgroundColor:[UIColor whiteColor]];  
    [self.view addSubview:self.menuView_];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

# pragma mark - gesture handlers
- (void) handleMenuPan:(UIPanGestureRecognizer*) recognizer
{
    ;
    if( ([recognizer state] == UIGestureRecognizerStateBegan) ||
       ([recognizer state] == UIGestureRecognizerStateChanged) )
    {
        CGPoint movement = [recognizer translationInView:self.view];
        CGRect oldRect = self.menuView_.frame;
        
        oldRect.origin.y = oldRect.origin.y + movement.y;
        if(oldRect.origin.y < TESTVIEW_OPEN_FRAME.origin.y)
        {
            self.menuView_.frame = TESTVIEW_OPEN_FRAME;
        }
        else if(oldRect.origin.y > TESTVIEW_CLOSE_FRAME.origin.y)
        {
            self.menuView_.frame = TESTVIEW_CLOSE_FRAME;
        }
        else
        {
            self.menuView_.frame = oldRect;
        }
        
        [recognizer setTranslation:CGPointZero inView:self.view];
    }
    else if(recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled)
    {
        CGFloat halfPoint = (TESTVIEW_CLOSE_FRAME.origin.y + TESTVIEW_OPEN_FRAME.origin.y)/ 2;
        if(self.menuView_.frame.origin.y > halfPoint)
        {
            [UIView animateWithDuration:DURATION delay:0.0f options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseOut animations:^{
                
                self.menuView_.frame = TESTVIEW_CLOSE_FRAME;
            } completion:^(BOOL finished) {
                
            }];
        }
        else
        {
            [UIView animateWithDuration:DURATION delay:0.0f options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseOut animations:^{
                
                self.menuView_.frame = TESTVIEW_OPEN_FRAME;
            } completion:^(BOOL finished) {
                
            }];
        }
    }
}
@end
