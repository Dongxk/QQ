//
//  SideBarViewController.m
//  仿QQ
//
//  Created by 董向坤 on 17/2/15.
//  Copyright © 2017年 董向坤. All rights reserved.
//

#import "SideBarViewController.h"
#import "AddTableViewCell.h"
#import "DrawerViewController.h"
#import "CustomizeViewController.h"

@interface SideBarViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *titleArray;
@property (strong, nonatomic) NSArray *imageArray;
@end

@implementation SideBarViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _tableView.tableFooterView = [[UIView alloc]init];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerNib:[UINib nibWithNibName:@"AddTableViewCell" bundle:nil] forCellReuseIdentifier:@"addCell"];
    self.titleArray = @[@"了解会员特权", @"QQ钱包", @"个性装扮", @"我的收藏", @"我的相册", @"我的文件"];
    self.imageArray = @[@"皇冠", @"钱包", @"个性", @"我的收藏", @"相册", @"我的文件夹"];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    AddTableViewCell *addCell = [_tableView dequeueReusableCellWithIdentifier:@"addCell" forIndexPath:indexPath];
    addCell.leftImg.image = [UIImage imageNamed:self.imageArray[indexPath.row]];
    addCell.rightLab.text = self.titleArray[indexPath.row];
    addCell.rightLab.font = [UIFont systemFontOfSize:14];
    return addCell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CustomizeViewController *cVC = [[CustomizeViewController alloc]init];
    cVC.titleStr = _titleArray[indexPath.row];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:cVC];
    [[DrawerViewController singletonDrawerViewController] switchViewController:nav];
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
