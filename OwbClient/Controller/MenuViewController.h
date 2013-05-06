//
//  MenuViewController.h
//  OwbClient
//
//  Created by Jack on 21/4/13.
//  Copyright (c) 2013 tsgsz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OwbCommon.h"
#import "OperationWrapper.h"

@protocol MoveDelegate <NSObject>

- (void)setMovable;

@end

@interface MenuViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic, strong) UIPickerView *colorThicknessAlphaPicker_;
@property (nonatomic, retain) id<MoveDelegate> moveDelegate_;
@end