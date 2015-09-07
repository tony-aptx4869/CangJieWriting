//
//  HYJUTF8.m
//  CangJieWriting
//
//  Created by 张文峰 on 15/9/4.
//  Copyright © 2015年 皓月君. All rights reserved.
//

#import "HYJCharacter.h"
#import <UIKit/UIKit.h>
@implementation HYJCharacter

+ (NSString *)stringWithUTF8CodeString:(NSString *)utf8CodeString {
    int utf8[11] = {0};
    [self getUTF8CodesToCArray:utf8 FromUTF8CodeString:utf8CodeString];
    NSString *newString = [self stringByParsingUTF8CodesCArray:utf8];
    return newString;
}

+ (void)getUTF8CodesToCArray:(int *)utf8 FromUTF8CodeString:(NSString *)utf8CodeString {
    NSMutableString *mString = [utf8CodeString mutableCopy];
    int i = 0;
    while (1) {
        NSRange range = [mString rangeOfString:@","];
        if (!range.length) {
            break;
        }
        NSString *utf8String = [mString substringWithRange:NSMakeRange(0, range.location)];
        [mString deleteCharactersInRange:NSMakeRange(0, range.location + 1)];
        int utf8Value = [utf8String intValue];
        utf8[i ++] = utf8Value;
    }
}

+ (NSString *)stringByParsingUTF8CodesCArray:(int *)utf8 {
    NSMutableString *tempString = [NSMutableString string];
    for (int i = 0; i < 10; i ++) {
        [tempString appendFormat:@"\\u%02X", utf8[i]];
    }
    NSLog(@"%@", tempString);
    NSString *tempString2 = [tempString stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    tempString2 = [tempString2 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    tempString2 = [[@"\"" stringByAppendingString:tempString2] stringByAppendingString:@"\""];
    NSData *tempData = [tempString2 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *returnString = [NSPropertyListSerialization propertyListWithData:tempData
                                                                    options:NSPropertyListImmutable
                                                                     format:nil
                                                                      error:nil];
    NSLog(@"%@", returnString);
    return returnString;
}

//+ (NSString *)stringByParsingUTF8CodesCArray:(int *)utf8 {
//    NSMutableString *tempString = [NSMutableString string];
//    for (int i = 0; i < 10; i ++) {
//        int temp = (utf8[i] & 0xFF00) >> 8;
//        [tempString appendFormat:@"%%%02X", temp];
//        temp = utf8[i] & 0x00FF;
//        [tempString appendFormat:@"%%%02X", temp];
//    }
//}

+ (NSString *)handSingleDataForCharacterPathArray:(NSArray *)allPath {
//    handSingleData:@"100,101,102,103,99,98,-1,0"
    NSMutableString *handSingleData = [NSMutableString string];
    for (NSArray *currentPath in allPath) {
        int count = (int)[currentPath count];
        if (count > 8) {
            for (NSValue *pointValue in currentPath) {
                int index = (int)[currentPath indexOfObject:pointValue];
                if (!index || index == (int)(0.25 * count) || index == (int)(0.5 * count)
                    || index == (int)(0.75 * count) || index == (count - 1) ) {
                    CGPoint point = [pointValue CGPointValue];
                    [handSingleData appendFormat:@"%d,%d,", (int)point.x, (int)point.y];
                }
            }
        }else {
            for (NSValue *pointValue in currentPath) {
                CGPoint point = [pointValue CGPointValue];
                [handSingleData appendFormat:@"%d,%d,", (int)point.x, (int)point.y];
            }
        }
        if ([allPath indexOfObject:currentPath] != (allPath.count - 1)) {
            [handSingleData appendString:@"-1,0,"];
        }
    }
    [handSingleData appendString:@"-1,-1"];
    NSLog(@"%@", handSingleData);
    return [handSingleData copy];
}

+ (NSArray *)charactersArrayWithCharactersString:(NSString *)charactersString {
    NSMutableArray *charsArray = [NSMutableArray array];
    for (int i = 0; i < [charactersString length]; i ++) {
        NSString *charString = [charactersString substringWithRange:NSMakeRange(i, 1)];
        NSLog(@"%@", charString);
        [charsArray addObject:charString];
    }
    return [charsArray copy];
}

+ (NSString *)firstCharacterInCharactersString:(NSString *)charactersString {
    return [charactersString substringToIndex:1];
}

@end
