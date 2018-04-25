//
//  MainTabBarViewController.m
//  仿QQ
//
//  Created by 董向坤 on 17/2/15.
//  Copyright © 2017年 董向坤. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "DrawerViewController.h"
#import "MessageViewController.h"
#import "ContactsViewController.h"
#import "DynamicViewController.h"

@interface MainTabBarViewController ()
@property (nonatomic, strong)UIBarButtonItem *openDrawerIcon;
@end

@implementation MainTabBarViewController

- (instancetype)init{
    
    self = [super init];
    if (self) {
        [self setUpUI];
    }
    
    return self;
}

- (void)setUpUI{
    MessageViewController *messageViewController = [[MessageViewController alloc]init];
    [self addChildViewController:messageViewController andTabTitle:@"消息" andDefaultImageName:@"tab_recent_nor" andSelectedImageName:@"tab_recent_press"];
    ContactsViewController *friendViewController = [[ContactsViewController alloc]init];
    [self addChildViewController:friendViewController andTabTitle:@"联系人" andDefaultImageName:@"tab_buddy_nor" andSelectedImageName:@"tab_buddy_press"];
    DynamicViewController *dynamicsViewController = [[DynamicViewController alloc]init];
    [self addChildViewController:dynamicsViewController andTabTitle:@"动态" andDefaultImageName:@"tab_qworld_nor" andSelectedImageName:@"tab_qworld_press"];
}


/**
 根据传入的标题和图片创建子控制器
 
 @param childController   要添加的子控制器
 @param title             标题
 @param defaultImageName  tabBarItem的默认图片
 @param selectedImageName tabBarItem的选中图片
 */


-(void)addChildViewController:(UIViewController *)childController andTabTitle:(NSString *)title andDefaultImageName:(NSString *)defaultImageName andSelectedImageName:(NSString *)selectedImageName{
    
    UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:childController];
    [self addChildViewController:navigation];
    
    childController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"head@2x"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(clickLeftBarButtonItemAction:)];
    
    //    if ([title isEqualToString:@"消息"]) {
    //        UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@"消息",@"电话",nil]];
    //        segmentedControl.tintColor = [UIColor purpleColor];
    //        segmentedControl.backgroundColor = [UIColor whiteColor];
    //        segmentedControl.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * 0.5 - 80, 20, 160, 30);
    //        childController.navigationController.navigationBar.shadowImage = [UIImage imageNamed:@""];
    //        segmentedControl.selected = YES;
    //        segmentedControl.selectedSegmentIndex = 0;
    //        childController.navigationItem.titleView = segmentedControl;
    //
    //        childController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"run10"] style:UIBarButtonItemStylePlain target:self action:@selector(openDrawer)];
    //    }
    //    if (![title isEqualToString:@"消息"]) {
    //         childController.navigationItem.title = title;
    //    }
    
    childController.tabBarItem.title = title;
    [childController.tabBarItem setImage:[UIImage imageNamed:defaultImageName]];
    [childController.tabBarItem setSelectedImage:[UIImage imageNamed:selectedImageName]];
}

- (void)clickLeftBarButtonItemAction:(id)sender{
    
    [self openDrawer];
}

/**
 打开抽屉
 */
- (void)openDrawer{
    [[DrawerViewController singletonDrawerViewController] openDrawerWithOpenDuration:0.2];
}


/**
 关闭抽屉
 */
- (void)closeDrawer{
    [[DrawerViewController singletonDrawerViewController] closeDrawerWithOpenDuration:0.2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
