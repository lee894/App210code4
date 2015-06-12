//
//  ChengeMyInfo.m
//  MySuperApp
//
//  Created by bonan on 14-4-9.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "ChengeMyInfo.h"

@implementation ChengeMyInfo
@synthesize requestTag,response,errorMessage,res;



+ (ChengeMyInfo *)modelObjectWithDictionary:(NSDictionary *)dict
{
    ChengeMyInfo *instance = [[ChengeMyInfo alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];

    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        self.res = [self objectOrNilForKey:@"res" fromDictionary:dict];
    }
    return self;
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


@end
