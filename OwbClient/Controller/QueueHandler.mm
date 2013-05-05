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
- (void)dealloc
{
    [super dealloc];
    if (nil!=meetingCode_) {
        [meetingCode_ release];
    }
    if (nil!=opQueue_) {
        [opQueue_ release];
    }
}

- (void)attachQueue:(OwbClientOperationQueue *)opQueue
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
    NSLog(@"opqueue isempty: %d", opQueue_.isEmpty);
    [opQueue_ enqueue:op];
    [self triggerWriteToServer];
}

- (void)triggerWriteToServer
{
    if(isWriting_) {
        [opQueue_ lock];
        if(![opQueue_ isEmpty]) {
//            [self performSelectorInBackground:@selector(writeToServer) withObject:nil];
        }
        [opQueue_ unLock];
    } else {
        isWriting_ = YES;
//        [self performSelectorInBackground:@selector(writeToServer) withObject:nil];
    }
}

- (void)writeToServer
{
    NSLog(@"========FUCK========");
    while (![opQueue_ isEmpty]) {
        operation_ = [opQueue_ dequeue];
        NSLog(@"op type:%d", [operation_ operationType_]);
        if(![[OwbClientServerDelegate sharedServerDelegate] sendOperation:operation_]) {
            [[OwbClientServerDelegate sharedServerDelegate] resumeUpdater:meetingCode_];
        }
        NSLog(@"OP: %d, %d, %d", operation_.operationType_, operation_.serialNumber_, operation_.thinkness_);
    }
    NSLog(@"========shot========");
    isWriting_ = NO;
}
@end
