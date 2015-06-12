//
//  Coupon.m
//
//  Created by malan  on 14-4-1
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "Coupon.h"
#import "PropValues.h"


@interface Coupon ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Coupon

@synthesize couponIdentifier = _couponIdentifier;
@synthesize isRandom = _isRandom;
@synthesize status = _status;
@synthesize batchCode = _batchCode;
@synthesize amount = _amount;
@synthesize memo = _memo;
@synthesize startTime = _startTime;
@synthesize specialsFlag = _specialsFlag;
@synthesize propValues = _propValues;
@synthesize type = _type;
@synthesize created = _created;
@synthesize endTime = _endTime;
@synthesize name = _name;
@synthesize shopId = _shopId;
@synthesize couponinfo = _couponinfo;


+ (Coupon *)modelObjectWithDictionary:(NSDictionary *)dict
{
    Coupon *instance = [[Coupon alloc] initWithDictionary:dict];
    return instance;
}


- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];

    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.couponIdentifier = [self objectOrNilForKey:@"id" fromDictionary:dict];
            self.isRandom = [self objectOrNilForKey:@"is_random" fromDictionary:dict];
            self.status = [self objectOrNilForKey:@"status" fromDictionary:dict];
            self.batchCode = [self objectOrNilForKey:@"batch_code" fromDictionary:dict];
            self.amount = [self objectOrNilForKey:@"amount" fromDictionary:dict];
            self.memo = [self objectOrNilForKey:@"memo" fromDictionary:dict];
            self.startTime = [self objectOrNilForKey:@"start_time" fromDictionary:dict];
            self.specialsFlag = [self objectOrNilForKey:@"specials_flag" fromDictionary:dict];
            self.couponinfo = [self objectOrNilForKey:@"couponinfo" fromDictionary:dict];

    NSObject *receivedPropValues = [dict objectForKey:@"_prop_values"];
    NSMutableArray *parsedPropValues = [NSMutableArray array];
    if ([receivedPropValues isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedPropValues) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedPropValues addObject:[PropValues modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedPropValues isKindOfClass:[NSDictionary class]]) {
       [parsedPropValues addObject:[PropValues modelObjectWithDictionary:(NSDictionary *)receivedPropValues]];
    }

    self.propValues = [NSArray arrayWithArray:parsedPropValues];
            self.type = [self objectOrNilForKey:@"type" fromDictionary:dict];
            self.created = [self objectOrNilForKey:@"created" fromDictionary:dict];
            self.endTime = [self objectOrNilForKey:@"end_time" fromDictionary:dict];
            self.name = [self objectOrNilForKey:@"name" fromDictionary:dict];
            self.shopId = [self objectOrNilForKey:@"shop_id" fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.couponIdentifier forKey:@"id"];
    [mutableDict setValue:self.isRandom forKey:@"is_random"];
    [mutableDict setValue:self.status forKey:@"status"];
    [mutableDict setValue:self.batchCode forKey:@"batch_code"];
    [mutableDict setValue:self.amount forKey:@"amount"];
    [mutableDict setValue:self.memo forKey:@"memo"];
    [mutableDict setValue:self.startTime forKey:@"start_time"];
    [mutableDict setValue:self.specialsFlag forKey:@"specials_flag"];
    [mutableDict setValue:self.couponinfo forKey:@"couponinfo"];

NSMutableArray *tempArrayForPropValues = [NSMutableArray array];
    for (NSObject *subArrayObject in self.propValues) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForPropValues addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForPropValues addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForPropValues] forKey:@"_prop_values"];
    [mutableDict setValue:self.type forKey:@"type"];
    [mutableDict setValue:self.created forKey:@"created"];
    [mutableDict setValue:self.endTime forKey:@"end_time"];
    [mutableDict setValue:self.name forKey:@"name"];
    [mutableDict setValue:self.shopId forKey:@"shop_id"];

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

    self.couponIdentifier = [aDecoder decodeObjectForKey:@"couponIdentifier"];
    self.isRandom = [aDecoder decodeObjectForKey:@"isRandom"];
    self.status = [aDecoder decodeObjectForKey:@"status"];
    self.batchCode = [aDecoder decodeObjectForKey:@"batchCode"];
    self.amount = [aDecoder decodeObjectForKey:@"amount"];
    self.memo = [aDecoder decodeObjectForKey:@"memo"];
    self.startTime = [aDecoder decodeObjectForKey:@"startTime"];
    self.specialsFlag = [aDecoder decodeObjectForKey:@"specialsFlag"];
    self.propValues = [aDecoder decodeObjectForKey:@"propValues"];
    self.type = [aDecoder decodeObjectForKey:@"type"];
    self.created = [aDecoder decodeObjectForKey:@"created"];
    self.endTime = [aDecoder decodeObjectForKey:@"endTime"];
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.shopId = [aDecoder decodeObjectForKey:@"shopId"];
    self.couponinfo = [aDecoder decodeObjectForKey:@"couponinfo"];

    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_couponIdentifier forKey:@"couponIdentifier"];
    [aCoder encodeObject:_isRandom forKey:@"isRandom"];
    [aCoder encodeObject:_status forKey:@"status"];
    [aCoder encodeObject:_batchCode forKey:@"batchCode"];
    [aCoder encodeObject:_amount forKey:@"amount"];
    [aCoder encodeObject:_memo forKey:@"memo"];
    [aCoder encodeObject:_startTime forKey:@"startTime"];
    [aCoder encodeObject:_specialsFlag forKey:@"specialsFlag"];
    [aCoder encodeObject:_propValues forKey:@"propValues"];
    [aCoder encodeObject:_type forKey:@"type"];
    [aCoder encodeObject:_created forKey:@"created"];
    [aCoder encodeObject:_endTime forKey:@"endTime"];
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_shopId forKey:@"shopId"];
    [aCoder encodeObject:_couponinfo forKey:@"couponinfo"];

}

@end
