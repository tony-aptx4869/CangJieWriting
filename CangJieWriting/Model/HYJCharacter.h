//
//  HYJUTF8.h
//  CangJieWriting
//
//  Created by 张文峰 on 15/9/4.
//  Copyright © 2015年 皓月君. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYJCharacter : NSObject

+ (NSString *)stringWithUTF8CodeString:(NSString *)utf8CodeString;
+ (NSString *)handSingleDataForCharacterPathArray:(NSArray *)allPath;
+ (NSArray *)charactersArrayWithCharactersString:(NSString *)charactersString;
+ (NSString *)firstCharacterInCharactersString:(NSString *)charactersString;

@end
