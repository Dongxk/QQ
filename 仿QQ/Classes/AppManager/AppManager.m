//
//  CustomizeViewController.m
//  仿QQ
//  Created by 董向坤 on 2018/4/17.
//  Copyright © 2018年 Dongxk. All rights reserved.
//

#import "AppManager.h"
#import "YYFPSLabel.h"

@implementation AppManager

+ (void)monitorFPS{
    
    YYFPSLabel *fpsLabel = [YYFPSLabel new];
    [fpsLabel sizeToFit];
    fpsLabel.bottom = ScreenHeight - 55;
    fpsLabel.right  = ScreenWidth  - 10;
    [[UIApplication sharedApplication].delegate.window addSubview:fpsLabel];
    
}
@end
