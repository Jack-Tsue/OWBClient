/*************************************************************************
 ** File Name: Canvas.h
 ** Author: tsgsz
 ** Mail: cdtsgsz@gmail.com
 ** Created Time: Mon Apr 22 21:40:05 2013
 **Copyright [2013] <Copyright tsgsz>  [legal/copyright]
 ************************************************************************/

#import <Foundation/Foundation.h>
#import "../Tools/OperationQueue.h"

@protocol DisplayerDataSource <NSObject>

- (CGImageRef)getData;
- (CGImageRef)getLatestSnapshot;
- (void)saveSnapshot;

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
    id<DisplayerDataSource> dataSource_;
    id<DisplayerDelegate> displayDelegate_;
    id<DrawerDelegate> drawerDelegate_;
}
- (void)display;
@end
