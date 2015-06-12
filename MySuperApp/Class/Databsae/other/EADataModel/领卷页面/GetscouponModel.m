//
//  GetscouponModel.m
//
//  Created by malan  on 14-4-1
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "GetscouponModel.h"
#import "Coupon.h"


@interface GetscouponModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation GetscouponModel

@synthesize coupon = _coupon;
@synthesize response = _response;

@synthesize requestTag;
@synthesize errorMessage;

+ (GetscouponModel *)modelObjectWithDictionary:(NSDictionary *)dict
{
    GetscouponModel *instance = [[GetscouponModel alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        NSObject *receivedCoupon = [dict objectForKey:@"coupon"];
        NSMutableArray *parsedCoupon = [NSMutableArray array];
        if ([receivedCoupon isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedCoupon) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedCoupon addObject:item];
                }
            }
        } else if ([receivedCoupon isKindOfClass:[NSDictionary class]]) {
            [parsedCoupon addObject:receivedCoupon];
        }
        
        self.coupon = [NSArray arrayWithArray:parsedCoupon];
        self.response = [self objectOrNilForKey:@"response" fromDictionary:dict];
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForCoupon = [NSMutableArray array];
    for (NSObject *subArrayObject in self.coupon) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForCoupon addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForCoupon addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForCoupon] forKey:@"coupon"];
    [mutableDict setValue:self.response forKey:@"response"];
    
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
    
    self.coupon = [aDecoder decodeObjectForKey:@"coupon"];
    self.response = [aDecoder decodeObjectForKey:@"response"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:_coupon forKey:@"coupon"];
    [aCoder encodeObject:_response forKey:@"response"];
}


@end
