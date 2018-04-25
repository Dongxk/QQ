//
//  MessageViewController.m
//  仿QQ
//
//  Created by 董向坤 on 17/2/14.
//  Copyright © 2017年 董向坤. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageTableViewCell.h"
#import "AddTableViewCell.h"
#import "CustomizeViewController.h"
#import "DrawerViewController.h"
#import "PhoneTableViewCell.h"
#import "SearchViewController.h"


@interface MessageViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataSourceArray;
@property (strong, nonatomic) UITableView *addTableView;
@property (strong, nonatomic) NSArray *titleArray;
@property (strong, nonatomic) NSArray *imageArray;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIView *shadeView;


@end

@implementation MessageViewController{

    NSInteger addFlag;
    NSInteger segmentFlag;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [self initNavigationBar];
    [self initTableHeaderView];
    
    [_tableView registerNib:[UINib nibWithNibName:@"MessageTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [_tableView registerNib:[UINib nibWithNibName:@"PhoneTableViewCell" bundle:nil] forCellReuseIdentifier:@"phoneCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"QQChatTableViewCell" bundle:nil] forCellReuseIdentifier:@"chatCell"];
    _tableView.tableFooterView = [[UIView alloc]init];
    _tableView.showsVerticalScrollIndicator = NO;
    //去掉tableview的分割线与左边缘的间距（15px）
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        _tableView.separatorInset = UIEdgeInsetsMake(0, 48, 0, 0);
    }
    
    [self addTableView];
    self.titleArray = @[@"创建群聊", @"加好友／群", @"扫一扫", @"面对面快传", @"付款", @"拍摄", @"面对面红包"];
    self.imageArray = @[@"创建团队", @"创建员工", @"扫一扫", @"面对面快传", @"付款", @"拍摄", @"红包"];
    
    segmentFlag = 0;
}

- (UITableView *)addTableView{

    if (!_addTableView) {
        
        addFlag = 0;
        self.window = [UIApplication sharedApplication].keyWindow;
        self.shadeView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        self.shadeView.backgroundColor = [UIColor clearColor];
        self.shadeView.hidden = YES;
        self.shadeView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureAction:)];
        [self.shadeView addGestureRecognizer:tapGesture];
        [self.window addSubview:self.shadeView];
        
        _addTableView = [[UITableView alloc]initWithFrame:CGRectMake(ScreenWidth - 150, 66, 148, 280) style:UITableViewStylePlain];
        _addTableView.delegate = self;
        _addTableView.dataSource = self;
        _addTableView.tableFooterView = [[UIView alloc]init];
        _addTableView.scrollEnabled = NO;
        if ([_addTableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [_addTableView setSeparatorInset:UIEdgeInsetsZero];
        }
        _addTableView.layer.borderWidth = 1;
        _addTableView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _addTableView.layer.cornerRadius = 3;
        [self.shadeView addSubview:_addTableView];
       
        
        [_addTableView registerNib:[UINib nibWithNibName:@"AddTableViewCell" bundle:nil] forCellReuseIdentifier:@"addCell"];
    }
    return _addTableView;
}

-(void)initNavigationBar{

    NSArray *array = @[@"消息", @"电话"];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:array];
    segmentedControl.frame = CGRectMake(ScreenWidth / 2 - 40, 14, 80, 24);
    segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.tintColor = [UIColor whiteColor];
    [segmentedControl addTarget:self action:@selector(clickSegmentedControlAction:) forControlEvents:UIControlEventValueChanged];
    [self.navigationController.navigationBar addSubview:segmentedControl];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(clickRightBarButtonItemAction:)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
}

- (void)initTableHeaderView{

    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 30.0f)];
    
    UIButton *searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 8, ScreenWidth - 10, 23)];
    [searchBtn setTitle:@"🔍搜索" forState:UIControlStateNormal];
    [searchBtn setTitleColor:[UIColor colorWithRed:0.79 green:0.79 blue:0.80 alpha:1.00] forState:UIControlStateNormal];
    [searchBtn setBackgroundColor:[UIColor colorWithRed:0.93 green:0.94 blue:0.95 alpha:1.00]];
    searchBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    searchBtn.layer.cornerRadius = 2;
    searchBtn.layer.borderColor = [UIColor colorWithRed:0.93 green:0.94 blue:0.95 alpha:1.00].CGColor;
    [searchBtn addTarget:self action:@selector(clickSearchBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:searchBtn];
    self.tableView.tableHeaderView = headerView;
}

- (void)clickSegmentedControlAction:(UISegmentedControl *)segmentControl{

    if (segmentControl.selectedSegmentIndex == 0) {
        segmentFlag = 0;
        [_tableView reloadData];
    }else{
        segmentFlag = 1;
        [_tableView reloadData];
    }
}

- (void)clickRightBarButtonItemAction:(id)sender{
    
    if (addFlag == 0) {
        self.shadeView.hidden = NO;
        addFlag = 1;
    }else{
        self.shadeView.hidden = YES;
        addFlag = 0;
    }
    
}

- (void)clickSearchBtnAction:(id)sender{

    
    SearchViewController *sVC = [[SearchViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:sVC];
    [self presentViewController:nav animated:YES completion:nil];


}

- (void)tapGestureAction:(UITapGestureRecognizer *)tapGesture{

    self.shadeView.hidden = YES;
    addFlag = 0;
    self.window.frame = [UIScreen mainScreen].bounds;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    if (segmentFlag == 1) {
        return 2;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (segmentFlag == 1) {
        
        if (section == 0) {
            return 2;
        }
        return 1;
    }else{
        if (tableView == _tableView) {
            return self.titleArray.count;
        }
        return self.titleArray.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (segmentFlag == 0) {
        if (tableView == _tableView) {
            MessageTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            return cell;
            
        }else{
            AddTableViewCell *addCell = [_addTableView dequeueReusableCellWithIdentifier:@"addCell" forIndexPath:indexPath];
            addCell.leftImg.image = [UIImage imageNamed:self.imageArray[indexPath.row]];
            addCell.rightLab.text = self.titleArray[indexPath.row];
            return addCell;
        }
    }else{
        
        if (indexPath.section == 0) {
           
            PhoneTableViewCell *phoneCell = [_tableView dequeueReusableCellWithIdentifier:@"phoneCell" forIndexPath:indexPath];
            phoneCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            if (indexPath.row == 1) {
                phoneCell.leftImg.image = [UIImage imageNamed:@"通讯录"];
                phoneCell.rightLab.text = @"通讯录";
            }
            return phoneCell;
            
        }else{

        }
        
    }
    return [[UITableViewCell alloc]init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (segmentFlag == 1) {
        if (indexPath.section == 0) {
            return 60.0f;
        }
        return 500.0f;
        
    }else{
        if (tableView == _tableView) {
            return 60.0f;
        }
        return 40.0f;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView == _tableView) {
        if (addFlag == 1) {
            self.addTableView.hidden = YES;
            addFlag = 0;
        }else{
            ToastMsgHUD(@"点击cell", 1);
        }
        
    }else{
        
        CustomizeViewController *cVC = [[CustomizeViewController alloc]init];
        cVC.titleStr = self.titleArray[indexPath.row];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:cVC];
        [[DrawerViewController singletonDrawerViewController] switchViewController:nav];
    }
}

#pragma mark --------  编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{

    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{

    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{

    if (UITableViewCellEditingStyleDelete == editingStyle) {
       
        ToastMsgHUD(@"删除", 1);
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
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
