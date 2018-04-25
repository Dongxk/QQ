//
//  CommonMacro.h
//  仿QQ
//
//  Created by 董向坤 on 17/2/14.
//  Copyright © 2017年 董向坤. All rights reserved.
//

#import "JGProgressHUD.h"


#ifndef CommonMacro_h
#define CommonMacro_h


#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height

#define MATCHW  ScreenWidth/375.0
#define MATCHH  ScreenHeight/667.0


static const JGProgressHUD * ToastHUD;
/*!默认文字提示框*/
#define initTextHUD(ToastHUD) ToastHUD = [[JGProgressHUD alloc] initWithStyle:JGProgressHUDStyleDark]; ToastHUD.interactionType = JGProgressHUDInteractionTypeBlockNoTouches; ToastHUD.indicatorView = nil;ToastHUD.position = JGProgressHUDPositionBottomCenter; ToastHUD.marginInsets = (UIEdgeInsets) { .top = 0.0f, .bottom = ScreenHeight / 5, .left = 0.0f, .right = 0.0f, };
/*!Toast一个提示，可以指定消息内容和现实时长*/
#define ToastMsgHUD(msg, dismissTime) initTextHUD(ToastHUD); ToastHUD.textLabel.text = msg; [ToastHUD showInView:self.navigationController.view]; [ToastHUD dismissAfterDelay:dismissTime];


#endif /* CommonMacro_h */

