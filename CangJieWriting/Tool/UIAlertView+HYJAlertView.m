//
//  UIAlertView+HYJAlertView.m
//  CangJieWriting
//
//  Created by 张文峰 on 15/9/4.
//  Copyright © 2015年 皓月君. All rights reserved.
//

#import "UIAlertView+HYJAlertView.h"

@implementation UIAlertView (HYJAlertView)

+ (void)showAnAlertViewWithOptions:(NSDictionary *)options {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:options[@"title"] message:options[@"message"] delegate:options[@"delegate"] cancelButtonTitle:options[@"cancel"] otherButtonTitles:options[@"others"], nil];
    [alertView show];
}

+ (void)showAnAlertViewForNoNetworkAccess {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"哎呀！网络被吃掉了！" message:@"请检查您的WiFi、蜂窝数据等\n网络设置及状态！" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
    [alertView show];
}

@end
