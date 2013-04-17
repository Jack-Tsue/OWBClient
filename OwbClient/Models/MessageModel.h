/*************************************************************************
     ** File Name: Models.h
    ** Author: tsgsz
    ** Mail: cdtsgsz@gmail.com
    ** Created Time: Tue Apr 16 14:29:39 2013
    **Copyright [2013] <Copyright tsgsz>  [legal/copyright]
 ************************************************************************/

#ifndef KINGSLANDING_ONLINEWHITEBOARD_CLIENT_MODELS_MESSAGEMODEL_H_
#define KINGSLANDING_ONLINEWHITEBOARD_CLIENT_MODELS_MESSAGEMODEL_H_

#import "../NetWork/internal/message.pb.h"

# pragma mark - OperationModel

@interface OwbClientOperatioin : NSObject {
    Operation* opeartion_;
}
- (id) initFromPb : (Operation*) opeartion;
- (Operation*) toPb;

@property (nonatomic) enum Operation_OperationData_OperationType opeartionType_;
@property (nonatomic) int thinkness_;

@end

@interface DrawLine : OwbClientOperation
@property (nonatomic) int color_;
@property (nonatomic) float alpha_;
@property (nonatomic) Point startPoint_;
@property (nonatomic) Point endPoint_;
@end

@interface DrawEllipse : OwbClientOpertion
@property (nonatomic) int color_;
@property (nonatomic) int alpha_;
@property (nonatomic) bool fill_;
@property (nonatomic) Point f1_;
@property (nonatomic) Point f2_;
@property (nonatomic) int a_;
@property (nonatomic) int b_;
@end

@interface DrawRectange : OwbClientOpertion
@property (nonatomic) int color_;
@property (nonatomic) int alpha_;
@property (nonatomic) bool fill_;
@property (nonatomic) Point topLeftCorner_;
@property (nonatomic) Point bottomRightCorner_;
@end

@interface DrawPoint : OwbClientOperation
@property (nonatomic) int color_;
@property (nonatomic) int alpha_;
@property (nonatomic) Point position_;
@end

@interface Erase : OwbClientOperation
@property (nonatomic) Point position_;
@end

# pragma mark - DocumentModel
@interface OwbClientDocument : NSObject {
    Document* doucment_;
}
- (id) initFromPb : (Document*) document;
@property (nonatomic, readonly) int serialNumber_;
@property (nonatomic, readonly, strong) NSData* data_; 
@end

# pragma mark - UserModel
@interface OwbClientUser : NSObject {
    User* user;
}
- (id) initFromPb : (User*) user;
- (User*) toPb;
@property (nonatomic, strong) NSString* userName_;
@property (nonatomic, strong) NSString* passWord_;
@property (nonatomic, strong) enum Identity identity_;
@end

# pragma mark - HeartBeatModel
@interface OwbClientHeartReturnPackage {
    HeartReturnPackage* package_;
}
-(id) initFromPb : (HeartReturnPackage*) hb_package;
@property (nonatomic, readonly) enum Identity identity_;
@end

@interface OwbClientHeartSendPackage {
    HeartBeatSendPackage* package_;
}
-(HeartBeatSendPackage*) toPb;
@property (nonatomic, strong) NSString* userName_;
@property (nonatomic, strong) NSString* meetingId_;
@end

# pragma mark - JoinMeetingReturnModel
@interface OwbClientJoinMeetingReturn {
    JoinMeetingReturn* package_;
}
-(id) initFromPb : (JoinMeetingReturn*) re_package;
@property (nonatomic, readonly) enum JoinState joinState_;
@property (nonatomic, readonly) int port_;
@property (nonatomic, readonly) NSString serverIp_;

#endif  // KINGSLANDING_ONLINEWHITEBOARD_CLIENT_MODELS_MESSAGEMODEL_H_
