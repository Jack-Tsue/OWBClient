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

-(void) setLatestSeriaNumber:(int)num {
    [opQueue_ setLatestSerialNumber_:num];
}

- (void)attachQueue:(OwbClientOperationQueue *)opQueue
{
    opQueue_ = opQueue;
    [opQueue_ setMeetingId_:meetingCode_];
}

- (void)startQueueGetDataBackgroundWithMeetingID:(NSString *)meetingID
{
    meetingCode_ = meetingID;
    [self performSelectorInBackground:@selector(getDataFromServer) withObject:nil];
}

- (void)getDataFromServer
{
    while (true) {
        sleep(SLEEP_SHORT_TIME);
        NSLog(@"HBHandler - getDataFromServer - start");
        if(shouldStop_) {
            break;
        }
        OwbOperationAvaliable isSucToGetData;
        try {
            isSucToGetData = (OwbOperationAvaliable)[opQueue_ getServerData];
        } catch (std::exception e) {
            NSLog(@"in QueueHandler.mm: get server data failed.");
        }
        if(OwbAVALIBLE == isSucToGetData) {
            NSLog(@"Triger Read Operation");
            [[BoardModel SharedBoard] trigerReadOperationQueue];
        } else if(OwbNOT_AVALIABLE == isSucToGetData) {
            NSLog(@"op not avaliable ,try to get doc");
            OwbClientDocument *tmpDoc;
            try {
                tmpDoc = [[OwbClientServerDelegate sharedServerDelegate] getLatestDocument:meetingCode_];
                [opQueue_ setLatestSerialNumber_:tmpDoc.serialNumber_];
            } catch (std::exception e) {
                NSLog(@"in QueueHandler.mm: get latest doc failed.");
            }
            [[BoardModel SharedBoard] loadDocumentAsync:tmpDoc];
        }else if(OwbLOAD_DOCUMENT == isSucToGetData){
            NSLog(@"server has been set doc");
            [opQueue_ setLatestSerialNumber_:(opQueue_.latestSerialNumber_+1)];
            OwbClientDocument *tmpDoc;
            try {
                tmpDoc = [[OwbClientServerDelegate sharedServerDelegate] getLatestDocument:meetingCode_];
            } catch (std::exception e) {
                NSLog(@"in QueueHandler.mm: get latest doc failed.");
            }
            [[BoardModel SharedBoard] loadDocumentAsync:tmpDoc];
        }else if(OwbNOT_UPDATE == isSucToGetData){
            NSLog(@"no update");
        }
        
        NSLog(@"loop over");
    }
}

- (void)stopQueueGetDataBackground
{
    shouldStop_ = YES;
}

- (void)drawOperationToServer:(OwbClientOperation *)op
{
//    NSLog(@"opqueue isempty: %d", opQueue_.isEmpty);
    [opQueue_ enqueue:op];
    [self triggerWriteToServer];
}

- (void)triggerWriteToServer
{
    if(isWriting_) {
        /*while (![opQueue_ trylock]) {
            NSLog(@"opQueue locked");
        };
        if(![opQueue_ isEmpty]) {
            [self performSelectorInBackground:@selector(writeToServer) withObject:nil];
        }
        [opQueue_ unLock];*/
    } else {
        isWriting_ = YES;
        [self performSelectorInBackground:@selector(writeToServer) withObject:nil];
    }
}

- (void)writeToServer
{
//    NSLog(@"========FUCK========");
    while (true) {
        [opQueue_ lock];
        if ([opQueue_ isEmpty]) {
            isWriting_ = NO;
            [opQueue_ unLock];
            return;
        }
        [opQueue_ unLock];
        operation_ = [opQueue_ dequeue];
//        NSLog(@"op type:%d", [operation_ operationType_]);
        while(![[OwbClientServerDelegate sharedServerDelegate] sendOperation:operation_]) {
//            NSLog(@"meeting Id:%@" ,meetingCode_);
            TRY([[OwbClientServerDelegate sharedServerDelegate] resumeUpdater:meetingCode_]);
//            NSLog(@"***嘿嘿***");
        }
//        NSLog(@"OP: %d, %d, %d", operation_.operationType_, operation_.serialNumber_, operation_.thinkness_);
    }
//    NSLog(@"========Shot========");
}
- (void)setMeetingCode:(NSString *)code
{
    meetingCode_ = code;
}
@end
