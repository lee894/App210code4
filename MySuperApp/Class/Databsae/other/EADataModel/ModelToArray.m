////
////  ModelToArray.m
////  ClassProperty
////
////  Created by lee on 12-12-24.
////  Copyright (c) 2012年 houpeng. All rights reserved.
////
//
//#import "ModelToArray.h"
//
//#import <objc/runtime.h>
//
//@implementation ModelToArray
//
//
//- (id)customModelmodelClass:(NSString *)modelClass ToArrayOrDic:(id)arrayOrDic {
//    
//    
//    if ([arrayOrDic isKindOfClass:[NSArray class]]) {
//        NSMutableArray * dataArr = [NSMutableArray arrayWithCapacity:0];
//        
//        [self customModel:modelClass ToArray:arrayOrDic];
//        
//        return dataArr;
//        
//    }else if ([arrayOrDic isKindOfClass:[NSDictionary class]]) {
//        id model = [[NSClassFromString([arrayOrDic objectForKey:@""]) alloc] init];
//        
//        [self customModel:modelClass ToArray:arrayOrDic];
//        
//        return model;
//    }
//    
//    return nil;
//    
//}
//
//- (NSMutableArray *)customModel:(NSString *)modelClass ToArray:(NSArray *)array
//{
//    if (!([array isKindOfClass:[NSArray class]] && [array count]!=0)) {
//        return nil;
//    }
//    NSString *complexClassName = NSStringFromClass([NSClassFromString(modelClass) class]);
//    const char *cComplexClassName = [complexClassName UTF8String];
//    id theComplexClass = objc_getClass(cComplexClassName);
//    unsigned int outCount;
//    objc_property_t *properties = class_copyPropertyList(theComplexClass, &outCount);
//    //    NSMutableArray *propertyNames = [[NSMutableArray alloc] initWithCapacity:1];
//    NSMutableArray * dataArr = [NSMutableArray arrayWithCapacity:0];
//    for (int i = 0; i < [array count]; i++) {
//        id jsonDic = [array objectAtIndex:i];
//        if(![jsonDic isKindOfClass:[NSDictionary class]])
//        {
//            NSLog(@"第%d个对象不是NSDictionary",i);
//            continue;
//        }
//        id model = [[NSClassFromString(modelClass) alloc] init];
//        for (int j = 0; j < outCount; j++)
//        {
//            objc_property_t property = properties[j];
//            NSString *propertyNameString =[[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
//            NSString * setString = [propertyNameString stringByReplacingOccurrencesOfString:[propertyNameString substringToIndex:1] withString:[[propertyNameString substringToIndex:1] uppercaseString]];
//            NSString * setProperty = [NSString stringWithFormat:@"%@%@:",@"set",setString];
//            //            SEL tempSelector = NSSelectorFromString(propertyNameString);
//            SEL setSelector = NSSelectorFromString(setProperty);
//            id object = nil;
//            if ([propertyNameString isEqualToString:@"id"]) {
//                object = [jsonDic objectForKey:@"ID"];
//            }
//            object = [jsonDic objectForKey:propertyNameString];
//
//            if(!object || [object isKindOfClass:[NSNull class]])
//            {
//                continue;
//            }
//            [model performSelector:setSelector withObject:object];
//        }
//        [dataArr addObject:model];
//    }
//    return dataArr;
//}
//
//- (LBaseModel *)customModel:(NSString *)modelClass ToDictionary:(NSDictionary *)dic {
//    if (!([dic isKindOfClass:[NSDictionary class]] && [dic count]!=0)) {
//        return nil;
//    }
//    
//    NSString *complexClassName = NSStringFromClass([NSClassFromString(modelClass) class]);
//    const char *cComplexClassName = [complexClassName UTF8String];
//    id theComplexClass = objc_getClass(cComplexClassName);
//    unsigned int outCount;
//    
//    objc_property_t *properties = class_copyPropertyList(theComplexClass, &outCount);
//    
//    id model = [[NSClassFromString(modelClass) alloc] init];
//    for (int j = 0; j < outCount; j++)
//    {
//        objc_property_t property = properties[j];
//        NSString *propertyNameString =[[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
//        NSString * setString = [propertyNameString stringByReplacingOccurrencesOfString:[propertyNameString substringToIndex:1] withString:[[propertyNameString substringToIndex:1] uppercaseString]];
//        NSString * setProperty = [NSString stringWithFormat:@"%@%@:",@"set",setString];
//        //            SEL tempSelector = NSSelectorFromString(propertyNameString);
//        SEL setSelector = NSSelectorFromString(setProperty);
//        id object = [dic objectForKey:propertyNameString];
//
//        if(!object || [object isKindOfClass:[NSNull class]])
//        {
//            continue;
//        }
//        [model performSelector:setSelector withObject:object];
//    }
//    
//    
//    return model;
//}
//
//
//@end
