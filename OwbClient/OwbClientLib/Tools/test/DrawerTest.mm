/*************************************************************************
     ** File Name: DrawerTest.mm
    ** Author: tsgsz
    ** Mail: cdtsgsz@gmail.com
    ** Created Time: Thu Apr 25 13:38:56 2013
    **Copyright [2013] <Copyright tsgsz>  [legal/copyright]
 ************************************************************************/
#import "../Drawer.h"
#import "./common.h"

class DrawerTest : public ::testing::Test {
};

// Don't know how to test it yet.

int main(int argc, char* argv[]) {
    ::google::ParseCommandLineFlags(&argc, &argv, true);
    ::google::InitGoogleLogging(argv[0]);
    testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
