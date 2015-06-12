//
//  SBPublicFormatValidation.m
//
//  Created by bonan on 13-6-23.
//  Copyright (c) 2014年 xie xianhui. All rights reserved.
//

#import "SBPublicFormatValidation.h"

@implementation SBPublicFormatValidation


#pragma mark 判断字符串中是否全是汉字
+ (BOOL)boolStringAllHaveChinese:(NSString *)str
{
    NSInteger length = str.length;
    int i = 0;
    for (; i < length; ++i) {
        NSRange range = NSMakeRange(i, 1);
        NSString *subString = [str substringWithRange:range];
        const char *cString = [subString UTF8String];
        if (strlen(cString) == 3) {//汉字的长度是3
        
            //            NSLog(@"汉字:%s",cString);
                    NSLog(@"%@",[NSString stringWithUTF8String:cString]);
        }else{
            break;
        }
    }
    if (i >= length) {
        return YES;
    }
    return NO;
}

#pragma mark 判断字符串中不能出现汉字
+ (BOOL)boolStringNotHaveChinese:(NSString *)str
{
    NSInteger length = str.length;
    int i = 0;
    for (; i < length; ++i) {
        NSRange range = NSMakeRange(i, 1);
        NSString *subString = [str substringWithRange:range];
        const char *cString = [subString UTF8String];
        if (strlen(cString) == 3) {//汉字的长度是3

            return NO;
        }
    }
    if (i >= length) {
        return YES;
    }
    return NO;
}

#pragma mark 判断邮箱格式是否正确
+ (BOOL)boolEmailCheckNumInput:(NSString *)email
{
    NSString *regex = @"\\b([a-zA-Z0-9%_.+\\-]+)@([a-zA-Z0-9.\\-]+?\\.[a-zA-Z]{2,6})\\b";
    NSRegularExpression *regularexpression = [[NSRegularExpression alloc]
                                              initWithPattern:regex
                                              options:NSRegularExpressionCaseInsensitive
                                              error:nil];
    
    //无符号整型数据接受匹配的数据的数目
    NSUInteger numberofMatch = [regularexpression numberOfMatchesInString:email
                                                                  options:NSMatchingReportProgress
                                                                    range:NSMakeRange(0, email.length)];
    //NSLog(@"11位移动手机号码匹配的个数数%d",numberofMatch);
    if(numberofMatch > 0) {
        return YES;
    } else {
        return NO;
    }
}


#pragma mark - 验证电话号码格式是否正确
+ (BOOL)boolCheckPhoneNumInput:(NSString *)paramPhoneNum
{
//    NSString *Regex = @"(13[0-9]|14[0-9]|15[0-9]|17[0-9]|18[0-9])\\d{8}";
//    NSPredicate *mobileTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
//    return [mobileTest evaluateWithObject:paramPhoneNum];
    
    //lee999recode
 
    //大陆手机号
    NSString *phoneNumRegex1 = @"(13[0-9]|14[0-9]|15[0-9]|17[0-9]|18[0-9])\\d{8}";
    NSPredicate *phoneNum1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneNumRegex1];
    BOOL ischinaPhone = [phoneNum1 evaluateWithObject:paramPhoneNum];
    
    //lee999recode
    
    //香港手机号
    NSString *phoneNumRegex2 = @"[1,5,6,9](?:\\d{7}|\\d{8}|\\d{12})";//@"^[1,5,6,9](?:\\d{7}|\\d{8}|\\d{12})";
    NSPredicate *phoneNum2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneNumRegex2];
    BOOL isHKPhone = [phoneNum2 evaluateWithObject:paramPhoneNum];
    
    //澳门手机号：
    NSString *phoneNumRegex3 = @"6\\d{7}";//@"^6\\d{7}";
    NSPredicate *phoneNum3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneNumRegex3];
    BOOL isMKPhone = [phoneNum3 evaluateWithObject:paramPhoneNum];
    
    //台湾手机号：
    NSString *phoneNumRegex4 = @"[6,7,9](?:\\d{7}|\\d{8}|\\d{10})";
    NSPredicate *phoneNum4 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneNumRegex4];
    BOOL isTWPhone = [phoneNum4 evaluateWithObject:paramPhoneNum];
    
    if (ischinaPhone || isHKPhone || isMKPhone || isTWPhone) {
        return YES;
    }else{
        return NO;
    }
}

