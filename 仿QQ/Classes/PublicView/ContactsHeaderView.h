//
//  ContactsHeaderView.h
//  仿QQ
//
//  Created by 董向坤 on 17/2/20.
//  Copyright © 2017年 董向坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactsHeaderView : UIView
- (instancetype)initWithFrame:(CGRect)frame;

@property (nonatomic, strong) UIButton    *bgBtn;
@property (nonatomic, strong) UIImageView *leftImg;
@property (nonatomic, strong) UILabel     *middleLab;
@property (nonatomic, strong) UILabel     *rightLab;
@property (nonatomic, assign) NSInteger   flag;

- (void)clickSection:(NSIndexPath *)indexPath;

@end
