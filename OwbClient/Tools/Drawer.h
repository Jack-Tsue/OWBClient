/*************************************************************************
     ** File Name: Drawer.h
    ** Author: tsgsz
    ** Mail: cdtsgsz@gmail.com
    ** Created Time: Wed Apr 17 14:25:42 2013
    **Copyright [2013] <Copyright tsgsz>  [legal/copyright]
 ************************************************************************/
#ifndef KINGSLANDING_ONLINEWHITEBOARD_CLIENT_TOOLS_DRAWER_H_
#define KINGSLANDING_ONLINEWHITEBOARD_CLIENT_TOOLS_DRAWER_H_

#import "../Models/MessageModel.h"

@protocol OwbClientDrawer <NSObject>
@required
    void draw(CGContextRef* canvas, OwbClientOpeartion* opeartion);
@end

@interface LineDrawer : NSObject <OwbClientDrawer>
@end

@interface EllipseDrawer : NSObject <OwbClientDrawer>
@end

@interface RectangeDrawer : NSObject <OwbClientDrawer>
@end

@interface PointDrawer : NSObject <OwbClientDrawer>
@end

@interface Earser : NSObject <OwbClientDrawer>
@end

#endif  // KINGSLANDING_ONLINEWHITEBOARD_CLIENT_TOOLS_DRAWER_H_
