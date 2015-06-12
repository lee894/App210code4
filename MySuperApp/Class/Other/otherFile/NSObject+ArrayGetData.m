//
//  NSObject+ArrayGetData.m
//  paipaiiphone
//
//  Created by JDMAC on 15-1-6.
//  Copyright (c) 2015年 lee. All rights reserved.
//

#import "NSObject+ArrayGetData.h"

@implementation NSObject (ArrayGetData)


-(id)objectAtIndex:(NSUInteger)index isArray:(ArrayBlock)block
{
    if ([self isKindOfClass:[NSArray class]]) {
        if (block) {
            block(YES,[self class]);
        }
        NSArray *array = (NSArray*)self;
        if (array && array.count && array.count-1 >= index) {
            return [array objectAtIndex:index];
        }
        else
        {
            return nil;
        }
        
    }
    else
    {
        if (block) {
            block(NO,[self class]);
        }
        
    }
    return nil;
}


-(id)objectForKey:(NSString *)key isDictionary:(DictionaryBlock)block
{
    if ([self isKindOfClass:[NSDictionary class]]) {
        if (block) {
            block(YES,[self class]);
        }
        NSDictionary *dict = (NSDictionary *)self;
        if (dict) {
            return [dict objectForKey:key];
        }
        else
        {
            return [NSDictionary dictionary];
        }
        
    }
    else{
        if (block) {
            block(NO,[self class]);
        }
    }
    return [NSDictionary dictionary];

}


@end
