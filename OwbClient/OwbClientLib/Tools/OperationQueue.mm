/*************************************************************************
     ** File Name: OperationQueue.mm
    ** Author: tsgsz
    ** Mail: cdtsgsz@gmail.com
    ** Created Time: Mon Apr 22 14:16:31 2013
    **Copyright [2013] <Copyright tsgsz>  [legal/copyright]
 ************************************************************************/
#import "./OperationQueue.h"

#import "../Models/MessageModel.h"
#import "../NetWork/ServerDelegate.h"

typedef  Kingslanding::OnlineWhiteBoard::Client::NetWork::ServerDelegate ServerDelegate;

@implementation OperationQueue

@synthesize writable_ = _writable_;
@synthesize meetingId_ = _meetingId_;
@synthesize latestSerialNumber_ = _latestSerialNumber_;

- (id)init
{
    self = [super init];
    if(nil != self) 
    {
        operations_ = [[NSMutableArray alloc]init];
        enqueueLocker_ = [[NSLock alloc]init];
        dequeueLocker_ = [[NSLock alloc]init];
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
    if (nil != _meetingId_) {
        [_meetingId_ release];
    }
}

- (void)enqueue:(OwbClientOperation *)operation
{
    [enqueueLocker_ lock];
    [operations_ addObject : operation];
    self.latestSerialNumber_ = operation.serialNumber_;
    [enqueueLocker_ unlock];
}

- (OwbClientOperation *)dequeue
{
    [dequeueLocker_ lock];
    OwbClientOperation* operation = [operations_ objectAtIndex:0];
    [operations_ removeObject:operation];
    [dequeueLocker_ unlock];
    return operation;
}

- (bool)isEmpty
{
    return [operations_ count] == 0;
}

- (OwbClientOperation *)getHead
{
    return [operations_ objectAtIndex:0];
}

- (bool)getServerData
{
    ServerDelegate* server = ServerDelegate::GetInstance();
    Operations operations = server->GetOperations([self.meetingId_ UTF8String], self.latestSerialNumber_);

    if (!operations.operation_avaliable()) {
        return false;
    }
    OwbClientOperationList* operation_list = [[OwbClientOperationList alloc]initFromOperationList:&operations];
    [operations_ addObjectsFromArray:operation_list.operationList_];
    self.latestSerialNumber_ = ((OwbClientOperation *) [operation_list.operationList_ lastObject]).serialNumber_;
    return true;
}

- (void)lock
{
    [enqueueLocker_ lock];
    [dequeueLocker_ lock];
}

- (void)unLock
{
    [enqueueLocker_ unlock];
    [dequeueLocker_ unlock];
}

@end
