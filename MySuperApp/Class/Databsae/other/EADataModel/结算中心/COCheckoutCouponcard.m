//
//  COCheckoutCouponcard.m
//
//  Created by malan  on 14-4-7
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "COCheckoutCouponcard.h"


@interface COCheckoutCouponcard ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation COCheckoutCouponcard

@synthesize desc = _desc;
@synthesize title = _title;
@synthesize code = _code;


+ (COCheckoutCouponcard *)modelObjectWithDictionary:(NSDictionary *)dict
{
    COCheckoutCouponcard *instance = [[COCheckoutCouponcard alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.desc = [self objectOrNilForKey:@"desc" fromDictionary:dict];
            self.title = [self objectOrNilForKey:@"title" fromDictionary:dict];
            self.code = [self objectOrNilForKey:@"code" fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.desc forKey:@"desc"];
    [mutableDict setValue:self.title forKey:@"title"];
    [mutableDict setValue:self.code forKey:@"code"];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.desc = [aDecoder decodeObjectForKey:@"desc"];
    self.title = [aDecoder decodeObjectForKey:@"title"];
    self.code = [aDecoder decodeObjectForKey:@"code"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_desc forKey:@"desc"];
    [aCoder encodeObject:_title forKey:@"title"];
    [aCoder encodeObject:_code forKey:@"code"];
}

@end
