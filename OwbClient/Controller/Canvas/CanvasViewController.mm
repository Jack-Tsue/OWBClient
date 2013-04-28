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

@property (strong, nonatomic) MenuViewController *menuVC_;
@property (strong, nonatomic) UserListViewController *userListVC_;
@property (strong, nonatomic) SnapshotListViewController *snapshotListVC_;
@property (strong, nonatomic) MoveScaleImageView *canvasView_;

@end

@implementation CanvasViewController

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:CANVAS_DEFAULT_FRAME];
    [self.view setBackgroundColor:[UIColor whiteColor]];  

    self.canvasView_ = [[MoveScaleImageView alloc] initWithFrame:CANVAS_OPEN_FRAME];
    self.canvasView_.displayerDelegate_ = self;
    self.canvasView_.drawerDelegate_ = self;
    
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

@end
