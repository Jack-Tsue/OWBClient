/*************************************************************************
     ** File Name: MessageModelTest.mm
    ** Author: tsgsz
    ** Mail: cdtsgsz@gmail.com
    ** Created Time: Wed Apr 24 17:00:53 2013
    **Copyright [2013] <Copyright tsgsz>  [legal/copyright]
 ************************************************************************/
#import "./common.h"
#import "../MessageModel.h"

class MessageModelTest : public ::testing::Test {
};

TEST_F(MessageModelTest, TestOwbClientFactory) {
    Operation op;
    op.set_serial_number(0);
    op.mutable_data() ->
        set_data_type(Operation_OperationData_OperationDataType_ERASER);
    op.mutable_data()->mutable_position()->set_x(1);
    op.mutable_data()->mutable_position()->set_y(1);
    Erase* t_op = [OwbClientOperationFactory CreateOperationFromOperation:
                                &op];
    EXPECT_EQ(t_op.operationType_,
              Operation_OperationData_OperationDataType_ERASER);
    EXPECT_EQ(t_op.position_.x, 1);
    EXPECT_EQ(t_op.position_.y, 1);
    [t_op release];
}

TEST_F(MessageModelTest, TestDrawLine) {
    DrawLine* op = [[DrawLine alloc]init];
    op.color_ = 0;
    op.alpha_ = 0.2;
    CGPoint startPoint = CGPointMake(0, 0);
    CGPoint endPoint = CGPointMake(1, 1);
    op.startPoint_ = startPoint;
    op.endPoint_ = endPoint;
    op.serialNumber_ = 1;
    op.thinkness_ = 1;
    Operation t_op = [op toOperation];
    EXPECT_EQ(t_op.serial_number(), 1);
    EXPECT_EQ(t_op.data().data_type(),
              Operation_OperationData_OperationDataType_LINE);
    EXPECT_EQ(t_op.data().thinkness(), 1);
    EXPECT_EQ(t_op.data().start_point().x(), 0);
    EXPECT_EQ(t_op.data().end_point().y(), 1);
    EXPECT_EQ(t_op.data().color(), 0);
    EXPECT_EQ(t_op.data().alpha(), op.alpha_);
    [op release];
}

TEST_F(MessageModelTest, TestDrawEllipse) {
    DrawEllipse* op = [[DrawEllipse alloc]init];
    op.color_ = 0;
    op.alpha_ = 0.1;
    op.fill_ = true;
    CGPoint center = CGPointMake(1, 1);
    op.center_ = center;
    op.a_ = 1;
    op.b_ = 4;
    op.serialNumber_ = 2;
    op.thinkness_ = 2;
    Operation t_op = [op toOperation];
    EXPECT_EQ(t_op.serial_number(), 2);
    EXPECT_EQ(t_op.data().data_type(),
              Operation_OperationData_OperationDataType_ELLIPSE);
    EXPECT_EQ(t_op.data().thinkness(), 2);
    EXPECT_EQ(t_op.data().center().x(), 1);
    EXPECT_EQ(t_op.data().center().y(), 1);
    EXPECT_EQ(t_op.data().color(), 0);
    //EXPECT_TRUE(t_op.data().alpha() == 0.1);
    EXPECT_EQ(t_op.data().alpha(), op.alpha_);
    EXPECT_EQ(t_op.data().a(), 1);
    EXPECT_EQ(t_op.data().b(), 4);
    EXPECT_TRUE(t_op.data().fill());
    [op release];
}

TEST_F(MessageModelTest, TestDrawRectange) {
    DrawRectange* op = [[DrawRectange alloc]init];
    op.serialNumber_ = 2;
    op.thinkness_ = 2;
    op.color_ = 0;
    op.alpha_ = 0.1;
    op.fill_ = true;
    op.topLeftCorner_ = CGPointMake(3, 3);
    op.bottomRightCorner_ = CGPointMake(15, 15);
    Operation t_op = [op toOperation];
    EXPECT_EQ(t_op.serial_number(), 2);
    EXPECT_EQ(t_op.data().data_type(),
              Operation_OperationData_OperationDataType_RECTANGE);
    EXPECT_EQ(t_op.data().thinkness(), 2);
    EXPECT_EQ(t_op.data().top_left_corner().x(), 3);
    EXPECT_EQ(t_op.data().top_left_corner().y(), 3);
    EXPECT_EQ(t_op.data().bottom_right_corner().x(), 15);
    EXPECT_EQ(t_op.data().bottom_right_corner().y(), 15);
    EXPECT_EQ(t_op.data().color(), 0);
    //EXPECT_TRUE(t_op.data().alpha() ==  0.1);
    EXPECT_EQ(t_op.data().alpha(), op.alpha_);
    EXPECT_TRUE(t_op.data().fill());
    [op release];
}

