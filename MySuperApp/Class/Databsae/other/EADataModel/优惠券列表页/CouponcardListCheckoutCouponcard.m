//
//  CouponcardListCheckoutCouponcard.m
//
//  Created by malan  on 14-4-26
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "CouponcardListCheckoutCouponcard.h"


@interface CouponcardListCheckoutCouponcard ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CouponcardListCheckoutCouponcard

@synthesize stuatus = _stuatus;
@synthesize failtime = _failtime;
@synthesize code = _code;
@synthesize title = _title;
@synthesize desc = _desc;


+ (CouponcardListCheckoutCouponcard *)modelObjectWithDictionary:(NSDictionary *)dict
{
    CouponcardListCheckoutCouponcard *instance = [[CouponcardListCheckoutCouponcard alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.stuatus = [self objectOrNilForKey:@"stuatus" fromDictionary:dict];
            self.failtime = [self objectOrNilForKey:@"failtime" fromDictionary:dict];
            self.code = [self objectOrNilForKey:@"code" fromDictionary:dict];
            self.title = [self objectOrNilForKey:@"title" fromDictionary:dict];
            self.desc = [self objectOrNilForKey:@"desc" fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.stuatus forKey:@"stuatus"];
    [mutableDict setValue:self.failtime forKey:@"failtime"];
    [mutableDict setValue:self.code forKey:@"code"];
    [mutableDict setValue:self.title forKey:@"title"];
    [mutableDict setValue:self.desc forKey:@"desc"];

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

    self.stuatus = [aDecoder decodeObjectForKey:@"stuatus"];
    self.failtime = [aDecoder decodeObjectForKey:@"failtime"];
    self.code = [aDecoder decodeObjectForKey:@"code"];
    self.title = [aDecoder decodeObjectForKey:@"title"];
    self.desc = [aDecoder decodeObjectForKey:@"desc"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_stuatus forKey:@"stuatus"];
    [aCoder encodeObject:_failtime forKey:@"failtime"];
    [aCoder encodeObject:_code forKey:@"code"];
    [aCoder encodeObject:_title forKey:@"title"];
    [aCoder encodeObject:_desc forKey:@"desc"];
}


@end
