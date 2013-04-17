/*************************************************************************
     ** File Name: ServerDelegateTest.cc
    ** Author: tsgsz
    ** Mail: cdtsgsz@gmail.com
    ** Created Time: Sat Apr 13 20:30:45 2013
    **Copyright [2013] <Copyright tsgsz>  [legal/copyright]
 ************************************************************************/
#include "../internal/common.h"
#include "../internal/RcfDefine.h"
#include "../ServerDelegate.h"
#include "../internal/message.pb.h"

namespace Kingslanding {
namespace OnlineWhiteBoard {
namespace Client {
namespace NetWork {

class MockMonitor {
public:
    bool Login(const User& user) {
        return true;
    }

    std::string CreateMeeting(const std::string& user_name) {
        return std::string("meeting1");
    }

    JoinMeetingReturn JoinMeeting(const std::string& user_name,
                                  const std::string& meeting_id) {
        JoinMeetingReturn _return;
        _return.set_join_state(SUCCESS);
        MeetingServerInfo* server_info = _return.mutable_server_info();
        server_info->set_port(9997);
        server_info->set_server_ip("127.0.0.1");
        return _return;
    }

    int32_t TransferAuth(const std::string& user_name,
                      const std::string& meeting_id) {
        return 1;
    }

    bool RequestAuth(const std::string& user_name,
                     const std::string& meeting_id) {
        return true;
    }

    UserList GetCurrentUserList(const std::string& meeting_id) {
        UserList user_list;
        User* user1 = user_list.add_users();
        user1->set_user_name("user1");
        user1->set_identity(CANDIDATE);
        return user_list;
    }

    HeartReturnPackage HeartBeat(const HeartBeatSendPackage& package) {
        HeartReturnPackage hb_pack;
        hb_pack.set_identity(CANDIDATE);
        return hb_pack;
    }
};

class MockUpdater {
public:
    bool WriteOperationToPool(const Operation& operation) {
        return true;
    }
};

class MockProvider {
public:
    Operations GetOperations(const std::string& meeting_id,
                             int32_t latest_serial_number) {
        Operations operations;
        operations.set_operation_avaliable(false);
        return operations;
    }

    Document GetLatestDocument(const std::string& meeting_id) {
        Document doc;
        doc.set_serial_number(1);
        doc.set_data(std::string("01010101"));
        return doc;
    }

    DocumentList GetHistorySnapshots(const std::string& meeting_id) {
        DocumentList doc_list;
        Document* doc = doc_list.add_history_document();
        doc->set_serial_number(1);
        doc->set_data(std::string("01010101"));
        return doc_list;
    }
    Document GetDocument(const std::string& meeting_id, int32_t serial_number) {
        Document doc;
        doc.set_serial_number(serial_number);
        doc.set_data(std::string("01010101"));
        return doc;
    }
};

#define RCF_SERVER_START(serverName, port)                                    \
    RCF::RcfInitDeinit rcfInit;                                               \
    Mock##serverName server_impl;                                            \
    RCF::RcfServer server(RCF::TcpEndpoint("127.0.0.1", port));                \
    server.bind<serverName>(server_impl);                                     \
    server.start()

class ServerDelegateTest : public ::testing::Test {
};

TEST_F(ServerDelegateTest, TestUpdater) {
    RCF_SERVER_START(Updater, 9997);
    ServerDelegate* s_d = ServerDelegate::GetInstance();
    s_d->BindServerIpAndPort(std::string("127.0.0.1"), 9997);
    Operation op;
    Operation_OperationData* data = op.mutable_data();
    op.set_serial_number(1);
    data->set_data_type(Operation_OperationData_OperationDataType_LINE);
    data->set_thinkness(1);
    EXPECT_TRUE(s_d->WriteOperationToPool(op));
}

TEST_F(ServerDelegateTest, TestMonitor) {
    RCF_SERVER_START(Monitor, 9998);
    ServerDelegate* s_d = ServerDelegate::GetInstance();
    User user;
    std::string user_name("user1");
    std::string meeting_id("meeting1");
    user.set_user_name(user_name);
    EXPECT_TRUE(s_d->Login(user));
    EXPECT_STREQ(meeting_id.c_str(), s_d->CreateMeeting(user_name).c_str());
    JoinMeetingReturn r_p = s_d->JoinMeeting(user_name, meeting_id);
    MeetingServerInfo server_info = r_p.server_info();
    EXPECT_EQ(SUCCESS, r_p.join_state());
    EXPECT_STREQ("127.0.0.1", server_info.server_ip().c_str());
    EXPECT_EQ(9997, server_info.port());
    EXPECT_EQ(1, s_d->TransferAuth(user_name, meeting_id));
    EXPECT_TRUE(s_d->RequestAuth(user_name, meeting_id));
    EXPECT_EQ(1, s_d->GetCurrentUserList(meeting_id).users_size());
    HeartBeatSendPackage pac;
    pac.set_user_name(user_name);
    pac.set_meeting_id(meeting_id);
    EXPECT_EQ(CANDIDATE, s_d->HeartBeat(pac).identity());
}

TEST_F(ServerDelegateTest, TestProvider) {
    RCF_SERVER_START(Provider, 9999);
    ServerDelegate* s_d = ServerDelegate::GetInstance();
    std::string meeting_id("meeting1");
    EXPECT_FALSE(s_d->GetOperations(meeting_id, 1).operation_avaliable());
    EXPECT_EQ(1, s_d->GetLatestDocument(meeting_id).serial_number());
    EXPECT_EQ(1, s_d->GetHistorySnapshots(meeting_id).history_document_size());
    EXPECT_EQ(2, s_d->GetDocument(meeting_id, 2).serial_number());
}
}  // NetWork
}  // Client
}  // OnlineWhiteBoard
}  // Kingslanding
int main(int argc, char* argv[]) {
    ::google::ParseCommandLineFlags(&argc, &argv, true);
    ::google::InitGoogleLogging(argv[0]);
    testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