TEST_F(MessageModelTest, TestDrawPoint) {
    DrawPoint* op = [[DrawPoint alloc]init];
    op.serialNumber_ = 2;
    op.thinkness_ = 2;
    op.color_ = 0;
    op.alpha_ = 0.1;
    op.position_ = CGPointMake(3, 3);
    Operation t_op = [op toOperation];
    EXPECT_EQ(t_op.serial_number(), 2);
    EXPECT_EQ(t_op.data().data_type(),
              Operation_OperationData_OperationDataType_POINT);
    EXPECT_EQ(t_op.data().thinkness(), 2);
    EXPECT_EQ(t_op.data().position().x(), 3);
    EXPECT_EQ(t_op.data().position().y(), 3);
    EXPECT_EQ(t_op.data().color(), 0);
    //EXPECT_TRUE(t_op.data().alpha() ==  0.1);
    EXPECT_EQ(t_op.data().alpha(), op.alpha_);
    [op release];
}

TEST_F(MessageModelTest, TestErase) {
    Erase* op = [[Erase alloc]init];
    op.serialNumber_ = 2;
    op.thinkness_ = 2;
    op.position_ = CGPointMake(3, 3);
    Operation t_op = [op toOperation];
    EXPECT_EQ(t_op.serial_number(), 2);
    EXPECT_EQ(t_op.data().data_type(),
              Operation_OperationData_OperationDataType_ERASER);
    EXPECT_EQ(t_op.data().thinkness(), 2);
    EXPECT_EQ(t_op.data().position().x(), 3);
    EXPECT_EQ(t_op.data().position().y(), 3);
    [op release];
}

TEST_F(MessageModelTest, TestDocumentModel) {
    Document document;
    document.set_serial_number(5);
    std::string data("010101");
    document.set_data(data);
    OwbClientDocument* doc = [[OwbClientDocument alloc]initFromDocument:&document];
    EXPECT_EQ(doc.serialNumber_, 5);
    [doc release];
}

TEST_F(MessageModelTest, TestUserModel) {
    User user;
    user.set_user_name("tsgsz");
    user.set_password("123");
    user.set_identity(HOST);
    OwbClientUser* owb_user = [[OwbClientUser alloc]initFromUser:&user];
    EXPECT_STREQ([owb_user.userName_ UTF8String], "tsgsz");
    EXPECT_STREQ([owb_user.passWord_ UTF8String], "123");
    EXPECT_EQ(owb_user.identity_, HOST);
    [owb_user release];
}

TEST_F(MessageModelTest, TestHeartBeatModel) {
    HeartReturnPackage hbrp;
    hbrp.set_identity(HOST);
    OwbClientHeartReturnPackage* rp = [[OwbClientHeartReturnPackage alloc]
                                        initFromRPac:&hbrp];
    EXPECT_EQ(rp.identity_, HOST);

    OwbClientHeartSendPackage* sp = [[OwbClientHeartSendPackage alloc]init];
    sp.userName_ = @"tsgsz";
    sp.meetingId_ = @"5";
    HeartBeatSendPackage hbsp = [sp toSPac];
    EXPECT_STREQ(hbsp.user_name().c_str(), "tsgsz");
    EXPECT_STREQ(hbsp.meeting_id().c_str(), "5");
    [sp release];
    [rp release];
}

TEST_F(MessageModelTest, TestJoinMeetingReturn) {
    JoinMeetingReturn _return;
    _return.set_join_state(SUCCESS);
    MeetingServerInfo* server_info = _return.mutable_server_info();
    server_info->set_port(9997);
    server_info->set_server_ip("127.0.0.1");
    OwbClientJoinMeetingReturn* pac =
        [[OwbClientJoinMeetingReturn alloc]initFromJoinPac:&_return];
    EXPECT_EQ(pac.joinState_, SUCCESS);
    EXPECT_EQ(pac.port_, 9997);
    EXPECT_STREQ([pac.serverIp_ UTF8String], "127.0.0.1");
    [pac release];
}

int main(int argc, char* argv[]) {
    ::google::ParseCommandLineFlags(&argc, &argv, true);
    ::google::InitGoogleLogging(argv[0]);
    testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
