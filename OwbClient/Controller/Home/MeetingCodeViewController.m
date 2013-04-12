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
    [textField setBorderStyle:UITextBorderStyleRoundedRect];
    textField.returnKeyType = UIReturnKeyDone;
    textField.delegate = self;
    [cell.contentView addSubview:textField];
    
    UIButton *codeBtn = [[UIButton alloc] initWithFrame:MEETING_CODE_BTN_FRAME];
    [codeBtn setTitle:self.btnLabelStr_ forState:UIControlStateNormal];
    [cell.contentView addSubview:codeBtn];
    
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

@end
