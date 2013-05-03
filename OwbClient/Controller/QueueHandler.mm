//
//  QueueHandler.m
//  OwbClient
//
//  Created by Jack on 30/4/13.
//  Copyright (c) 2013 Jack. All rights reserved.
//

#import "QueueHandler.h"
static QueueHandler * instance;
@implementation QueueHandler

+ (QueueHandler *)SharedQueueHandler {
    if (nil == instance) {
        instance = [[QueueHandler alloc] init];
    }
    return instance;
}
- (void)attachQueue:(OperationQueue *)opQueue
{
    opQueue_ = opQueue;
}

- (void)startQueueGetDataBackgroundWithMeetingID:(NSString *)meetingID
{
    meetingCode_ = meetingID;
    [self performSelectorInBackground:@selector(getDataFromServer) withObject:nil];
}

- (void)getDataFromServer
{
    while (true) {
        if(shouldStop_) {
            break;
        }
        bool isSucToGetData;
        try {
            isSucToGetData = [opQueue_ getServerData];
        } catch (std::exception e) {
            NSLog(@"in QueueHandler.mm: get server data failed.");
        }
        if(isSucToGetData) {
            [[BoardModel SharedBoard] trigerReadOperationQueue];
        } else {
            OwbClientDocument *tmpDoc;
            try {
                tmpDoc = [[OwbClientServerDelegate sharedServerDelegate] getLatestDocument:meetingCode_];
            } catch (std::exception e) {
                NSLog(@"in QueueHandler.mm: get latest doc failed.");
            }
            [[BoardModel SharedBoard] loadDocument:tmpDoc];
        }
    }
}

- (void)stopQueueGetDataBackground
{
    shouldStop_ = YES;
}

- (void)drawOperationToServer:(OwbClientOperation *)op
{
    [opQueue_ enqueue:op];
    [self triggerWriteToServer];
}

- (void)triggerWriteToServer
{
    if(isWriting_) {
        [opQueue_ lock];
        if(![opQueue_ isEmpty]) {
            [self performSelectorInBackground:@selector(writeToServer) withObject:nil];
        }
        [opQueue_ unLock];
    } else {
        isWriting_ = YES;
        [self performSelectorInBackground:@selector(writeToServer) withObject:nil];
    }
}

- (void)writeToServer
{
    while (![opQueue_ isEmpty]) {
        OwbClientOperation *op = [opQueue_ dequeue];
        try {
            [[OwbClientServerDelegate sharedServerDelegate] sendOperation:op];
        } catch (std::exception e) {
            NSLog(@"in QueueHandler.mm: send operation failed.");
        }
    }
    isWriting_ = NO;
}
@end