@end



@implementation NSString (TrimeWhiteSpaceAndNewLine)

//判断手机号码
-(NSString *)stringByTrimmingWhiteSpaceAndNewLine{
    NSCharacterSet *charSet=[NSCharacterSet whitespaceAndNewlineCharacterSet];
    return [self stringByTrimmingCharactersInSet:charSet];
}

//用正则表达市判断是不是手机号
+ (BOOL)isValidTelephoneNum2:(NSString *)strPhoneNum
{
    //大陆手机号
    NSString *phoneNumRegex1 = @"(13[0-9]|14[0-9]|15[0-9]|17[0-9]|18[0-9])\\d{8}";
    NSPredicate *phoneNum1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneNumRegex1];
    BOOL ischinaPhone = [phoneNum1 evaluateWithObject:strPhoneNum];
    
    //lee999recode
    
    //香港手机号
    NSString *phoneNumRegex2 = @"[1,5,6,9](?:\\d{7}|\\d{8}|\\d{12})";//@"^[1,5,6,9](?:\\d{7}|\\d{8}|\\d{12})";
    NSPredicate *phoneNum2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneNumRegex2];
    BOOL isHKPhone = [phoneNum2 evaluateWithObject:strPhoneNum];
    
    //澳门手机号：
    NSString *phoneNumRegex3 = @"6\\d{7}";//@"^6\\d{7}";
    NSPredicate *phoneNum3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneNumRegex3];
    BOOL isMKPhone = [phoneNum3 evaluateWithObject:strPhoneNum];
    
    //台湾手机号：
    NSString *phoneNumRegex4 = @"[6,7,9](?:\\d{7}|\\d{8}|\\d{10})";
    NSPredicate *phoneNum4 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneNumRegex4];
    BOOL isTWPhone = [phoneNum4 evaluateWithObject:strPhoneNum];
    
    if (ischinaPhone || isHKPhone || isMKPhone || isTWPhone) {
        return YES;
    }else{
        return NO;
    }
}

//验证邮箱的合法性
+(BOOL)isValidateEmail:(NSString *)email {
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:email];
    
}

//判断用户密码是否规则
+ (BOOL)isUserPwdValid:(NSString *)pwd
{
    NSString* regex = @"^[\x21-\x7E]{6,16}$";
    NSPredicate *formatTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [formatTest evaluateWithObject:pwd];
}


//判断身份证号是不是正确
+(BOOL)stringByIdentityCardNumberisCorrect:(NSString *)identityCardNumber {
    if (identityCardNumber.length != 18) { //如果身份证号长度不合法，返回1
        return false;
    }
    
    const char *idcard = [identityCardNumber cStringUsingEncoding:NSASCIIStringEncoding];
    
    int i=0;
    for(i=0;i<18-1;i++)
        if(idcard[i]>'9'||idcard[i]<'0')
            return false; //如果身份证号第1~17位含有非数字的字符，返回2；
    if(!((idcard[i]>'0'&&idcard[i]<'9')||idcard[i]=='x'))
        return false;//如果身份证号第18位既不是数字也不是英文小写字母x，返回3；
    int year=1000*(idcard[6]-'0')+100*(idcard[7]-'0')+10*(idcard[8]-'0')+idcard[9]-'0';
    
    if(year>2100||year<1900)
        return false;//如果身份证号的年信息非法，返回4
    
    int month=10*(idcard[10]-'0')+idcard[11]-'0';
    
    int day=10*(idcard[12]-'0')+idcard[13]-'0';
    
    if(month>12||month<1)
        return false;//如果身份证号的月信息非法，返回5；
    
    bool flag=false;
    
    if((year%4==0&&year%100!=0)||year%400==0)
        flag=true;
    
    if(day<1||((flag==true)&&(day>29))||((flag==false)&&(day>28)))
        return false; // 如果身份证号的日信息非法，返回6（请注意闰年的情况）
    
    return true;//如果身份证号合法，返回0；
}

@end



