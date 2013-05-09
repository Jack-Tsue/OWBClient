//
//  QueueHandler.h
//  OwbClient
//
//  Created by Jack on 30/4/13.
//  Copyright (c) 2013 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OwbCommon.h"

@interface QueueHandler : NSObject <DrawerDelegate, MBProgressHUDDelegate>{
    OwbClientOperationQueue *opQueue_;
    OwbClientOperation *operation_;
    NSString *meetingCode_;
    bool shouldStop_, isWriting_;
}

+ (QueueHandler *)SharedQueueHandler;
- (void)startQueueGetDataBackgroundWithMeetingID:(NSString *)meetingID;
- (void)stopQueueGetDataBackground;
- (void)drawOperationToServer:(OwbClientOperation *)op;
- (void)setMeetingCode:(NSString *)code;
@end
