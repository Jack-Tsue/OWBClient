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

@interface BoardModel : NSObject <DisplayerDataSource>
+ (BoardModel*) OwbClientBoard;
- (void) attachOpeartionQueue : (OperationQueue*);
- (void) loadDocument : (Document*) doucument;
@end

#endif  // KINGSLANDING_ONLINEWHITEBOARD_CLIENT_MODELS_BOARDMODEL_H_
