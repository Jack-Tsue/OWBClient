/*************************************************************************
     ** File Name: OperationQueueTest.mm
    ** Author: tsgsz
    ** Mail: cdtsgsz@gmail.com
    ** Created Time: Wed Apr 24 22:15:06 2013
    **Copyright [2013] <Copyright tsgsz>  [legal/copyright]
 ************************************************************************/

#import "../OperationQueue.h"
#import "../../Models/MessageModel.h"
#import "./common.h"

class OperationQueueTest : public ::testing::Test {
public:
    id queue;
    void SetUp() {
        queue = [[OperationQueue alloc]init];
    }
    void TearDown() {
        [queue release];
    }
};

TEST_F(OperationQueueTest, TestCommonOp) {
    EXPECT_TRUE([queue isEmpty]);
    DrawLine* op = [[DrawLine alloc]init];
    op.serialNumber_ = 1;
    [queue enqueue:op];
//    [op release];
    EXPECT_FALSE([queue isEmpty]);
    DrawLine* op1 = [queue getHead];
    EXPECT_EQ(op1.operationType_,
              Operation_OperationData_OperationDataType_LINE);
    EXPECT_EQ(op1.serialNumber_, 1);
//    [op1 release];
    DrawLine* op2 = [queue dequeue];
    EXPECT_EQ(op2.operationType_,                                             \
              Operation_OperationData_OperationDataType_LINE);
    EXPECT_EQ(op2.serialNumber_, 1);
    EXPECT_TRUE([queue isEmpty]);
//    [op2 release];
}

TEST_F(OperationQueueTest, TestThread) {

}

int main(int argc, char* argv[]) {
    ::google::ParseCommandLineFlags(&argc, &argv, true);
    ::google::InitGoogleLogging(argv[0]);
    testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
