//
//  YKStringUtility.h
//  Moonbasa
//
//  Created by user on 11-7-8.
//  Copyright 2011 yek.com All rights reserved.
//

#import <Foundation/Foundation.h>


@interface YKStringUtility : NSObject {

}
/**
 安全获取字符串
 @param str 字符串
 @returns 若字符串为nil，则返回空字符串，否则直接返回字符串
 */
+(NSString*)strOrEmpty:(NSString*)str;
/**
 去掉首尾空格
 @param str 字符串
 @returns 去掉首尾空格的字符串
 */
+(NSString*)stripWhiteSpace:(NSString*)str;
/**
 去掉首尾空格和换行符
 @param str 字符串
 @returns 去掉首尾空格和换行符的字符串
 */
+(NSString*)stripWhiteSpaceAndNewLineCharacter:(NSString*)str;
/**
 将字符串转换为MD5码
 @param str 字符串
 @returns 已转码为MD5的字符串
 */
+(NSString*)YKMD5:(NSString*)str;

/**
	判断字符串是否符合Email格式。
	@param input 字符串
	@returns 布尔值 YES: 符合 NO: 不符合
 */
+(BOOL)isEmail:(NSString *)input;

/**
	判断字符串是否符合手机号格式。
	@param input 字符串
	@returns 布尔值 YES: 符合 NO: 不符合
 */
+(BOOL)isPhoneNum:(NSString *)input;

/**
	判断字符串是否符合电话格式。
	@param input 字符串
	@returns 布尔值 YES: 符合 NO: 不符合
 */
+(BOOL)isMobileNum:(NSString *)input;


// 判断是否是正确的手机号码
- (NSUInteger)isMobilePhoneNumber:(NSString *)_mobilePhoneNumber;
// 判断是否是正确的固话号码
- (NSUInteger)isTelephoneNumber:(NSString *)_telephoneNumber;
// 判断是否是正确的E-Mail地址
- (NSUInteger)isEMailString:(NSString *)_eMailString ;


@end

