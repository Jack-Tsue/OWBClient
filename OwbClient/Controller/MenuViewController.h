//
//  MenuViewController.h
//  OwbClient
//
//  Created by Jack on 21/4/13.
//  Copyright (c) 2013 tsgsz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OwbCommon.h"
#import "../OwbClientLib/Models/MessageModel.h"

@interface MenuViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>

- (OwbClientOperation *)operationInit;
- (int)operationType;

@end
