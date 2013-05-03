//
//  HBController.m
//  OwbClient
//
//  Created by Jack on 19/4/13.
//  Copyright (c) 2013 tsgsz. All rights reserved.
//

#import "HBController.h"
static HBController *instance = nil;
@implementation HBController

+ (HBController *)SharedHBController {
    if (nil == instance) {
        instance = [[HBController alloc] init];
    }
    return instance;
}

- (void)hearHBWithUserName:(NSString *)userName withMeetingCode:(NSString *)meetingCode
{
    hbSendPack = [[OwbClientHeartSendPackage alloc] init];
    try {
        [hbSendPack setMeetingId_:meetingCode];
        [hbSendPack setUserName_:userName];
    } catch (std::exception e) {
        NSLog(@"in HBController.mm: fail to start hear.");
    }
    
    [self performSelectorInBackground:@selector(heartBeat) withObject:nil];
}

- (int)heartBeat
{
    while (true) {
        if(shouldStop){
            break;
        } else {
            OwbClientHeartReturnPackage *hbRetrunPack;
            try {
                hbRetrunPack = [[OwbClientServerDelegate sharedServerDelegate] heartBeat:hbSendPack];
                [self analysisReturnPack:hbRetrunPack.identity_];
            } catch (std::exception e) {
                if (failCount++>MAX_FAIL) {
                    shouldStop=YES;
                    [hbDelegate_ alert];
                }
            }
        }
        sleep(SLEEP_TIME);
    }
}

- (void)analysisReturnPack:(enum OwbIdentity)identity
{
    if([[BoardModel SharedBoard] inHostMode_] && OwbHOST!=identity) {
        [[BoardModel SharedBoard] setInHostMode_:NO];
        [[QueueHandler SharedQueueHandler] startQueueGetDataBackgroundWithMeetingID:hbSendPack.meetingId_];
    } else if(![[BoardModel SharedBoard] inHostMode_] && OwbHOST==identity) {
        [[BoardModel SharedBoard] setInHostMode_:YES];
        [[QueueHandler SharedQueueHandler] stopQueueGetDataBackground];
    }
}

- (void)stopHear
{
    shouldStop = YES;
}
@end
