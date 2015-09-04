//
//  HWcloudsdk.h
//  wssdk
//
//  Created by mac on 14-5-30.
//  Copyright (c) 2014年 hanvon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIImage;

@interface HWCloudsdk : NSObject

//图片识别
//用户给定的图片
-(NSString *)cardLanguage:(NSString *)language
                cardImage:(UIImage *) cardImage
                   apiKey:(NSString *)apiKey;

//名片识别
//给定图品路径
- (NSString *) cardLanguage: (NSString *) language
                  imagePath:(NSString *) imagePath
                     apiKey:(NSString *) apiKey;

//名片识别
//给定图片Base64串
- (NSString *) cardLanguage: (NSString *) language
                   cardData:(NSString *) cardData
                     apiKey:(NSString *) apiKey;

//名片识别
//给定图片Base64串
//废弃的
- (NSString *) cardLanguage: (NSString *) language
                   cardData:(NSString *) cardData
                     apiKey:(NSString *) apiKey
                    apiCode:(NSString *) apiCode;

//名片识别
//给定图品路径
//废弃的
- (NSString *) cardLanguage: (NSString *) language
                  imagePath:(NSString *) imagePath
                     apiKey:(NSString *) apiKey
                    apiCode:(NSString *) apiCode;

//名片识别
//用户给定图片
//废弃的
-(NSString *)cardLanguage:(NSString *)language
                cardImage:(UIImage *) cardImage
                   apiKey:(NSString *)apiKey
                  apiCode:(NSString *)apiCode;

//文本识别
//用户给定图片
-(NSString *) lang:(NSString *) language
         textImage:(UIImage *) textImage
            apiKey:(NSString *) apiKey;

//文本识别
//用户给定路径
-(NSString *) lang:(NSString *) language
         imagePath:(NSString *) imagePath
            apiKey:(NSString *) apiKey;

//文本识别
//图片base64字符串
- (NSString *) lang:(NSString *) language
           textData: (NSString *) data
             apiKey:(NSString *) apiKey;

//文本识别
//图片base64字符串
//废弃的
- (NSString *) lang:(NSString *) language
           textData: (NSString *) data
             apiKey:(NSString *) apiKey
            apiCode:(NSString *) apiCode;

//文本识别
//用户给定路径
//废弃的
-(NSString *) lang:(NSString *) language
         imagePath:(NSString *) imagePath
            apiKey:(NSString *) apiKey
           apiCode:(NSString *) apiCode;

//文本识别
//用户给定图片
//废弃的
-(NSString *) lang:(NSString *) language
         textImage:(UIImage *) textImage
            apiKey:(NSString *) apiKey
           apiCode:(NSString *) apiCode;

//单字手写识别
- (NSString *) type:(NSString *) type
                            lang:(NSString *) language
     handSingleData:(NSString *) data
              apiKey:(NSString *) apiKey;

//行手写识别
- (NSString *) lang:(NSString *) language
       handLineData:(NSString *) data
             apiKey:(NSString *) apiKey;

//叠写识别
- (NSString *) lang:(NSString *) language
       handRepeatData:(NSString *) data
             apiKey:(NSString *) apiKey;

//身份证识别
//身份证图片
-(NSString *)idCardImage:(UIImage *)idCardImage
                  apiKey:(NSString *) apiKey;

//身份证识别
//身份证图片的路径
-(NSString *)idCardImagePath:(NSString *)idCardImagePath
                      apiKey:(NSString *) apiKey;

//身份证识别
//身份证图片的base64字符串
- (NSString *)idCardData:(NSString *) data
                  apiKey:(NSString *) apiKey;

//人脸识别
//人脸的图片存放的路径
-(NSString *)faceImagePath:(NSString *)faceImagePath apiKey:(NSString *)apiKey;

//年龄、表情识别
//人脸的图片
-(NSString *)theFaceImage:(UIImage *)faceImage apiKey:(NSString *)apiKey;

//手写公式识别
-(NSString *)formulaData:(NSString *)formulaData
                  apiKey:(NSString *)apiKey;

@end
