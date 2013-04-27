//
//  CanvasViewController.h
//  OwbClient
//
//  Created by Jack on 13/4/13.
//  Copyright (c) 2013 tsgsz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OwbCommon.h"
#import "Canvas.h"
#import "MenuViewController.h"
#import "UserListViewController.h"
#import "SnapshotListViewController.h"
#import "/Users/xujack/OWBClient/OwbClient/OwbClientLib/Tools/OperationQueue.h"

@interface CanvasViewController : UIViewController {
@private
    bool isDrawFromServer;
}

- (bool)switchDrawMethods;

@property(nonatomic, strong) Canvas *canvas;

@end
