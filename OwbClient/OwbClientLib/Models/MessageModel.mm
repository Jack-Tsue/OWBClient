/*************************************************************************
     ** File Name: MessageModel.mm
    ** Author: tsgsz
    ** Mail: cdtsgsz@gmail.com
    ** Created Time: Tue Apr 16 20:02:28 2013
    **Copyright [2013] <Copyright tsgsz>  [legal/copyright]
 ************************************************************************/
#import "MessageModel.h"

@implementation OwbClientOperationFactory

+ (OwbClientOperation*)CreateOperationFromOperation:(const Operation*) operation {
    switch (operation->data().data_type()) {
        case Operation_OperationData_OperationDataType_LINE:
            return [[DrawLine alloc]initFromOperation:operation];
        case Operation_OperationData_OperationDataType_ELLIPSE:
            return [[DrawEllipse alloc]initFromOperation:operation];
        case Operation_OperationData_OperationDataType_RECTANGE:
            return [[DrawRectange alloc]initFromOperation:operation];
        case Operation_OperationData_OperationDataType_POINT:
            return [[DrawPoint alloc]initFromOperation:operation];
        case Operation_OperationData_OperationDataType_ERASER:
            return [[Erase alloc]initFromOperation:operation];
        default:
            @throw [NSException exceptionWithName:@"未知操作類型" reason:@"未知操作類型" userInfo: nil];
            break;
    }
}

@end

@implementation OwbClientOperation

@synthesize serialNumber_ = _serialNumber_;
@synthesize operationType_ = _operationType_;
@synthesize thinkness_ = _thinkness_;
@synthesize drawer_ = _drawer_;

- (id)initFromOperation:(const Operation*) operation
{
    @throw [NSException exceptionWithName:@"無法初始化異常" reason:@"這是一個抽象類，無法初始化" userInfo: nil];
    return self;
}

- (void)dealloc {
    [super dealloc];
    if (nil != _drawer_) {
        [_drawer_ release];
    }
}

- (Operation) toOperation
{
    return operation_;
}

- (int)serialNumber_
{
    return operation_.serial_number();
}

- (void)setSerialNumber_:(int)serialNumber
{
    operation_.set_serial_number(serialNumber);
}

- (enum Operation_OperationData_OperationDataType)operationType_
{
    return operation_.data().data_type();
}

- (void)setOperationType_:(enum Operation_OperationData_OperationDataType)operationType
{
    operation_.mutable_data()->set_data_type(operationType);
}

- (int)thinkness_
{
    return operation_.data().thinkness();
}

- (void)setThinkness_:(int)thinkness
{
    operation_.mutable_data()->set_thinkness(thinkness);
}

@end

@implementation DrawLine

@synthesize color_ = _color_;
@synthesize alpha_ = _alpha_;
@synthesize startPoint_ = _startPoint_;
@synthesize endPoint_ = _endPoint_;

- (id)init
{
    self = [super init];
    if (nil != self) {
        self.operationType_ = Operation_OperationData_OperationDataType_LINE;
        self.drawer_ = [[LineDrawer alloc]init];
    }
    return self;
}

- (id)initFromOperation:(const Operation *)operation
{
    self = [self init];
    if (nil != self) {
        operation_ = *operation;
    }
    return self;
}

- (int)color_
{
    return operation_.data().color();
}

- (void)setColor_:(int)color
{
    operation_.mutable_data()->set_color(color);
}

- (float)alpha_
{
    return operation_.data().alpha();
}

- (void)setAlpha_:(float)alpha
{
    operation_.mutable_data()->set_alpha(alpha);
}

- (CGPoint)startPoint_
{
    return CGPointMake(operation_.data().start_point().x(), operation_.data().start_point().y());
}

- (void)setStartPoint_:(CGPoint)startPoint
{
    operation_.mutable_data()->mutable_start_point()->set_x(startPoint.x);
    operation_.mutable_data()->mutable_start_point()->set_y(startPoint.y);
}

- (CGPoint)endPoint_
{
    return CGPointMake(operation_.data().end_point().x(), operation_.data().end_point().y());
}

- (void)setEndPoint_:(CGPoint)endPoint
{
    operation_.mutable_data()->mutable_end_point()->set_x(endPoint.x);
    operation_.mutable_data()->mutable_end_point()->set_y(endPoint.y);
}

@end

@implementation DrawEllipse

@synthesize color_ = _color_;
@synthesize alpha_ = _alpha_;
@synthesize center_ = _center_;
@synthesize a_ = _a_;
@synthesize b_ = _b_;

- (id)init
{
    self = [super init];
    if (nil != self) {
        self.operationType_ = Operation_OperationData_OperationDataType_ELLIPSE;
        self.drawer_ = [[EllipseDrawer alloc]init];
    }
    return self;
}

- (id)initFromOperation:(const Operation *)operation
{
    self = [self init];
    if (nil != self) {
        operation_ = *operation;
    }
    return self;
}

- (int)color_
{
    return operation_.data().color();
}

- (void)setColor_:(int)color
{
    operation_.mutable_data()->set_color(color);
}

