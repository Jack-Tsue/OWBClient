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
@property (strong, nonatomic) UIView *userListView_;
@property (strong, nonatomic) UIView *snapshotListView_;

@end

@implementation CanvasViewController

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:CANVAS_DEFAULT_FRAME];
    
    // menu
    self.menuView_ = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default.png"]];
    self.menuView_.frame = MENU_FRAME;
    UIPanGestureRecognizer *menuGestureRecognizer = [[UIPanGestureRecognizer alloc]
                                                    initWithTarget:self  
                                                    action:@selector(handleMenuPan:)];
    [self.menuView_ setUserInteractionEnabled:YES];
    [self.menuView_ addGestureRecognizer:menuGestureRecognizer];
    [self.view setBackgroundColor:[UIColor whiteColor]];  
    [self.view addSubview:self.menuView_];
    
    // user list
    self.userListView_ = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default.png"]];
    self.userListView_.frame = USER_LIST_FRAME;
    UIPanGestureRecognizer *userListGestureRecognizer = [[UIPanGestureRecognizer alloc]
                                                    initWithTarget:self  
                                                    action:@selector(handleUserListPan:)];
    [self.userListView_ setUserInteractionEnabled:YES];
    [self.userListView_ addGestureRecognizer:userListGestureRecognizer];
    [self.view setBackgroundColor:[UIColor whiteColor]];  
    [self.view addSubview:self.userListView_];
    
    // snapshot list
    self.snapshotListView_ = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default.png"]];
    self.snapshotListView_.frame = SNAP_LIST_FRAME;
    UIPanGestureRecognizer *snapListGestureRecognizer = [[UIPanGestureRecognizer alloc]
                                                         initWithTarget:self  
                                                         action:@selector(handleSnapListPan:)];
    [self.snapshotListView_ setUserInteractionEnabled:YES];
    [self.snapshotListView_ addGestureRecognizer:snapListGestureRecognizer];
    [self.view setBackgroundColor:[UIColor whiteColor]];  
    [self.view addSubview:self.snapshotListView_];
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

# pragma mark - gesture handlers
- (void) handleMenuPan:(UIPanGestureRecognizer*) recognizer
{
    if( ([recognizer state] == UIGestureRecognizerStateBegan) ||
       ([recognizer state] == UIGestureRecognizerStateChanged) )
    {
        CGPoint movement = [recognizer translationInView:self.view];
        CGRect oldRect = self.menuView_.frame;
        
        oldRect.origin.y = oldRect.origin.y + movement.y;
        if(oldRect.origin.y < MENU_OPEN_FRAME.origin.y)
        {
            self.menuView_.frame = MENU_OPEN_FRAME;
        }
        else if(oldRect.origin.y > MENU_CLOSE_FRAME.origin.y)
        {
            self.menuView_.frame = MENU_CLOSE_FRAME;
        }
        else
        {
            self.menuView_.frame = oldRect;
        }
        
        [recognizer setTranslation:CGPointZero inView:self.view];
    }
    else if(recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled)
    {
        CGFloat halfPoint = (MENU_CLOSE_FRAME.origin.y + MENU_OPEN_FRAME.origin.y)/ 2;
        if(self.menuView_.frame.origin.y > halfPoint)
        {
            [UIView animateWithDuration:DURATION delay:0.0f options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseOut animations:^{
                
                self.menuView_.frame = MENU_CLOSE_FRAME;
            } completion:^(BOOL finished) {
                
            }];
        }
        else
        {
            [UIView animateWithDuration:DURATION delay:0.0f options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseOut animations:^{
                
                self.menuView_.frame = MENU_OPEN_FRAME;
            } completion:^(BOOL finished) {
                
            }];
        }
    }
}

- (void) handleUserListPan:(UIPanGestureRecognizer*) recognizer
{
    if( ([recognizer state] == UIGestureRecognizerStateBegan) ||
       ([recognizer state] == UIGestureRecognizerStateChanged) )
    {
        CGPoint movement = [recognizer translationInView:self.view];
        CGRect oldRect = self.userListView_.frame;
        
        oldRect.origin.x = oldRect.origin.x + movement.x;
        if(oldRect.origin.x > USER_LIST_OPEN_FRAME.origin.x)
        {
            self.userListView_.frame = USER_LIST_OPEN_FRAME;
        }
        else if(oldRect.origin.x < USER_LIST_CLOSE_FRAME.origin.x)
        {
            self.userListView_.frame = USER_LIST_CLOSE_FRAME;
        }
        else
        {
            self.userListView_.frame = oldRect;
        }
        
        [recognizer setTranslation:CGPointZero inView:self.view];
    }
    else if(recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled)
    {
        CGFloat halfPoint = (USER_LIST_CLOSE_FRAME.origin.x + USER_LIST_OPEN_FRAME.origin.x)/ 2;
        if(self.userListView_.frame.origin.x < halfPoint)
        {
            [UIView animateWithDuration:DURATION delay:0.0f options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseOut animations:^{
                
                self.userListView_.frame = USER_LIST_CLOSE_FRAME;
            } completion:^(BOOL finished) {
                
            }];
        }
        else
        {
            [UIView animateWithDuration:DURATION delay:0.0f options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseOut animations:^{
                
                self.userListView_.frame = USER_LIST_OPEN_FRAME;
            } completion:^(BOOL finished) {
                
            }];
        }
    }
}

- (void) handleSnapListPan:(UIPanGestureRecognizer*) recognizer
{
    if( ([recognizer state] == UIGestureRecognizerStateBegan) ||
       ([recognizer state] == UIGestureRecognizerStateChanged) )
    {
        CGPoint movement = [recognizer translationInView:self.view];
        CGRect oldRect = self.snapshotListView_.frame;
        
        oldRect.origin.x = oldRect.origin.x + movement.x;
        if(oldRect.origin.x < SNAP_LIST_OPEN_FRAME.origin.x)
        {
            self.snapshotListView_.frame = SNAP_LIST_OPEN_FRAME;
        }
        else if(oldRect.origin.x > SNAP_LIST_CLOSE_FRAME.origin.x)
        {
            self.snapshotListView_.frame = SNAP_LIST_CLOSE_FRAME;
        }
        else
        {
            self.snapshotListView_.frame = oldRect;
        }
        
        [recognizer setTranslation:CGPointZero inView:self.view];
    }
    else if(recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled)
    {
        CGFloat halfPoint = (SNAP_LIST_CLOSE_FRAME.origin.x + SNAP_LIST_OPEN_FRAME.origin.x)/ 2;
        if(self.snapshotListView_.frame.origin.x > halfPoint)
        {
            [UIView animateWithDuration:DURATION delay:0.0f options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseOut animations:^{
                
                self.snapshotListView_.frame = SNAP_LIST_CLOSE_FRAME;
            } completion:^(BOOL finished) {
                
            }];
        }
        else
        {
            [UIView animateWithDuration:DURATION delay:0.0f options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseOut animations:^{
                
                self.snapshotListView_.frame = SNAP_LIST_OPEN_FRAME;
            } completion:^(BOOL finished) {
                
            }];
        }
    }
}

@end
