//
//  ContactsHeaderView.m
//  仿QQ
//
//  Created by 董向坤 on 17/2/20.
//  Copyright © 2017年 董向坤. All rights reserved.
//

#import "ContactsHeaderView.h"
#import "CommonMacro.h"

@implementation ContactsHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{

    if ([super initWithFrame:frame]) {
        [self initViews];
    }
    return self;
}


- (void)initViews{
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.bgBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.bgBtn setBackgroundColor:[UIColor clearColor]];
    [self.bgBtn setFrame:self.frame];
    [self addSubview:self.bgBtn];
    
    
    self.leftImg = [[UIImageView alloc]init];
    self.leftImg.image = [UIImage imageNamed:@"小三角right"];
    [self.bgBtn addSubview:self.leftImg];
    
    self.rightLab = [[UILabel alloc]init];
    self.rightLab.text = @"20/187";
    self.rightLab.font = [UIFont systemFontOfSize:11];
    self.rightLab.textColor = [UIColor colorWithRed:0.83 green:0.83 blue:0.83 alpha:1.00];
    [self.bgBtn addSubview:self.rightLab];
    
    self.middleLab = [[UILabel alloc]init];
    self.middleLab.text = @"陌生的";
    self.middleLab.font = [UIFont systemFontOfSize:15];
    self.middleLab.textColor = [UIColor colorWithRed:0.01 green:0.01 blue:0.01 alpha:1.00];
    [self.bgBtn addSubview:self.middleLab];
}

- (void)layoutSubviews{

    [super layoutSubviews];
    
    self.leftImg.frame = CGRectMake(10, 10, 18, 18);
    self.rightLab.frame = CGRectMake(ScreenWidth - 45, 10, 40, 20);
    self.middleLab.frame = CGRectMake(self.leftImg.frame.origin.x + self.leftImg.frame.size.width, self.rightLab.frame.origin.y, ScreenWidth - self.leftImg.frame.size.width - self.rightLab.frame.size.width, self.rightLab.frame.size.height);
}

- (void)clickSection:(NSIndexPath *)indexPath{

    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        _leftImg.transform = CGAffineTransformMakeRotation(90);
        
    } completion:^(BOOL finished) {
        
    }];

}

@end
