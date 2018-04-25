//
//  CustomizeViewController.m
//  仿QQ
//
//  Created by 董向坤 on 2018/4/17.
//  Copyright © 2018年 Dongxk. All rights reserved.
//

#import "AppDelegate+AppService.h"
#import "DrawerViewController.h"
#import "SideBarViewController.h"
#import "MainTabBarViewController.h"

#import "AppManager.h"

@interface AppDelegate ()
@property (nonatomic, strong) UIView *leftViewController;
@property (nonatomic, strong) UIView *rightViewController;
@end


@implementation AppDelegate (AppService)


+ (AppDelegate *)shareAppDelegate{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}


- (void)initWindow{
    
    
     self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
     self.window.backgroundColor = [UIColor whiteColor];
     [self.window makeKeyAndVisible];
     if (@available(iOS 11.0, *)) {
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    
    SideBarViewController *sideBarVC = [[SideBarViewController alloc]init];
    MainTabBarViewController *mainVC = [[MainTabBarViewController alloc]init];
    DrawerViewController *rootViewController = [DrawerViewController drawerWithSideBarViewController:sideBarVC andMainViewController:mainVC andMaxWidth:300];
    self.window.rootViewController = rootViewController;
    
     [AppManager monitorFPS];
}

#pragma mark - 获取当前显示的控制器
-(UIViewController *)getCurrentVC{
    
    UIViewController *result = nil;
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    
    if (window.windowLevel != UIWindowLevelNormal){
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow *tmpWin in windows){
            if (tmpWin.windowLevel == UIWindowLevelNormal){
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

-(UIViewController *)getCurrentUIVC{
    UIViewController  *superVC = [self getCurrentVC];
    
    if ([superVC isKindOfClass:[UITabBarController class]]) {
        
        UIViewController *tabSelectVC = ((UITabBarController*)superVC).selectedViewController;
        
        if ([tabSelectVC isKindOfClass:[UINavigationController class]]) {
            
            return ((UINavigationController*)tabSelectVC).viewControllers.lastObject;
        }
        return tabSelectVC;
    }else
        if ([superVC isKindOfClass:[UINavigationController class]]) {
            
            return ((UINavigationController*)superVC).viewControllers.lastObject;
        }
    return superVC;
}


@end
