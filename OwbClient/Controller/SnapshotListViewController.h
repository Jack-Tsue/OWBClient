//
//  SnapshotListViewController.h
//  OwbClient
//
//  Created by Jack on 21/4/13.
//  Copyright (c) 2013 tsgsz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OwbCommon.h"

@interface SnapshotListViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong) UIButton *snapshotCurrentBtn_;
//- (void)setSnapshotList:(SnapshotList *)list;
@end
