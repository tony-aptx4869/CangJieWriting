//
//  HYJResourceManager.m
//  CangJieWriting
//
//  Created by 张文峰 on 15/9/4.
//  Copyright © 2015年 皓月君. All rights reserved.
//

#import "HYJResourceManager.h"
#import <UIKit/UIKit.h>
#import "NSString+HYJEncryption.h"

@implementation HYJResourceManager

+ (UIImage *)mattImageForScreenSize:(CGSize)screenSize {
    NSString *imageFileName = [self mattImageFileNameWithScreenSize:screenSize];
    NSString *imageFilePath = [[NSBundle mainBundle] pathForResource:imageFileName ofType:@"png" inDirectory:@"HYJWritingRes.bundle/Images/Matt"];
    return [UIImage imageNamed:imageFilePath];
}

+ (NSString *)mattImageFileNameWithScreenSize:(CGSize)screenSize {
    if ([self theScreenSize:screenSize isMatchingDevice:HYJDevice_iPhone4_4s]) {
        return @"matt_288x288";
    }else if ([self theScreenSize:screenSize isMatchingDevice:HYJDevice_iPhone5_5s_5c]) {
        return @"matt_288x288";
    }else if ([self theScreenSize:screenSize isMatchingDevice:HYJDevice_iPhone6]) {
        return @"matt_343x343";
    }else if ([self theScreenSize:screenSize isMatchingDevice:HYJDevice_iPhone6Plus]) {
        return @"matt_328x328";
    }else if ([self theScreenSize:screenSize isMatchingDevice:HYJDevice_iPad]) {
        return @"matt_328x328";
    }else {
        return @"matt_343x343";
    }
}

+ (UIImage *)smallMattImageForScreenSize:(CGSize)screenSize isSelected:(BOOL)selected {
    NSString *imageFileName = [self smallMattImageFileNameWithScreenSize:screenSize isSelected:selected];
    NSString *imageFilePath = [[NSBundle mainBundle] pathForResource:imageFileName ofType:@"png" inDirectory:@"HYJWritingRes.bundle/Images/Matt"];
    return [UIImage imageNamed:imageFilePath];
}

+ (NSString *)smallMattImageFileNameWithScreenSize:(CGSize)screenSize isSelected:(BOOL)selected{
    NSString *imageFileName = nil;
    if ([self theScreenSize:screenSize isMatchingDevice:HYJDevice_iPhone4_4s]) {
        imageFileName = @"small_matt_64x64";
    }else if ([self theScreenSize:screenSize isMatchingDevice:HYJDevice_iPhone5_5s_5c]) {
        imageFileName = @"small_matt_64x64";
    }else if ([self theScreenSize:screenSize isMatchingDevice:HYJDevice_iPhone6]) {
        imageFileName = @"small_matt_77x77";
    }else if ([self theScreenSize:screenSize isMatchingDevice:HYJDevice_iPhone6Plus]) {
        imageFileName = @"small_matt_74x74";
    }else if ([self theScreenSize:screenSize isMatchingDevice:HYJDevice_iPad]) {
        imageFileName = @"small_matt_77x77";
    }else {
        imageFileName = @"small_matt_77x77";
    }
    imageFileName = selected ? [imageFileName stringByAppendingString:@"_selected"]
                             : [imageFileName stringByAppendingString:@"_normal"];
    return imageFileName;
}

+ (CGFloat)heightOfCharacterButtonForScreenSize:(CGSize)screenSize {
    if ([self theScreenSize:screenSize isMatchingDevice:HYJDevice_iPhone4_4s]) {
        return 64;
    }else if ([self theScreenSize:screenSize isMatchingDevice:HYJDevice_iPhone5_5s_5c]) {
        return 64;
    }else if ([self theScreenSize:screenSize isMatchingDevice:HYJDevice_iPhone6]) {
        return 77;
    }else if ([self theScreenSize:screenSize isMatchingDevice:HYJDevice_iPhone6Plus]) {
        return 74;
    }else if ([self theScreenSize:screenSize isMatchingDevice:HYJDevice_iPad]) {
        return 77;
    }else {
        return 77;
    }
}

+ (BOOL)theScreenSize:(CGSize)screenSize isMatchingDevice:(HYJDevice)device {
    CGSize portraitSize = [self screenSizeOfDevice:device];
    return (screenSize.width == portraitSize.width && screenSize.height == portraitSize.height)
            || (screenSize.width == portraitSize.height && screenSize.height == portraitSize.width);
}

+ (CGSize)screenSizeOfDevice:(HYJDevice)device {
    switch (device) {
        case HYJDevice_iPhone4_4s:
            return CGSizeMake(320, 480);
        case HYJDevice_iPhone5_5s_5c:
            return CGSizeMake(320, 568);
        case HYJDevice_iPhone6:
            return CGSizeMake(375, 667);
        case HYJDevice_iPhone6Plus:
            return CGSizeMake(360, 640);
        case HYJDevice_iPad:
            return CGSizeMake(768, 1024);
        default:
            return CGSizeZero;
    }
}

@end
