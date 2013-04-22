/*************************************************************************
     ** File Name: Models.h
    ** Author: tsgsz
    ** Mail: cdtsgsz@gmail.com
    ** Created Time: Tue Apr 16 14:29:39 2013
    **Copyright [2013] <Copyright tsgsz>  [legal/copyright]
 ************************************************************************/

#ifndef KINGSLANDING_ONLINEWHITEBOARD_CLIENT_MODELS_MESSAGEMODEL_H_
#define KINGSLANDING_ONLINEWHITEBOARD_CLIENT_MODELS_MESSAGEMODEL_H_

#import <Foundation/Foundation.h>

#import "../NetWork/internal/message.pb.h"
#import "../Tools/Drawer.h"

# pragma mark - OperationModelFactory

@interface OwbClientOperationFactory : NSObject

+ (OwbClientOperation*)CreateOperationFromPb:(const Operation *)operation;

@end

# pragma mark - OperationModel

@interface OwbClientOperation : NSObject {
    Operation operation_;
}
- (id)initFromPb:(const Operation *)operation;
- (Operation)toPb;

@property (nonatomic) int serialNumber_;
@property (nonatomic) enum Operation_OperationData_OperationDataType operationType_;
@property (nonatomic) int thinkness_;
@property (nonatomic, strong) id<OwbClientDrawer> drawer_;
@end

@interface DrawLine : OwbClientOperation
@property (nonatomic) int color_;
@property (nonatomic) float alpha_;
@property (nonatomic) CGPoint startPoint_;
@property (nonatomic) CGPoint endPoint_;
@end

@interface DrawEllipse : OwbClientOperation
@property (nonatomic) int color_;
@property (nonatomic) float alpha_;
@property (nonatomic) bool fill_;
@property (nonatomic) CGPoint center_;
@property (nonatomic) int a_;
@property (nonatomic) int b_;
@end

@interface DrawRectange : OwbClientOperation
@property (nonatomic) int color_;
@property (nonatomic) float alpha_;
@property (nonatomic) bool fill_;
@property (nonatomic) CGPoint topLeftCorner_;
@property (nonatomic) CGPoint bottomRightCorner_;
@end

@interface DrawPoint : OwbClientOperation
@property (nonatomic) int color_;
@property (nonatomic) float alpha_;
@property (nonatomic) CGPoint position_;
@end

@interface Erase : OwbClientOperation
@property (nonatomic) CGPoint position_;
@end

# pragma mark - DocumentModel
@interface OwbClientDocument : NSObject {
    Document document_;
}
- (id)initFromPb:(const Document*) document;
@property (nonatomic, readonly) int serialNumber_;
@property (nonatomic, readonly, strong) NSData* data_; 
@end

# pragma mark - UserModel
@interface OwbClientUser : NSObject {
    User user_;
}
- (id)initFromPb:(const User *)user;
- (User)toPb;
@property (nonatomic, strong) NSString* userName_;
@property (nonatomic, strong) NSString* passWord_;
@property (nonatomic) enum Identity identity_;
@end

# pragma mark - HeartBeatModel
@interface OwbClientHeartReturnPackage : NSObject {
    HeartReturnPackage package_;
}
- (id)initFromPb:(const HeartReturnPackage *)hb_package;
@property (nonatomic, readonly) enum Identity identity_;
@end

@interface OwbClientHeartSendPackage : NSObject {
    HeartBeatSendPackage package_;
}
- (HeartBeatSendPackage) toPb;
@property (nonatomic, strong) NSString* userName_;
@property (nonatomic, strong) NSString* meetingId_;
@end

# pragma mark - JoinMeetingReturnModel
@interface OwbClientJoinMeetingReturn : NSObject {
    JoinMeetingReturn package_;
}
- (id)initFromPb:(const JoinMeetingReturn *)re_package;
@property (nonatomic, readonly) enum JoinState joinState_;
@property (nonatomic, readonly) int port_;
@property (nonatomic, readonly) NSString* serverIp_;
@end

# pragma mark - OperationListModel
@interface OwbClientOperationList : NSObject
- (id)initFromPb:(const Operations *)operations;
@property (nonatomic, readonly) bool operationAvaliable_;
@property (nonatomic, readonly) NSArray* operationList_;
@end

@interface OwbClientDocumentList : NSObject
- (id)initFromPb:(const DocumentList *)documentList;
@property (nonatomic, readonly) NSArray* documentList_;
@end

@interface OwbClientUserList : NSObject
- (id)initFromPb:(const UserList*) userList;
@property (nonatomic, readonly) NSArray* userList_;
@end
#endif  // KINGSLANDING_ONLINEWHITEBOARD_CLIENT_MODELS_MESSAGEMODEL_H_
