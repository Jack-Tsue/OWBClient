//
//  CanvasViewController.h
//  OwbClient
//
//  Created by Jack on 13/4/13.
//  Copyright (c) 2013 tsgsz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OwbCommon.h"
#import "MenuViewController.h"
#import "UserListViewController.h"
#import "SnapshotListViewController.h"
#import "../../OwbClientLib/View/Canvas.h"
#import "../../OwbClientLib/Models/BoardModel.h"

@interface CanvasViewController : UIViewController<DrawerDelegate, DisplayerDelegate> {
@private
    BoardModel *board;
    bool isDrawFromServer;
}

- (bool)switchDrawMethods;

@end
