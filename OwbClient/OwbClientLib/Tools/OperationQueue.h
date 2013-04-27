/*************************************************************************
     ** File Name: Models.h
    ** Author: tsgsz
    ** Mail: cdtsgsz@gmail.com
    ** Created Time: Tue Apr 16 14:29:39 2013
    **Copyright [2013] <Copyright tsgsz>  [legal/copyright]
 ************************************************************************/
#ifndef KINGSLANDING_ONLINEWHITEBOARD_CLIENT_TOOLS_OPERATION_H_
#define KINGSLANDING_ONLINEWHITEBOARD_CLIENT_TOOLS_OPERATION_H_

#import <Foundation/Foundation.h>

@class OwbClientOperation;

@interface OperationQueue : NSObject {
@private
    NSMutableArray *operations_;
    NSLock *enqueueLocker_;
    NSLock *dequeueLocker_;
    bool _writable_;
    NSString* _meetingId_;
    int _latestSerialNumber_;
}

- (void)enqueue:(OwbClientOperation *)operation;
- (OwbClientOperation *)dequeue;
- (bool)isEmpty;
- (OwbClientOperation *)getHead;
- (bool)getServerData;
- (void)lock;
- (void)unLock;

@property (assign) bool writable_;
@property (nonatomic, copy) NSString* meetingId_;
@property (assign) int latestSerialNumber_;

@end

#endif  // KINGSLANDING_ONLINEWHITEBOARD_CLIENT_TOOLS_OPERATION_H_
