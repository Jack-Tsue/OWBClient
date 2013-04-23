//
//  common.h
//  OwbClient
//
//  Created by  tsgsz on 4/7/13.
//  Copyright (c) 2013 tsgsz. All rights reserved.
//

#ifndef OwbClient_pref_h
#define OwbClient_pref_h

#define ScreenHeight    320
#define ScreenWidth     640

#define MENU_FRAME CGRectMake(140, 726, 744, 160)
#define MENU_OPEN_FRAME CGRectMake(140, 588, 744, 160)
#define MENU_CLOSE_FRAME CGRectMake(140, 726, 744, 160)

#define PEN_BTN_FRAME CGRectMake(20, 20, 50, 50)
#define ERASER_BTN_FRAME CGRectMake(20, 90, 50, 50)
#define LINE_BTN_FRAME CGRectMake(120, 20, 50, 50)
#define RECT_BTN_FRAME CGRectMake(120, 90, 50, 50)
#define ELLIPSE_BTN_FRAME CGRectMake(200, 20, 50, 50)
#define PICKER_FRAME CGRectMake(360.0, 0.0, 320.0, 100.0)
#define PICKER_TMP_VIEW_FRAME CGRectMake(0, 0, 30, 30)
#define PICKER_TMP_THICKNESS_FRAME CGRectMake(0, 0, 30, 3*(row+1))
#define PICKER_TMP_ALPHA_SETTER [tmpView setAlpha:1-0.1*row]


#define USER_LIST_FRAME CGRectMake(-120, 60, 140, 600)
#define USER_LIST_OPEN_FRAME CGRectMake(0, 60, 140, 600)
#define USER_LIST_CLOSE_FRAME CGRectMake(-120, 60, 140, 600)

#define SNAP_LIST_FRAME CGRectMake(1004, 60, 140, 600)
#define SNAP_LIST_OPEN_FRAME CGRectMake(884, 60, 140, 600)
#define SNAP_LIST_CLOSE_FRAME CGRectMake(1004, 60, 140, 600)

#define LOGIN_INPUT_FRAME CGRectMake(80, 10, 220, 24)
#define LOGIN_BTN_FRAME CGRectMake(610, 500, 60, 60)
#define LOGIN_NAME_PLACEHOLDER @"请输入账户"
#define LOGIN_PWD_PLACEHOLDER @"请输入密码"
#define CREATE_BTN_FRAME CGRectMake(330, 500, 60, 60)
#define JOIN_BTN_FRAME CGRectMake(470, 500, 60, 60)
#define CREATE_BTN_STR @"复制"
#define JOIN_BTN_STR @"加入"
#define MEETING_CODE_FRAME CGRectMake(20, 10, 260, 24)
#define MEETING_CODE_BTN_FRAME CGRectMake(290, 10, 46, 24)

#define CANVAS_DEFAULT_FRAME CGRectMake(0, 726, 1024, 100)
#define CANVAS_OPEN_FRAME CGRectMake(0, 0, 1024, 768)

#define DURATION 0.5f

#define LOGIN_VIEW_FRAME CGRectMake(300, 260, 30, 10)

#define unknown 0

#endif
