//
//  SearchViewController.m
//  仿QQ
//
//  Created by 董向坤 on 17/2/21.
//  Copyright © 2017年 董向坤. All rights reserved.
//

#import "SearchViewController.h"
#import "CommonMacro.h"
@interface SearchViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *searchTF;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.view.backgroundColor = [UIColor whiteColor];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBar.hidden = YES;
    [self initViews];
}


- (void)initViews{

   _searchTF = [[UITextField alloc]initWithFrame:CGRectMake(5, 24, ScreenWidth - 50, 26)];
    _searchTF.backgroundColor = [UIColor colorWithRed:0.93 green:0.94 blue:0.95 alpha:1.00];
    _searchTF.placeholder = @" 🔍搜索";
    _searchTF.layer.cornerRadius = 2;
    _searchTF.delegate = self;
    _searchTF.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:_searchTF];

    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    cancelBtn.frame = CGRectMake(_searchTF.frame.origin.x + _searchTF.frame.size.width + 5, _searchTF.frame.origin.y, 40, _searchTF.frame.size.height);
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor colorWithRed:0.66 green:0.66 blue:0.66 alpha:1.00] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(clickCancelBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelBtn];
}

- (void)clickCancelBtnAction:(id)sender{

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated{

    [_searchTF becomeFirstResponder];
    
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
