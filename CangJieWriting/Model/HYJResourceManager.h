//
//  HYJResourceManager.h
//  CangJieWriting
//
//  Created by 张文峰 on 15/9/4.
//  Copyright © 2015年 皓月君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger, HYJDevice) {
    HYJDevice_iPhone4_4s,
    HYJDevice_iPhone5_5s_5c,
    HYJDevice_iPhone6,
    HYJDevice_iPhone6Plus,
    HYJDevice_iPad,
};

@interface HYJResourceManager : NSObject

+ (UIImage *)mattImageForScreenSize:(CGSize)screenSize;

@end
