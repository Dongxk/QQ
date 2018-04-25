//
//  CustomizeViewController.m
//  仿QQ
//
//  Created by 董向坤 on 2018/4/17.
//  Copyright © 2018年 Dongxk. All rights reserved.
//

#import "AppDelegate.h"


/**
 包含第三方和应用内业务的实现，减轻入口代码压力
 */

@interface AppDelegate (AppService)

//代理单例
+ (AppDelegate *)shareAppDelegate;

//初始化 window
-(void)initWindow;

//获取当前显示的控制器
-(UIViewController*) getCurrentVC;

-(UIViewController*) getCurrentUIVC;

@end
