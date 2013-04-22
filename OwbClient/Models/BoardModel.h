/*************************************************************************
     ** File Name: BoardModel.h
    ** Author: tsgsz
    ** Mail: cdtsgsz@gmail.com
    ** Created Time: Tue Apr 16 20:07:05 2013
    **Copyright [2013] <Copyright tsgsz>  [legal/copyright]
 ************************************************************************/
#ifndef KINGSLANDING_ONLINEWHITEBOARD_CLIENT_MODELS_BOARDMODEL_H_
#define KINGSLANDING_ONLINEWHITEBOARD_CLIENT_MODELS_BOARDMODEL_H_

#import "../View/Canvas.h"
#import "./MessageModel.h"
#import "../DataStructrue/OpeationQueue"

@interface BoardModel : NSObject <DisplayerDataSource> {
@private
    Canvas* displayer;
}
+ (BoardModel*) OwbClientBoardWithCanvas :(Canvas*) canvas;
- (void) attachOpeartionQueue : (OperationQueue*);
- (void) loadDocument : (Document*) doucument;
- (void) trigerDrawSelf;   //从animation queue里面读取，通知displayer显示
- (void) trigerReadOperationQueue;
@property (nonatomic) bool inHostMode_;
@end

#endif  // KINGSLANDING_ONLINEWHITEBOARD_CLIENT_MODELS_BOARDMODEL_H_
