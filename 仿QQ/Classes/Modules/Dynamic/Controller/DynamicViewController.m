//
//  DynamicViewController.m
//  仿QQ
//
//  Created by 董向坤 on 17/2/14.
//  Copyright © 2017年 董向坤. All rights reserved.
//

#import "DynamicViewController.h"
#import "CustomizeViewController.h"
#import "DrawerViewController.h"
#import "imageLabelBtn.h"
#import "DynamicTableViewCell.h"
#import "SearchViewController.h"

@interface DynamicViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation DynamicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"动态";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"更多" style:UIBarButtonItemStylePlain target:self action:@selector(clickRightBarBtnItem:)];
    
    [self initTableHeaderView];
    
    [_tableView registerNib:[UINib nibWithNibName:@"DynamicTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        _tableView.separatorInset = UIEdgeInsetsMake(0, 48, 0, 0);
    }

}

- (void)clickRightBarBtnItem:(id)sender{

    ToastMsgHUD(@"点击更多", 1);
}

- (void)initTableHeaderView{
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 120)];
    headerView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = headerView;
    
    UIButton *searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 8, ScreenWidth - 10, 23)];
    [searchBtn setTitle:@"🔍搜索电影/音乐/商品..." forState:UIControlStateNormal];
    [searchBtn setTitleColor:[UIColor colorWithRed:0.79 green:0.79 blue:0.80 alpha:1.00] forState:UIControlStateNormal];
    [searchBtn setBackgroundColor:[UIColor colorWithRed:0.93 green:0.94 blue:0.95 alpha:1.00]];
    searchBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    searchBtn.layer.cornerRadius = 2;
    searchBtn.layer.borderColor = [UIColor colorWithRed:0.93 green:0.94 blue:0.95 alpha:1.00].CGColor;
    [searchBtn addTarget:self action:@selector(clickSearchBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:searchBtn];
    
    NSArray *titleArray = @[@"好友动态", @"附近", @"兴趣部落"];
    NSArray *imageArray = @[@"好友动态", @"附近", @"兴趣"];
    for (NSInteger i = 0; i < 3; i++) {
        imageLabelBtn *btn = [[imageLabelBtn alloc]initWithFrame:CGRectMake(ScreenWidth / 3 * i, searchBtn.frame.origin.y + searchBtn.frame.size.height + 10, ScreenWidth / 3, 60) WithImageView:imageArray[i] WithTitle:titleArray[i]];
        btn.btn.tag = 1000 + i;
        [btn.btn addTarget:self action:@selector(clickBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:btn];
    }
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 6;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return .5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DynamicTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ToastMsgHUD(@"点击cell", 1);
    
}





- (void)clickSearchBtnAction:(id)sender{
    
    SearchViewController *sVC = [[SearchViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:sVC];
    [self presentViewController:nav animated:YES completion:nil];
    
}

- (void)clickBtnAction:(UIButton *)sender{
    
    switch (sender.tag) {
        case 1000:
            ToastMsgHUD(@"点击好友动态", 1);
            break;
        case 1001:
            ToastMsgHUD(@"点击附近", 1);
            break;
        case 1002:
            ToastMsgHUD(@"点击兴趣部落", 1);
            break;
        default:
            break;
    }

    
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
