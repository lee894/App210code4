//
//  YKStringHelper.h
//  VANCL
//
//  Created by yek on 10-12-24.
//  Copyright 2010 yek. All rights reserved.
//

#import <Foundation/Foundation.h>

 
@interface YKStringHelper : NSObject {

}

@end


extern BOOL stringIsEmpty(NSString* str);
extern NSString* stringOrEmpty(NSString* str);

/*前多少个中文字符，两个英文字符算一个中文*/
extern NSString* startChineseString(NSString* str, int length);

/*
 从字符串中解析出日期，使用东八时区
 str: yyyy-MM-dd HH:mm:ss
 */
extern NSDate* dateFromString(NSString* str);
extern NSDate* dateFromString2(NSString* str, NSString* format);
/*
 日期格式化成字符串格式为:yyyy-MM-dd HH:mm:ss，使用东八时区
 */
extern NSString* stringFromDate(NSDate* date);

/*
 生成guid
 */
extern NSString* generateGUID();
