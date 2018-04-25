//
//  UIBaseViewController.m
//  仿QQ
//
//  Created by 董向坤 on 17/2/14.
//  Copyright © 2017年 董向坤. All rights reserved.
//

#import "UIBaseViewController.h"
#import "DrawerViewController.h"
#import "CommonMacro.h"
@interface UIBaseViewController ()

@end

@implementation UIBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.15 green:0.72 blue:0.95 alpha:1.00];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.15 green:0.72 blue:0.95 alpha:1.00];

}


-(void)initBack:(BOOL)booL{
    //初始化右侧白色箭头
    if (booL == YES) {
        UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 26, 20)];
        [backBtn addTarget:self action:@selector(navBack) forControlEvents:UIControlEventTouchUpInside];
        [backBtn setBackgroundImage:[UIImage imageNamed:@"v1_back_btn_d.png"] forState:UIControlStateNormal];
        [backBtn setBackgroundImage:[UIImage imageNamed:@"v1_back_btn_p.png"] forState:UIControlStateSelected];
        [backBtn setBackgroundImage:[UIImage imageNamed:@"v1_back_btn_p.png"] forState:UIControlStateHighlighted];
        
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -8;
        self.navigationItem.leftBarButtonItems = @[negativeSpacer, leftItem];
    }else{
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]init];
    }
}


-(void)navBack{
//    [self.navigationController popViewControllerAnimated:YES];
    [[DrawerViewController singletonDrawerViewController] swithToMainViewController];
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
