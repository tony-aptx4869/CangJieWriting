//
//  UIAlertView+HYJAlertView.h
//  CangJieWriting
//
//  Created by 张文峰 on 15/9/4.
//  Copyright © 2015年 皓月君. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (HYJAlertView)

+ (void)showAnAlertViewWithOptions:(NSDictionary *)options;
+ (void)showAnAlertViewForNoNetworkAccess;

@end
