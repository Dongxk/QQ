//
//  ContactsViewController.m
//  仿QQ
//
//  Created by 董向坤 on 17/2/14.
//  Copyright © 2017年 董向坤. All rights reserved.
//

#import "ContactsViewController.h"
#import "MessageTableViewCell.h"
#import "ContactsHeaderView.h"
#import "CustomizeViewController.h"
#import "DrawerViewController.h"
#import "imageLabelBtn.h"
#import "SearchViewController.h"

@interface ContactsViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *sectionFlagArray;
@property (nonatomic, strong) ContactsHeaderView *headerView;
@end

@implementation ContactsViewController{

    NSInteger sanjiaoxingFlag;
    NSMutableDictionary *didSelectedDic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"联系人";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(clickRightBarBtnItem:)];
    
    [self initTableHeaderView];
    
    [_tableView registerNib:[UINib nibWithNibName:@"MessageTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        _tableView.separatorInset = UIEdgeInsetsMake(0, 48, 0, 0);
    }

    sanjiaoxingFlag = 0;
    self.sectionFlagArray = [NSMutableArray array];
    for (NSInteger i = 0; i < 7; i++) {
        [self.sectionFlagArray addObject:@"0"];
    }
}

- (void)clickRightBarBtnItem:(id)sender{

    ToastMsgHUD(@"点击添加", 1);
}

- (void)initTableHeaderView{
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 120)];
    headerView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = headerView;
    
    UIButton *searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 8, ScreenWidth - 10, 23)];
    [searchBtn setTitle:@"🔍搜索" forState:UIControlStateNormal];
    [searchBtn setTitleColor:[UIColor colorWithRed:0.79 green:0.79 blue:0.80 alpha:1.00] forState:UIControlStateNormal];
    [searchBtn setBackgroundColor:[UIColor colorWithRed:0.93 green:0.94 blue:0.95 alpha:1.00]];
    searchBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    searchBtn.layer.cornerRadius = 2;
    searchBtn.layer.borderColor = [UIColor colorWithRed:0.93 green:0.94 blue:0.95 alpha:1.00].CGColor;
    [searchBtn addTarget:self action:@selector(clickSearchBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:searchBtn];
    
    NSArray *imageArray = @[@"新朋友", @"朋友", @"公众号"];
    NSArray *titleArray = @[@"新朋友", @"群聊", @"公众号"];
    for (NSInteger i = 0; i < 3; i++) {
        imageLabelBtn *btn = [[imageLabelBtn alloc]initWithFrame:CGRectMake(ScreenWidth / 3 * i, searchBtn.frame.origin.y + searchBtn.frame.size.height + 10, ScreenWidth / 3, 60) WithImageView:imageArray[i] WithTitle:titleArray[i]];
        btn.btn.tag = 1000 + i;
        [btn.btn addTarget:self action:@selector(clickBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:btn];
    }
    
    UILabel *grayLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 110, ScreenWidth, 6.2f)];
    grayLab.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1.00];
    [headerView addSubview:grayLab];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 7;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if ([self.sectionFlagArray[section] isEqualToString:@"1"]) {
        return 2;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 60.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 35.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (section == 1 || section == 4) {
        return 6.2f;
    }
    return .5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    MessageTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.contactsNameLab.text = NSLocalizedString(@"User_NickName", nil);
    cell.dateLab.hidden = YES;
    cell.contentLab.text = NSLocalizedString(@"User_Signature", nil);
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    self.headerView = [[ContactsHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 35.0)];
    [self.headerView.bgBtn addTarget:self action:@selector(clickbgBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.headerView.flag = 1;
    self.headerView.bgBtn.tag = section + 1000;
    switch (section) {
        case 0:
            self.headerView.middleLab.text = @"特别关心";
            break;
        case 1:
            self.headerView.middleLab.text = @"常见群聊";
            break;
        case 2:
            self.headerView.middleLab.text = @"我的好友";
            break;
        case 3:
            self.headerView.middleLab.text = @"家人";
            break;
        case 4:
            self.headerView.middleLab.text = @"朋友";
            break;
        case 5:
            self.headerView.middleLab.text = @"手机通讯录";
            break;
        case 6:
            self.headerView.middleLab.text = @"我的设备";
            break;
        default:
            break;
    }
    return self.headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    

}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{

    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{

    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        ToastMsgHUD(@"点击特别关心", 1);
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{

    return @"设为特别关心";
}

- (void)clickSearchBtnAction:(id)sender{
    
    SearchViewController *sVC = [[SearchViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:sVC];
    [self presentViewController:nav animated:YES completion:nil];
    
}

- (void)clickbgBtnAction:(UIButton *)sender{

    
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:sender.tag - 1000];
    NSUInteger selectedSection = sender.tag - 1000;
    
    if ([[_sectionFlagArray objectAtIndex:selectedSection] isEqualToString:@"1"]) {
        
        [_sectionFlagArray replaceObjectAtIndex:selectedSection withObject:@"0"];
        [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        self.headerView.leftImg.transform = CGAffineTransformMakeRotation(0);
       
    }else{
        
        [_sectionFlagArray replaceObjectAtIndex:selectedSection withObject:@"1"];
        [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        self.headerView.leftImg.transform = CGAffineTransformMakeRotation(M_PI_2);
    }
    
}

- (void)clickBtnAction:(UIButton *)sender{

    switch (sender.tag) {
        case 1000:
            ToastMsgHUD(@"点击新朋友", 1);
            break;
        case 1001:
            ToastMsgHUD(@"点击群聊", 1);
            break;
        case 1002:
            ToastMsgHUD(@"点击公众号", 1);
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
