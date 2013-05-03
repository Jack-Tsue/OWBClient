//
//  LoginViewController.h
//  OwbClient
//
//  Created by  tsgsz on 4/8/13.
//  Copyright (c) 2013 tsgsz. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "OwbCommon.h"

@interface LoginViewController : UITableViewController<UITextFieldDelegate>

@property (nonatomic, strong) NSString *userName_, *userPswd_;

@end
