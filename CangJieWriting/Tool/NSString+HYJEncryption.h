//
//  NSString+HYJEncryption.h
//  CangJieWriting
//
//  Created by 张文峰 on 15/9/7.
//  Copyright © 2015年 皓月君. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HYJEncryption)

///Encrypt the string using SHA1, and return the encrypted string. Welcome to visit http://www.haoyuejun.com if you have any problems.
- (NSString *)sha1;

///Encrypt the string using MD5, and return the encrypted string. Welcome to visit http://www.haoyuejun.com if you have any problems.
- (NSString *)md5;

///Encrypt the string using SHA1 + Base64, and return the encrypted string. Welcome to visit http://www.haoyuejun.com if you have any problems.
- (NSString *)sha1_base64;

///Encrypt the string using MD5 + Base64, and return the encrypted string. Welcome to visit http://www.haoyuejun.com if you have any problems.
- (NSString *)md5_base64;

@end
