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
@class OwbClientOperationQueue;

@interface BoardModel : NSObject <DisplayerDataSource> {
@private
    CGContextRef context_;
    CGImageRef latestSnapshot_;
    CGImageRef currentContext_;
    Canvas* displayer_;
    OwbClientOperationQueue* operationQueue_;
    bool isReading_;
    bool isDrawing_;
    OwbClientOperationQueue* realOperationQueue_;
    bool _inHostMode_;
}
+ (BoardModel *) SharedBoard;
- (void) attachCanvas:(Canvas* ) canvas;
- (void) attachOpeartionQueue:(OwbClientOperationQueue *) operationQueue;
- (void) loadDocument:(OwbClientDocument *) doucument;
- (void) trigerReadOperationQueue;
- (void) drawMiddleOperation:(OwbClientOperation*) operation;
- (void) drawOperation:(OwbClientOperation *)operation;
@property (assign) bool inHostMode_;
@end

#endif  // KINGSLANDING_ONLINEWHITEBOARD_CLIENT_MODELS_BOARDMODEL_H_
