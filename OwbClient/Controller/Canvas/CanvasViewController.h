//
//  CanvasViewController.h
//  OwbClient
//
//  Created by Jack on 13/4/13.
//  Copyright (c) 2013 tsgsz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "common.h"
#import "Canvas.h"

@interface CanvasViewController : UIViewController <DisplayerDataSource, DisplayerDelegate, DrawerDelegate>
@property(nonatomic, strong) Canvas *canvas;
@end
