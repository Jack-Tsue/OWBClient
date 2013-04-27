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

@class OperationQueue;

@interface BoardModel : NSObject <DisplayerDataSource> {
@private
    CGContextRef context_;
    CGImageRef latestSnapshot_;
    Canvas* displayer_;
    OperationQueue* operationQueue_;
    bool isReading_;
    bool isDrawing_;
    OperationQueue* realOperationQueue_;
}
+ (BoardModel *) SharedBoard;
- (void) attachCanvas:(Canvas* ) canvas;
- (void) attachOpeartionQueue:(OperationQueue *) operationQueue;
- (void) loadDocument:(OwbClientDocument *) doucument;
- (void) trigerDrawSelf;   //从animation queue里面读取，通知displayer显示
- (void) trigerReadOperationQueue;
- (void) drawMiddleOperation:(OwbClientOperation*) operation;
- (void) drawOperation:(OwbClientOperation *)operation;
@property bool inHostMode_;
@end

#endif  // KINGSLANDING_ONLINEWHITEBOARD_CLIENT_MODELS_BOARDMODEL_H_
