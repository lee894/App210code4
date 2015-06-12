//
//  CFunction.h
//  ProjectStructure
//
//  Created by malan on 14-9-2.
//  Copyright (c) 2014年 malan. All rights reserved.
//

#ifndef ProjectStructure_CFunction_h
#define ProjectStructure_CFunction_h


#define Per_Page @"10"
#define LOG_SHOW_MODAL

//数据合法化
static id LegalObject(id obj,Class toClass)
{
    if ([obj isKindOfClass:[NSNull class]] || obj == nil) {
        if ([NSStringFromClass(toClass) isEqualToString:NSStringFromClass([NSString class])]) {
            return @"";
        } else if ([NSStringFromClass(toClass) isEqualToString:NSStringFromClass([NSDictionary class])]) {
            return [NSDictionary  dictionary];
        } else if ([NSStringFromClass(toClass) isEqualToString:NSStringFromClass([NSArray class])]) {
            return [NSArray  array];
        } else if ([NSStringFromClass(toClass) isEqualToString:NSStringFromClass([NSNumber class])]) {
            return [NSNumber  numberWithInt:0];
        }
    } else {
        return obj;
    }
    return obj;
}


#endif
