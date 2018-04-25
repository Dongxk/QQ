//
//  imageLabelBtn.m
//  仿QQ
//
//  Created by 董向坤 on 17/2/20.
//  Copyright © 2017年 董向坤. All rights reserved.
//

#import "imageLabelBtn.h"

@interface imageLabelBtn ()

@property (nonatomic, strong) UIImageView *ImgView;
@property (nonatomic, strong) UILabel     *lab;
@end
@implementation imageLabelBtn

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame WithImageView:(NSString *)image WithTitle:(NSString *)title{

    if ([super initWithFrame:frame]) {
        
        self.btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.btn setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self.btn setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:self.btn];
        
        
        self.ImgView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width / 2 - 18, 5, 36, 36)];
        self.ImgView.image = [UIImage imageNamed:image];
        [self.btn addSubview:self.ImgView];
        
        
        self.lab = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width / 2 - 30, self.ImgView.frame.origin.y + self.ImgView.frame.size.height + 2, 60, 16)];
        self.lab.textAlignment = 1;
        self.lab.font = [UIFont systemFontOfSize:13];
        self.lab.text = title;
        [self.btn addSubview:self.lab];

    }
    return self;
}



@end
