//
//  SBPublicFormatValidation.h
/**
 version:1.0
 */
//  Created by bonan on 13-6-23.
//  Copyright (c) 2014年 xie xianhui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SBPublicFormatValidation : NSObject

//判断字符串中是否全是汉字
+ (BOOL)boolStringAllHaveChinese:(NSString *)str;

//判断字符串中不能出现汉字
+ (BOOL)boolStringNotHaveChinese:(NSString *)str;

//验证邮箱格式
+ (BOOL)boolEmailCheckNumInput:(NSString *)_text;

//验证电话号码格式是否正确
+ (BOOL)boolCheckPhoneNumInput:(NSString *)paramPhoneNum;
@end



@interface NSString (TrimeWhiteSpaceAndNewLine)


-(NSString *)stringByTrimmingWhiteSpaceAndNewLine;
//判断手机号码
+(BOOL)isValidTelephoneNum2:(NSString *)strPhoneNum;

//判断身份证号是不是正确
+(BOOL)stringByIdentityCardNumberisCorrect:(NSString *)identityCardNumber;

//验证邮箱的合法性
+(BOOL)isValidateEmail:(NSString *)email;
+ (BOOL)isUserPwdValid:(NSString *)pwd;


@end
