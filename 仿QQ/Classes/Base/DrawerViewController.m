//
//  DrawerViewController.m
//  仿QQ
//
//  Created by 董向坤 on 17/2/15.
//  Copyright © 2017年 董向坤. All rights reserved.
//

#import "DrawerViewController.h"
#import "MainTabBarViewController.h"
#import "SideBarViewController.h"

@interface DrawerViewController ()
@property (nonatomic, strong) MainTabBarViewController    *mainVC;
@property (nonatomic, strong) SideBarViewController *sideBarVC;
@property (nonatomic, strong) UIButton *coverButton;
@property (nonatomic, assign) CGFloat drawerMaxWidth;
@property (nonatomic, strong) UIViewController *destViewController;
@end

@implementation DrawerViewController

+ (instancetype)singletonDrawerViewController{
    return (DrawerViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
}

/**
 创建抽屉
 @param sideBarViewController 左边控制器
 @param mainViewController 主控制器
 */
+ (instancetype)drawerWithSideBarViewController:(UIViewController *)sideBarViewController andMainViewController:(UIViewController *)mainViewController andMaxWidth:(CGFloat)maxWidth{
    
    DrawerViewController *drawerVC = [[DrawerViewController alloc]init];
    drawerVC.mainVC = (MainTabBarViewController *)mainViewController;
    drawerVC.sideBarVC = (SideBarViewController *)sideBarViewController;
    drawerVC.drawerMaxWidth = maxWidth;
    
    for (UIViewController *childVC in mainViewController.childViewControllers) {
        childVC.view.backgroundColor = [UIColor whiteColor];
    }
    
    [drawerVC.view addSubview:sideBarViewController.view];
    [drawerVC.view addSubview:mainViewController.view];
    [drawerVC addChildViewController:sideBarViewController];
    [drawerVC addChildViewController:mainViewController];
    sideBarViewController.view.transform = CGAffineTransformMakeTranslation(-maxWidth, 0);
    return drawerVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.mainVC.view.layer.shadowColor = [UIColor blackColor].CGColor;
    self.mainVC.view.layer.shadowOffset = CGSizeMake(-1, -1);
    self.mainVC.view.layer.shadowRadius = 4;
    self.mainVC.view.layer.shadowOpacity = 0.8;
    
    for (UIViewController *childViewController in self.mainVC.childViewControllers) {
        [self addScreenEdgePanGestureRecognizerToView:childViewController.view];
    }
}

/**
 打开抽屉效果
 */
- (void)openDrawerWithOpenDuration:(CGFloat)openDuration{
    
    [UIView animateWithDuration:openDuration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.mainVC.view.transform = CGAffineTransformMakeTranslation(self.drawerMaxWidth, 0);
        self.sideBarVC.view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self.mainVC.view addSubview:self.coverButton];
        [self addPanGestureRecognizerToView:self.coverButton];
    }];
}

/**
 关闭抽屉效果
 */
- (void)closeDrawerWithOpenDuration:(CGFloat)openDuration{
    [UIView animateWithDuration:openDuration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.mainVC.view.transform = CGAffineTransformIdentity;
        self.sideBarVC.view.transform = CGAffineTransformMakeTranslation(-self.drawerMaxWidth, 0);
    } completion:^(BOOL finished) {
        
        if (self.coverButton) {
            [self.coverButton removeFromSuperview];
            self.coverButton = nil;
        }
    }];
}

/**
 选择左侧控制器后进行跳转
 */
- (void)switchViewController:(UIViewController *)viewController{
    [self.view addSubview:viewController.view];
    [self addChildViewController:viewController];
    self.destViewController = viewController;
    
    viewController.view.transform = CGAffineTransformMakeTranslation(ScreenWidth, 0);
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        viewController.view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        self.mainVC.view.transform = CGAffineTransformIdentity;
        [self.coverButton removeFromSuperview];
        self.coverButton = nil;
    }];
}

/**
 跳回主控制器
 */
- (void)swithToMainViewController{
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        self.destViewController.view.transform = CGAffineTransformMakeTranslation(ScreenWidth, 0);
        
    } completion:^(BOOL finished) {
        [self.destViewController removeFromParentViewController];
        [self.destViewController.view removeFromSuperview];
        self.destViewController = nil;
    }];
}

/**
 创建边缘拖拽手势
 */
- (void)addScreenEdgePanGestureRecognizerToView:(UIView *)view{
    UIScreenEdgePanGestureRecognizer *pan = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(screenEdgePanGestureRecognizer:)];
    pan.edges = UIRectEdgeLeft;
    [view addGestureRecognizer:pan];
}

/**
 边缘拖拽手势的回调
 */
- (void)screenEdgePanGestureRecognizer:(UIScreenEdgePanGestureRecognizer *)pan{
    
    CGFloat OffsetX = [pan translationInView:pan.view].x;
    
    if (pan.state == UIGestureRecognizerStateCancelled || pan.state == UIGestureRecognizerStateFailed || pan.state == UIGestureRecognizerStateEnded) {
        
        if (OffsetX > ScreenWidth * 0.5) {
            [self openDrawerWithOpenDuration:((self.drawerMaxWidth - OffsetX) / self.drawerMaxWidth) * 0.2];
        }else{
            [self closeDrawerWithOpenDuration:(OffsetX / self.drawerMaxWidth) * 0.2];
        }
        
    }else if(pan.state == UIGestureRecognizerStateChanged){
        if (OffsetX > 0 && OffsetX < self.drawerMaxWidth) {
            self.mainVC.view.transform = CGAffineTransformMakeTranslation(OffsetX, 0);
            self.sideBarVC.view.transform = CGAffineTransformMakeTranslation(-self.drawerMaxWidth + OffsetX, 0);
        }
    }
}


/**
 创建拖动手势，添加到覆盖按钮上
 */
- (void)addPanGestureRecognizerToView:(UIButton *)button{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureRecognizer:)];
    [button addGestureRecognizer:pan];
}


/**
 按钮拖动手势的回调
 */
- (void)panGestureRecognizer:(UIPanGestureRecognizer *)pan{
    CGFloat offsetX = [pan translationInView:pan.view].x;
    //    CGFloat SCREENWIDTH = SCREENBOUNDS.size.width;
    if (pan.state == UIGestureRecognizerStateFailed || pan.state == UIGestureRecognizerStateCancelled || pan.state == UIGestureRecognizerStateEnded ) {
        if (ScreenWidth - self.drawerMaxWidth + ABS(offsetX) > ScreenWidth * 0.5) {
            [self closeDrawerWithOpenDuration:((self.drawerMaxWidth - ABS(offsetX)) / self.drawerMaxWidth) * 0.2];
        }else{
            [self openDrawerWithOpenDuration:(ABS(offsetX) / self.drawerMaxWidth) * 0.2];
        }
    }else if (pan.state == UIGestureRecognizerStateChanged && offsetX < 0 && offsetX > - self.drawerMaxWidth){
        self.mainVC.view.transform = CGAffineTransformMakeTranslation(self.drawerMaxWidth + offsetX, 0);
        self.sideBarVC.view.transform = CGAffineTransformMakeTranslation(offsetX, 0);
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- lozyloding
-(UIButton *)coverButton{
    if (!_coverButton) {
        _coverButton = [[UIButton alloc]initWithFrame:[UIScreen mainScreen].bounds];
        [_coverButton addTarget:self.mainVC action:@selector(closeDrawer) forControlEvents:UIControlEventTouchUpInside];
    }
    return _coverButton;
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
