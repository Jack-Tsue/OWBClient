/*************************************************************************
    ** File Name: ServerDelegate.cc
    ** Author: tsgsz
    ** Mail: cdtsgsz@gmail.com
    ** Created Time: Fri Apr 12 15:24:18 2013
    **Copyright [2013] <Copyright tsgsz>  [legal/copyright]
 ************************************************************************/
#include "./ServerDelegate.h"
#include "./internal/RcfDefine.h"
#include "../SupportFiles/common.h"

namespace Kingslanding {
namespace OnlineWhiteBoard {
namespace Client {
namespace NetWork {

typedef std::string str;
typedef HeartBeatSendPackage HbPack;

//DEFINE_string(provider_ip_address, "127.0.0.1", "the ip address of provider");
//DEFINE_int32(provider_port, 9999, "the port of provider");
//DEFINE_string(monitor_ip_address, "127.0.0.1", "the ip address of monitor");
//DEFINE_int32(monitor_port, 9998, "the port of monitor");

ServerDelegate* ServerDelegate::server_delegate_instance_ = NULL;

ServerDelegate::ServerDelegate() {
    RCF::RcfInitDeinit rcfInit;
//    LOG(INFO) << "ServerDelegate Init" << std::endl;
}

ServerDelegate* ServerDelegate::GetInstance() {
    if (NULL == server_delegate_instance_) {
        server_delegate_instance_ = new ServerDelegate();
    }
    return server_delegate_instance_;
}

void ServerDelegate::BindServerIpAndPort(const str& ip_address, int port) {
    updater_ip_address_ = ip_address;
    updater_port_ = port;
}

bool ServerDelegate::WriteOperationToPool(const Operation& operation) {
    RcfClient<Updater> client(RCF::TcpEndpoint(updater_ip_address_,
                                                updater_port_));
    return client.WriteOperationToPool(operation);
}

bool ServerDelegate::Login(const User& user) {
    RcfClient<Monitor> client(RCF::TcpEndpoint(FLAGS_monitor_ip_address,
                                               FLAGS_monitor_port));
    return client.Login(user);
}

str ServerDelegate::CreateMeeting(const str& user_name) {
    RcfClient<Monitor> client(RCF::TcpEndpoint(FLAGS_monitor_ip_address,
                                               FLAGS_monitor_port));
    return client.CreateMeeting(user_name);
}

JoinMeetingReturn ServerDelegate::JoinMeeting(const str& user_name,
                                              const str& meeting_id) {
    RcfClient<Monitor> client(RCF::TcpEndpoint(FLAGS_monitor_ip_address,
                                               FLAGS_monitor_port));
    return client.JoinMeeting(user_name, meeting_id);
}

int32_t ServerDelegate::TransferAuth(const str& user_name,
                                  const str& meeting_id) {
    RcfClient<Monitor> client(RCF::TcpEndpoint(FLAGS_monitor_ip_address,
                                               FLAGS_monitor_port));
    return client.TransferAuth(user_name, meeting_id);
}

bool ServerDelegate::RequestAuth(const str& user_name,
                                 const str& meeting_id) {
    RcfClient<Monitor> client(RCF::TcpEndpoint(FLAGS_monitor_ip_address,
                                               FLAGS_monitor_port));
    return client.RequestAuth(user_name, meeting_id);
}

UserList ServerDelegate::GetCurrentUserList(const str& meeting_id) {
    RcfClient<Monitor> client(RCF::TcpEndpoint(FLAGS_monitor_ip_address,
                                               FLAGS_monitor_port));
    return client.GetCurrentUserList(meeting_id);
}

HeartReturnPackage ServerDelegate::HeartBeat(const HbPack& package) {
    RcfClient<Monitor> client(RCF::TcpEndpoint(FLAGS_monitor_ip_address,
                                               FLAGS_monitor_port));
    return client.HeartBeat(package);
}

Operations ServerDelegate::GetOperations(const str& meeting_id,
                                         int32_t latest_serial_number) {
    RcfClient<Provider> client(RCF::TcpEndpoint(FLAGS_provider_ip_address,
                                               FLAGS_provider_port));
    return client.GetOperations(meeting_id, latest_serial_number);
}

Document ServerDelegate::GetLatestDocument(const str& meeting_id) {
    RcfClient<Provider> client(RCF::TcpEndpoint(FLAGS_provider_ip_address,
                                               FLAGS_provider_port));
    return client.GetLatestDocument(meeting_id);
}

DocumentList ServerDelegate::GetHistorySnapshots(const str& meeting_id) {
    RcfClient<Provider> client(RCF::TcpEndpoint(FLAGS_provider_ip_address,
                                               FLAGS_provider_port));
    return client.GetHistorySnapshots(meeting_id);
}

Document ServerDelegate::GetDocument(const str& meeting_id,
                                     int32_t serial_number) {
    RcfClient<Provider> client(RCF::TcpEndpoint(FLAGS_provider_ip_address,
                                               FLAGS_provider_port));
    return client.GetDocument(meeting_id, serial_number);
}
}  // NetWork
}  // Client
}  // OnlineWhiteBoard
}  // Kingslanding
