//
//  DrawerViewController.h
//  仿QQ
//
//  Created by 董向坤 on 17/2/15.
//  Copyright © 2017年 董向坤. All rights reserved.
//

#import "UIBaseViewController.h"

@interface DrawerViewController : UIBaseViewController


+ (instancetype)drawerWithSideBarViewController:(UIViewController *)sideBarViewController andMainViewController:(UIViewController *)mainViewController andMaxWidth:(CGFloat)maxWidth;


//单例
+ (instancetype)singletonDrawerViewController;
- (void)openDrawerWithOpenDuration:(CGFloat)openDuration;
- (void)closeDrawerWithOpenDuration:(CGFloat)openDuration;

/**
 选择左侧控制器后进行跳转
 */
- (void)switchViewController:(UIViewController *)viewController;

/**
 跳回主控制器
 */
- (void)swithToMainViewController;

@end