- (float)alpha_
{
    return operation_.data().alpha();
}

- (void)setAlpha_:(float)alpha
{
    operation_.mutable_data()->set_alpha(alpha);
}

- (bool)fill_
{
    return operation_.data().fill();
}

- (void)setFill_:(bool)fill
{
    operation_.mutable_data()->set_fill(fill);
}

- (CGPoint)center_
{
    return CGPointMake(operation_.data().center().x(), operation_.data().center().y());
}

- (void)setCenter_:(CGPoint)center
{
    operation_.mutable_data()->mutable_center()->set_x(center.x);
    operation_.mutable_data()->mutable_center()->set_y(center.y);
}

- (int)a_
{
    return operation_.data().a();
}

- (void)setA_:(int)a
{
    operation_.mutable_data()->set_a(a);
}

- (int)b_
{
    return operation_.data().b();
}

- (void)setB_:(int)b
{
    operation_.mutable_data()->set_b(b);
}
@end

@implementation DrawRectange

@synthesize color_ = _color_;
@synthesize alpha_ = _alpha_;
@synthesize topLeftCorner_ = _topLeftCorner_;
@synthesize bottomRightCorner_ = _bottomRightCorner_;

- (id)init
{
    self = [super init];
    if (nil != self) {
        self.operationType_ = Operation_OperationData_OperationDataType_RECTANGE;
        self.drawer_ = [[RectangeDrawer alloc]init];
    }
    return self;
}

- (id)initFromOperation  :(const Operation *)operation
{
    self = [self init];
    if (nil != self) {
        operation_ = *operation;
    }
    return self;
}

- (int)color_
{
    return operation_.data().color();
}

- (void)setColor_:(int)color
{
    operation_.mutable_data()->set_color(color);
}

- (float)alpha_
{
    return operation_.data().alpha();
}

- (void)setAlpha_:(float)alpha
{
    operation_.mutable_data()->set_alpha(alpha);
}

- (bool)fill_
{
    return operation_.data().fill();
}

- (void)setFill_:(bool)fill
{
    operation_.mutable_data()->set_fill(fill);
}

- (CGPoint)topLeftCorner_
{
    return CGPointMake(operation_.data().top_left_corner().x(), operation_.data().top_left_corner().y());
}

- (void)setTopLeftCorner_:(CGPoint)topLeftCorner
{
    operation_.mutable_data()->mutable_top_left_corner()->set_x(topLeftCorner.x);
    operation_.mutable_data()->mutable_top_left_corner()->set_y(topLeftCorner.y);
}

- (CGPoint)bottomRightCorner_
{
    return CGPointMake(operation_.data().bottom_right_corner().x(), operation_.data().bottom_right_corner().y());
}

- (void)setBottomRightCorner_:(CGPoint)bottomRightCorner
{
    operation_.mutable_data()->mutable_bottom_right_corner()->set_x(bottomRightCorner.x);
    operation_.mutable_data()->mutable_bottom_right_corner()->set_y(bottomRightCorner.y);
}

@end

@implementation DrawPoint

@synthesize color_ = _color_;
@synthesize alpha_ = _alpha_;
@synthesize position_ = _position_;

- (id)init
{
    self = [super init];
    if (nil != self) {
        self.operationType_ = Operation_OperationData_OperationDataType_POINT;
        self.drawer_ = [[PointDrawer alloc]init];
    }
    return self;
}

- (id)initFromOperation  :(const Operation *)operation
{
    self = [self init];
    if (nil != self) {
        operation_ = *operation;
    }
    return self;
}

- (int)color_
{
    return operation_.data().color();
}

- (void)setColor_:(int)color
{
    operation_.mutable_data()->set_color(color);
}

- (float)alpha_
{
    return operation_.data().alpha();
}

- (void)setAlpha_:(float)alpha
{
    operation_.mutable_data()->set_alpha(alpha);
}

- (CGPoint)position_
{
    return CGPointMake(operation_.data().position().x(), operation_.data().position().y());
}

- (void)setPosition_:(CGPoint)position
{
    operation_.mutable_data()->mutable_position()->set_x(position.x);
    operation_.mutable_data()->mutable_position()->set_y(position.y);
}

@end

@implementation Erase

@synthesize position_ = _position_;

- (id)init
{
    self = [super init];
    if (nil != self) {
        self.operationType_ = Operation_OperationData_OperationDataType_ERASER;
        self.drawer_ = [[Eraser alloc]init];
    }
    return self;
}

- (id)initFromOperation  :(const Operation *)operation
{
    self = [self init];
    if (nil != self) {
        operation_ = *operation;
    }
    return self;
}

- (CGPoint)position_
{
    return CGPointMake(operation_.data().position().x(), operation_.data().position().y());
}

- (void)setPosition_:(CGPoint)position
{
    operation_.mutable_data()->mutable_position()->set_x(position.x);
    operation_.mutable_data()->mutable_position()->set_y(position.y);
}

@end

@implementation OwbClientDocument

@synthesize serialNumber_ = _serialNumber_;
@synthesize data_ = _data_;

