/*************************************************************************
     ** File Name: Drawer.h
    ** Author: tsgsz
    ** Mail: cdtsgsz@gmail.com
    ** Created Time: Wed Apr 17 14:25:42 2013
    **Copyright [2013] <Copyright tsgsz>  [legal/copyright]
 ************************************************************************/
#ifndef KINGSLANDING_ONLINEWHITEBOARD_CLIENT_TOOLS_DRAWER_H_
#define KINGSLANDING_ONLINEWHITEBOARD_CLIENT_TOOLS_DRAWER_H_

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@class OwbClientOperation;
@class OwbClientOperationQueue;

@protocol OwbClientDrawer <NSObject>
@required
- (void)draw:(OwbClientOperation *)operation InCanvas:(CGContextRef)canvas;
- (void)sliceOpertion:(OwbClientOperation *)operation IntoQueue:(OwbClientOperationQueue*) queue;

+ (id<OwbClientDrawer>) sharedOwbClientDrawer;

@optional
- (void)setIndex:(int) index;
@end

@interface LineDrawer : NSObject <OwbClientDrawer>
@end

@interface EllipseDrawer : NSObject <OwbClientDrawer>
@end

@interface RectangeDrawer : NSObject <OwbClientDrawer>
@end

@interface PointDrawer : NSObject <OwbClientDrawer>
{
    CGPoint* point1_;
    CGPoint* point2_;
    CGPoint* startPoint_;
    int index_;
}
@end

@interface Eraser : NSObject <OwbClientDrawer>
{
    CGPoint* point1_;
    CGPoint* point2_;
    CGPoint* startPoint_;
    int index_;
}
@end

#endif  // KINGSLANDING_ONLINEWHITEBOARD_CLIENT_TOOLS_DRAWER_H_
