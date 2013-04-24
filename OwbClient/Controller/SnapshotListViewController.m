//
//  SnapshotListViewController.m
//  OwbClient
//
//  Created by Jack on 21/4/13.
//  Copyright (c) 2013 tsgsz. All rights reserved.
//

#import "SnapshotListViewController.h"

@interface SnapshotListViewController ()
@property CGImageRef currentSnapshot_;
@property(nonatomic, strong) UITableView *snapshotHistoryTable_;
@property(nonatomic, strong) UIButton *snapshotCurrentBtn_;
@property(nonatomic, strong) UIButton *saveSnapshotBtn_;
@end

@implementation SnapshotListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self) {
        self.view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default.png"]];
        self.view.frame = SNAP_LIST_FRAME;
        UIPanGestureRecognizer *snapListGestureRecognizer = [[UIPanGestureRecognizer alloc]
                                                             initWithTarget:self  
                                                             action:@selector(handleSnapListPan:)];
        [self.view setUserInteractionEnabled:YES];
        [self.view addGestureRecognizer:snapListGestureRecognizer];
        
        self.snapshotCurrentBtn_ = [[UIButton alloc] initWithFrame:SNAP_CUR_BTN_FRAME];
        [self.snapshotCurrentBtn_ setBackgroundColor:[UIColor grayColor]];
        [self.snapshotCurrentBtn_ addTarget:self action:@selector(currentSnapBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.snapshotCurrentBtn_];
        
        self.snapshotHistoryTable_ = [[UITableView alloc] initWithFrame:SNAP_HIS_TABLE_FRAME style:UITableViewStyleGrouped];
        self.snapshotHistoryTable_.backgroundColor = [UIColor clearColor];
        self.snapshotHistoryTable_.delegate = self;
        self.snapshotHistoryTable_.dataSource = self;
        [self.view addSubview:self.snapshotHistoryTable_];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

# pragma mark - guesture handler
- (void) handleSnapListPan:(UIPanGestureRecognizer*) recognizer
{
    if( ([recognizer state] == UIGestureRecognizerStateBegan) ||
       ([recognizer state] == UIGestureRecognizerStateChanged) )
    {
        CGPoint movement = [recognizer translationInView:self.view];
        CGRect oldRect = self.view.frame;
        
        oldRect.origin.x = oldRect.origin.x + movement.x;
        if(oldRect.origin.x < SNAP_LIST_OPEN_FRAME.origin.x)
        {
            self.view.frame = SNAP_LIST_OPEN_FRAME;
        }
        else if(oldRect.origin.x > SNAP_LIST_CLOSE_FRAME.origin.x)
        {
            self.view.frame = SNAP_LIST_CLOSE_FRAME;
        }
        else
        {
            self.view.frame = oldRect;
        }
        
        [recognizer setTranslation:CGPointZero inView:self.view];
    }
    else if(recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled)
    {
        CGFloat halfPoint = (SNAP_LIST_CLOSE_FRAME.origin.x + SNAP_LIST_OPEN_FRAME.origin.x)/ 2;
        if(self.view.frame.origin.x > halfPoint)
        {
            [UIView animateWithDuration:DURATION delay:0.0f options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseOut animations:^{
                
                self.view.frame = SNAP_LIST_CLOSE_FRAME;
            } completion:^(BOOL finished) {
                
            }];
        }
        else
        {
            [UIView animateWithDuration:DURATION delay:0.0f options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseOut animations:^{
                
                self.view.frame = SNAP_LIST_OPEN_FRAME;
            } completion:^(BOOL finished) {
                
            }];
        }
    }
}

#pragma mark - Table view data source and delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning get from snapshot list
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
#warning image should get from snapshot list
//        cell.backgroundView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"cell_normal.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:0.0]];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SNAP_CELL_HEIGHT;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return TABLE_HEADER_HEIGHT;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerView = [[UIView alloc] initWithFrame:TABLE_HEADER_FRAME];
    headerView.backgroundColor = [UIColor clearColor];
    UILabel *HeaderLabel = [[UILabel alloc] initWithFrame:TABLE_HEADER_FRAME];
    HeaderLabel.backgroundColor = [UIColor clearColor];
    HeaderLabel.font = [UIFont boldSystemFontOfSize:TABLE_HEADER_FONT_SIZE];
    HeaderLabel.textColor = [UIColor blackColor];
    HeaderLabel.text = SNAP_HEADER_LABEL;
    [headerView addSubview:HeaderLabel];    
    return headerView;
}

#pragma mark - btn handlers
- (void)currentSnapBtnPress:(id)sender
{
    NSLog(@"===");
}
@end
