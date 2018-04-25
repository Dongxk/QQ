//
//  imageLabelBtn.h
//  仿QQ
//
//  Created by 董向坤 on 17/2/20.
//  Copyright © 2017年 董向坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface imageLabelBtn : UIView

- (instancetype)initWithFrame:(CGRect)frame WithImageView:(UIImage *)image WithTitle:(NSString *)title;

@property (nonatomic, strong) UIButton    *btn;

@end
