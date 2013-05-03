/*************************************************************************
     ** File Name: BoardModel.h
    ** Author: tsgsz
    ** Mail: cdtsgsz@gmail.com
    ** Created Time: Tue Apr 16 20:07:05 2013
    **Copyright [2013] <Copyright tsgsz>  [legal/copyright]
 ************************************************************************/
#ifndef KINGSLANDING_ONLINEWHITEBOARD_CLIENT_MODELS_BOARDMODEL_H_
#define KINGSLANDING_ONLINEWHITEBOARD_CLIENT_MODELS_BOARDMODEL_H_

#import <CoreGraphics/CoreGraphics.h>

@protocol DisplayerDataSource <NSObject>

- (CGImageRef)getData;
- (CGImageRef)getLatestSnapshot;
- (void)saveSnapshot;

@end

@class Canvas;
@class OwbClientDocument;
@class OwbClientOperation;
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
    bool _inHostMode_;
}
+ (BoardModel *) SharedBoard;
- (void) attachCanvas:(Canvas* ) canvas;
- (void) attachOpeartionQueue:(OperationQueue *) operationQueue;
- (void) loadDocument:(OwbClientDocument *) doucument;
- (void) trigerReadOperationQueue;
- (void) drawMiddleOperation:(OwbClientOperation*) operation;
- (void) drawOperation:(OwbClientOperation *)operation;
@property (assign) bool inHostMode_;
@end

#endif  // KINGSLANDING_ONLINEWHITEBOARD_CLIENT_MODELS_BOARDMODEL_H_
