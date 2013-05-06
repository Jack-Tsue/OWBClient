//
//  common.h
//  OwbClient
//
//  Created by  tsgsz on 4/7/13.
//  Copyright (c) 2013 tsgsz. All rights reserved.
//

#ifndef OwbClient_pref_h
#define OwbClient_pref_h

#import "./lib/include/OwbClient/BoardModel.h"
#import "./lib/include/OwbClient/Canvas.h"
#import "./lib/include/OwbClient/ColorMaker.h"
#import "./lib/include/OwbClient/common.h"
#import "./lib/include/OwbClient/Drawer.h"
#import "./lib/include/OwbClient/MessageModel.h"
#import "./lib/include/OwbClient/OwbClientOperationQueue.h"
#import "./lib/include/OwbClient/OwbClientServerDelegate.h"
#import "MenuViewController.h"
#import "HBController.h"
#import "MBProgressHUD.h"
#import "QueueHandler.h"
#include <exception>
#include "LoginViewController.h"

#define ScreenHeight    320
#define ScreenWidth     640

#define CanvasHeight 768
#define CanvasWidth 1024

#define MAX_TIMES 300

#define POINT OwbOperationDataType_POINT
#define LINE OwbOperationDataType_LINE
#define RECT OwbOperationDataType_RECTANGE
#define ELLIPSE OwbOperationDataType_ELLIPSE
#define ERASER OwbOperationDataType_ERASER

#define ERROR_HUD(errorHint) \
MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.view];\
[[[[UIApplication sharedApplication] delegate] window] addSubview:HUD];\
HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"error.png"]];\
HUD.mode = MBProgressHUDModeCustomView;\
HUD.delegate = self;\
HUD.labelText = (errorHint);\
[HUD show:YES];\
[HUD hide:YES afterDelay:1]

#define SUCCESS_HUD(successHint) \
MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.view];\
[self.view addSubview:HUD];\
HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"succ.png"]];\
HUD.mode = MBProgressHUDModeCustomView;\
HUD.delegate = self;\
HUD.labelText = (successHint);\
[HUD show:YES];\
[HUD hide:YES afterDelay:1]

#define TRY(a) \
try {\
(a);\
} catch (std::exception e) {\
    ERROR_HUD(@"网络错误！");\
}

#define MAX_FAIL 4
#define SLEEP_TIME 5
#define LOGIN_HINT @"登录中"
#define LOGIN_FAIL @"用户名或密码错误"
#define PASTE_SUC @"复制成功"
#define NETWORK_ERROR @"网络错误！"
#define LOADING @"载入中..."
#define CANNOT_NULL @"用户名或密码不能为空"
#define MENU_FRAME CGRectMake(140, 726, 744, 160)
#define MENU_OPEN_FRAME CGRectMake(140, 588, 744, 160)
#define MENU_CLOSE_FRAME CGRectMake(140, 726, 744, 160)

#define PEN_BTN_FRAME CGRectMake(30, 30, 50, 50)
#define ERASER_BTN_FRAME CGRectMake(30, 100, 50, 50)
#define LINE_BTN_FRAME CGRectMake(120, 30, 50, 50)
#define RECT_BTN_FRAME CGRectMake(120, 100, 50, 50)
#define ELLIPSE_BTN_FRAME CGRectMake(200, 30, 50, 50)
#define MOVE_BTN_FRAME CGRectMake(200, 100, 50, 50)
#define PICKER_FRAME CGRectMake(360.0, 30.0, 360.0, 70.0)
#define PICKER_TMP_VIEW_FRAME CGRectMake(0, 0, 100, 36)
#define PICKER_TMP_THICKNESS_FRAME CGRectMake(0, 0, 80, 3*(row+1))
#define PICKER_TMP_ALPHA_SETTER [tmpView setAlpha:1-0.1*row]

#define TABLE_HEADER_FRAME CGRectMake(20, 5, 140, 30)
#define TABLE_HEADER_FONT_SIZE 26.0f
#define TABLE_HEADER_HEIGHT 40

#define USER_LIST_FRAME CGRectMake(-140, 60, 160, 600)
#define USER_LIST_OPEN_FRAME CGRectMake(0, 60, 160, 600)
#define USER_LIST_CLOSE_FRAME CGRectMake(-140, 60, 160, 600)
#define USER_TABLE_FRAME CGRectMake(0, 10, 140, 580)
#define USER_HEADER_LABEL @"与会列表"
#define USER_CELL_HEIGHT 40

#define SNAP_LIST_FRAME CGRectMake(1004, 60, 160, 600)
#define SNAP_LIST_OPEN_FRAME CGRectMake(864, 60, 160, 600)
#define SNAP_LIST_CLOSE_FRAME CGRectMake(1004, 60, 160, 600)
#define SNAP_HIS_TABLE_FRAME CGRectMake(20, 110, 140, 480)
#define SNAP_CUR_BTN_FRAME CGRectMake(20, 10, 140, 100)
#define SNAP_HEADER_LABEL @"历史记录"
#define SNAP_CELL_HEIGHT 100

#define LOGIN_INPUT_FRAME CGRectMake(80, 10, 220, 24)
#define LOGIN_BTN_FRAME CGRectMake(610, 600, 60, 60)
#define LOGIN_NAME_PLACEHOLDER @"请输入账户"
#define LOGIN_PWD_PLACEHOLDER @"请输入密码"
#define CREATE_BTN_FRAME CGRectMake(330, 600, 60, 60)
#define JOIN_BTN_FRAME CGRectMake(470, 600, 60, 60)
#define CREATE_BTN_STR @"复制"
#define JOIN_BTN_STR @"加入"
#define MEETING_CODE_FRAME CGRectMake(20, 10, 260, 24)
#define MEETING_CODE_BTN_FRAME CGRectMake(290, 10, 46, 24)

#define CANVAS_DEFAULT_FRAME CGRectMake(0, 768, 1024, 100)
#define CANVAS_OPEN_FRAME CGRectMake(0, 0, 1024, 768)

#define DURATION 0.5f

#define LOGIN_VIEW_FRAME CGRectMake(300, 260, 30, 10)

#define unknown 0

#endif