- (id)initFromDocument  :(const Document *)document
{
    self = [self init];
    if (nil != self) {
        document_ = *document;
    }
    return self;
}

- (int)serialNumber_
{
    return document_.serial_number();
}

- (NSData*)data_
{
    return [NSData dataWithBytes:document_.data().c_str() length:document_.data().length()*sizeof(char)];
}

@end

@implementation OwbClientUser

@synthesize userName_ = _userName_;
@synthesize passWord_ = _passWord_;
@synthesize identity_ = _identity_;

- (id)initFromUser  :(const User *)user
{
    self = [self init];
    if (nil != self) {
        user_ = *user;
    }
    return self;
}

- (User)toUser
{
    return user_;
}

- (NSString*)userName_
{
    return [NSString stringWithUTF8String:user_.user_name().c_str()];
}

- (void)setUserName_:(NSString *)userName
{
    user_.set_user_name([userName UTF8String]);
}

- (NSString*)passWord_
{
    return [NSString stringWithUTF8String:user_.password().c_str()];
}

- (void)setPassWord_:(NSString *)passWord
{
    user_.set_password([passWord UTF8String]);
}

- (enum Identity)identity_
{
    return user_.identity();
}

- (void)setIdentity_:(enum Identity)identity
{
    user_.set_identity(identity);
}

@end

@implementation OwbClientHeartReturnPackage

@synthesize identity_ = _identity_;

- (id)initFromRPac  :(const HeartReturnPackage *)hb_package
{
    self = [self init];
    if (nil != self) {
        package_ = *hb_package;
    }
    return self;
}

- (enum Identity)identity_
{
    return package_.identity();
}

@end

@implementation OwbClientHeartSendPackage

@synthesize userName_ = _userName_;
@synthesize meetingId_ = _meetingId_;

- (HeartBeatSendPackage)toSPac
{
    return package_;
}

- (NSString*)userName_
{
    return [NSString stringWithUTF8String:package_.user_name().c_str()];
}

- (void)setUserName_:(NSString *)userName
{
    package_.set_user_name([userName UTF8String]);
}

- (NSString*)meetingId_
{
    return [NSString stringWithUTF8String:package_.meeting_id().c_str()];
}

- (void)setMeetingId_:(NSString *)meetingId
{
    package_.set_meeting_id([meetingId UTF8String]);
}

@end

@implementation OwbClientJoinMeetingReturn

@synthesize joinState_ = _joinState_;
@synthesize port_ = _port_;
@synthesize serverIp_ = _serverIp_;

- (id)initFromJoinPac  :(const JoinMeetingReturn *)re_package
{
    self = [self init];
    if (nil != self) {
        package_ = *re_package;
    }
    return self;
}

- (enum JoinState)joinState_
{
    return package_.join_state();
}

- (int)port_
{
    return package_.server_info().port();
}

- (NSString*)serverIp_
{
    return [NSString stringWithUTF8String:package_.server_info().server_ip().c_str()];
}

@end

@implementation OwbClientOperationList

@synthesize operationAvaliable_ = _operationAvaliable_;
@synthesize operationList_ = _operationList_;

- (id)initFromOperationList:(const Operations *)operations
{
    self = [self init];
    if (nil != self) {
        _operationList_ = [[NSMutableArray alloc]init];
        for (int i = 0; i < operations->operations_size(); ++i)
        {
            [(NSMutableArray*) _operationList_ addObject:[OwbClientOperationFactory CreateOperationFromOperation:&operations->operations(i)]];
        }
        _operationAvaliable_ = operations->operation_avaliable();
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
    if(nil != _operationList_) {
        [_operationList_ release];
    }
}

@end

@implementation OwbClientDocumentList

@synthesize documentList_ = _documentList_;

- (id)initFromDocumentList:(const DocumentList *)documentList
{
    self = [self init];
    if (nil != self) {
        _documentList_ = [[NSMutableArray alloc]init];
        NSMutableArray* _docList_ = (NSMutableArray*) _documentList_;
        for (int i = 0; i < documentList->history_document_size(); ++i) {
            const Document* t_doc = &(documentList->history_document(i));
            OwbClientDocument* doc = [[OwbClientDocument alloc]initFromDocument:t_doc];
            [_docList_ addObject:doc];
            [doc release];
        }
        [_docList_ release];
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
    if(nil != _documentList_) {
        [_documentList_ release];
    }
}


@end

@implementation OwbClientUserList

@synthesize userList_ = _userList_;

- (id)initFromUserList:(const UserList *)userList
{
    self = [self init];
    if (nil != self) {
        _userList_ = [[NSMutableArray alloc]init];
        NSMutableArray* _uList_ = (NSMutableArray*) _userList_;
        for (int i = 0; i < userList->users_size(); ++i)
        {
            const User* t_user = &(userList->users(i));
            OwbClientUser* user = [[OwbClientUser alloc]initFromUser:t_user];
            [_uList_ addObject:user];
            [user release];
        }
        [_uList_ release];
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
    if(nil != _userList_) {
        [_userList_ release];
    }
}


@end
