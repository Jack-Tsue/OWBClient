//
//  MeetingCodeViewController.m
//  OwbClient
//
//  Created by Jack on 12/4/13.
//  Copyright (c) 2013 tsgsz. All rights reserved.
//

#import "MeetingCodeViewController.h"

@interface MeetingCodeViewController ()
@property  (nonatomic,strong) NSString *btnLabelStr_;
@end

@implementation MeetingCodeViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.tableView.scrollEnabled = NO;
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style withType:(NSString *)type
{
    self = [self initWithStyle:style];
    self.btnLabelStr_ = type;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.frame = LOGIN_VIEW_FRAME;
    self.tableView.backgroundView = [[UIView alloc] initWithFrame:self.tableView.bounds];
    self.tableView.backgroundView.backgroundColor = [UIColor clearColor];
    [self.tableView setBackgroundColor:[UIColor clearColor]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    UITextField *textField = [[UITextField alloc]initWithFrame:MEETING_CODE_FRAME];
    [textField setBorderStyle:UITextBorderStyleNone];
    textField.returnKeyType = UIReturnKeyDone;
    textField.delegate = self;
    if (self.btnLabelStr_ == CREATE_BTN_STR) {
        [textField setUserInteractionEnabled:NO];
    }
    [cell.contentView addSubview:textField];
    
    UIButton *codeBtn = [[UIButton alloc] initWithFrame:MEETING_CODE_BTN_FRAME];
    [codeBtn setTitle:self.btnLabelStr_ forState:UIControlStateNormal];
    [codeBtn setBackgroundColor:[UIColor blackColor]];
    [cell.contentView addSubview:codeBtn];
    
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
