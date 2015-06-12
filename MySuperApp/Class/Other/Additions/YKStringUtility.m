//
//  YKStringUtility.m
//  Moonbasa
//
//  Created by user on 11-7-8.
//  Copyright 2011 yek.com All rights reserved.
//

#import "YKStringUtility.h"
#import "MYCommentAlertView.h"
#import <CommonCrypto/CommonDigest.h>
//#import "RegexKitLite.h"

#define NUM_OF_MOBILE_PHONE 11

//const NSString* REG_EMAIL = @"\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*";
//const NSString* REG_MOBILE = @"^(13[0-9]|15[0-9]|18[0-9])\\d{8}$";
//const NSString* REG_PHONE = @"^(([0\\+]\\d{2,3}-?)?(0\\d{2,3})-?)?(\\d{7,8})";//(-(\\d{3,}))?$";

@implementation YKStringUtility

/**
	安全获取字符串
	@param str 字符串
	@returns 若字符串为nil，则返回空字符串，否则直接返回字符串
 */
+(NSString*)strOrEmpty:(NSString*)str{
	return (str==nil?@"":str);
}

/**
	去掉首尾空格
	@param str 字符串
	@returns 去掉首尾空格的字符串
 */
+(NSString*)stripWhiteSpace:(NSString*)str{
	return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

/**
	去掉首尾空格和换行符
	@param str 字符串
	@returns 去掉首尾空格和换行符的字符串
 */
+(NSString*)stripWhiteSpaceAndNewLineCharacter:(NSString*)str{
	return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

/**
	将字符串转换为MD5码
	@param str 字符串
	@returns 已转码为MD5的字符串
 */
+(NSString*)YKMD5:(NSString*)str
{
	const char *cStr = [str UTF8String];
	unsigned char result[CC_MD5_DIGEST_LENGTH];
	
	CC_MD5( cStr, strlen(cStr), result );
	
	return [[NSString
			 stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
			 result[0], result[1],
			 result[2], result[3],
			 result[4], result[5],
			 result[6], result[7],
			 result[8], result[9],
			 result[10], result[11],
			 result[12], result[13],
			 result[14], result[15]
			 ] lowercaseString];
}

+(BOOL)isEmail:(NSString *)input{
    BOOL rs = YES;
    
    int atCount = 0;
    int pointCount = 0;
    int atLoc = -1;
    int pointLoc = -1;
    
    for (int i = 0; i < [input length]; ++i) {
        unichar c = [input characterAtIndex:i];
        if (c == 45 || c == 95 || (c > 47 && c < 58) || (c > 63 && c < 91) || (c > 96 && c < 123) || c == 46) {
            
        }else
        {
            return NO;
        }
        if (c == '@') {
            ++atCount;
            atLoc = i;
        }
        if (c == '.') {
            if (pointCount == 0) {
                pointLoc = i;
            }
            ++pointCount;
        }
    }
    do {
        if (atCount > 1) {
            rs = NO;
            break;
        }
        if (pointCount == 0) {
            rs = NO;
            break;
        }
        if (atLoc > pointLoc) {
            rs = NO;
            break;
        }
    } while (0);
	return rs;
}

+(BOOL)isPhoneNum:(NSString *)input{
    BOOL rs = YES;
    int areaCodeCount = 0;
    int splitCount = 0;
    int phoneNumCount = 0;
    for (int i = 0; i < [input length]; ++i) {
        unichar c = [input characterAtIndex:i];
        if (c == 45 || (c > 47 && c < 58)) {
            
        }else
        {
            return NO;
        }
        if (splitCount == 0) {
            ++areaCodeCount;
        }else
        {
            ++phoneNumCount;
        }
        if ([input characterAtIndex:i] == '-') {
            ++splitCount;
        }
    }
    do {
        if (splitCount != 1) {
            rs = NO;
            break;
        }
        if (areaCodeCount < 3 || areaCodeCount > 5) {
            rs = NO;
            break;
        }
        if (phoneNumCount < 7 || phoneNumCount > 8) {
            rs = NO;
            break;
        }
    } while (0);
	return rs;
}

+(BOOL)isMobileNum:(NSString *)input{
    BOOL rs = YES;
    if ([input length] != 11) {
        return NO;
    }
    for (int i = 0; i < [input length]; ++i) {
        unichar c = [input characterAtIndex:i];
        if (c > 47 && c < 58) {
            
        }else
        {
            return NO;
        }
        if (i == 0 &&  c != '1') {
            rs = NO;
            break;
        }
        if (i == 1 && !(c == '3' || c == '5' || c == '8')) {
            rs = NO;
            break;
        }
    }
	return rs;
}

- (NSUInteger)isAllNumber:(NSString *)_string {
    unsigned int lenOfStrValue = [_string length];
    char ch[lenOfStrValue + 1];
    strcpy(ch, [_string cStringUsingEncoding:NSUTF8StringEncoding]);
    // 判断每个字符是否都是数字
    for (int i = 0; i < [_string length]; ++i) {
        // 如果不是就返回0，并退出循环
        if (ch[i] <= '0' || '9' <= ch[i]) {
            return 0;
        } // end if
    } // end for
    return 1;
}

#pragma mark - Mobile Phone
- (NSUInteger)isRightForMobilePhone:(NSString *)_phoneNum {
    // 判断移动电话的第一个字符是否是1，不是就返回0
    if (1 != [[_phoneNum substringWithRange:NSMakeRange(0, 1)] intValue]) {
        return 0;
    }
    return 1;
}

- (NSUInteger)isMobilePhoneNumber:(NSString *)_mobilePhoneNumber {
    // 判断位数
    if ([_mobilePhoneNumber length] != NUM_OF_MOBILE_PHONE) {
        [MYCommentAlertView showMessage:@"手机号码位数错误\n（应该为11位）" target:self];
        return 0;
    } else {
        // 判断是否全是数字
        if (![self isAllNumber:_mobilePhoneNumber]) {
            [MYCommentAlertView showMessage:@"手机号码格式错误\n（应只包含数字）" target:self];
            return 0;
        } else {
            if (![self isRightForMobilePhone:_mobilePhoneNumber]) {
                [MYCommentAlertView showMessage:@"手机号码输入错误\n（请检查是否输入正确）" target:self];
                return 0;
            }
        }
    }
    return 1;
}

#pragma mark - Telephone
- (NSUInteger)isTelephoneNumber:(NSString *)_telephoneNumber {
    
    return 1;
}
//- (NSArray *)componentsSeparatedByString:(NSString *)separator;

#pragma mark - E-Mail
- (NSUInteger)isEMailString:(NSString *)_eMailString {
    NSArray*  arrForEMail = [_eMailString componentsSeparatedByString:@"@"];
    if (2 != [arrForEMail count]) {
        [MYCommentAlertView showMessage:@"E-Mail格式错误\n（请检查是否输入正确）" target:self];
        return 0;
    } else {
        NSArray* arrForEMail_half = [[arrForEMail objectAtIndex:1] componentsSeparatedByString:@"."];
        if (2 != [arrForEMail_half count]) {
            [MYCommentAlertView showMessage:@"E-Mail格式错误\n（请检查是否输入正确）" target:self];
            return 0;
        }
    }
    return 1;
}



@end
