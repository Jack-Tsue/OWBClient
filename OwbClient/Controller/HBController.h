//
//  HBController.h
//  OwbClient
//
//  Created by Jack on 19/4/13.
//  Copyright (c) 2013 tsgsz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OwbCommon.h"

@protocol HBDelegate <NSObject>

- (void)alert;

@end

@interface HBController : NSObject {
@private
    int failCount;
    bool shouldStop;
    OwbClientHeartSendPackage *hbSendPack;
    id<HBDelegate> hbDelegate_;
    bool isNotFirst;
}

@property (nonatomic, retain) id<HBDelegate> hbDelegate_;

+ (HBController *)SharedHBController;
- (void)hearHBWithUserName:(NSString *)userName withMeetingCode:(NSString *)meetingCode;
- (void)stopHear;
@end
