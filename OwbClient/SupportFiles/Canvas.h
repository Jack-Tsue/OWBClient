//
//  Canvas.h
//  OwbClient
//
//  Created by Jack on 17/4/13.
//  Copyright (c) 2013 tsgsz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OperationQueue.h"

@protocol DisplayerDataSource <NSObject>

- (CGImageRef)getData;
- (CGImageRef)getLatestSnapshot;

@end

@protocol DisplayerDelegate <NSObject>

- (CGImageRef)displayerWillRefresh:(id<DisplayerDataSource>) dataSouce_;
- (void)scaleDisplayer:(float)scale;
- (void)moveDisplayerX:(int) x withY:(int)y;

@end

@protocol DrawerDelegate <NSObject>

- (void)attachQueue:(OperationQueue *)queue;
//- (void)writeToQueue:(OwbClientOperation *)operation;

@end

@interface Canvas : NSObject{
@private
    id<DisplayerDataSource> dataSouce_;
    id<DisplayerDelegate> displayDelegate_;
    id<DrawerDelegate> drawerDelegate_;
}
- (void)display;
@end