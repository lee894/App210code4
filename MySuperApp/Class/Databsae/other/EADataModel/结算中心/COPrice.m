//
//  COPrice.m
//
//  Created by malan  on 14-4-7
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "COPrice.h"


@interface COPrice ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation COPrice

@synthesize promotionName = _promotionName;
@synthesize bn = _bn;
@synthesize countMax = _countMax;
@synthesize adjustPrice = _adjustPrice;
@synthesize memo = _memo;
@synthesize suitId = _suitId;
@synthesize giftBn = _giftBn;
@synthesize type = _type;
@synthesize promotionId = _promotionId;
@synthesize giftNumber = _giftNumber;


+ (COPrice *)modelObjectWithDictionary:(NSDictionary *)dict
{
    COPrice *instance = [[COPrice alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.promotionName = [self objectOrNilForKey:@"promotion_name" fromDictionary:dict];
            self.bn = [self objectOrNilForKey:@"bn" fromDictionary:dict];
            self.countMax = [[dict objectForKey:@"count_max"] doubleValue];
            self.adjustPrice = [self objectOrNilForKey:@"adjust_price" fromDictionary:dict];
            self.memo = [self objectOrNilForKey:@"memo" fromDictionary:dict];
            self.suitId = [self objectOrNilForKey:@"suit_id" fromDictionary:dict];
            self.giftBn = [self objectOrNilForKey:@"gift_bn" fromDictionary:dict];
            self.type = [self objectOrNilForKey:@"type" fromDictionary:dict];
            self.promotionId = [self objectOrNilForKey:@"promotion_id" fromDictionary:dict];
            self.giftNumber = [[dict objectForKey:@"gift_number"] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.promotionName forKey:@"promotion_name"];
    [mutableDict setValue:self.bn forKey:@"bn"];
    [mutableDict setValue:[NSNumber numberWithDouble:self.countMax] forKey:@"count_max"];
    [mutableDict setValue:self.adjustPrice forKey:@"adjust_price"];
    [mutableDict setValue:self.memo forKey:@"memo"];
    [mutableDict setValue:self.suitId forKey:@"suit_id"];
    [mutableDict setValue:self.giftBn forKey:@"gift_bn"];
    [mutableDict setValue:self.type forKey:@"type"];
    [mutableDict setValue:self.promotionId forKey:@"promotion_id"];
    [mutableDict setValue:[NSNumber numberWithDouble:self.giftNumber] forKey:@"gift_number"];

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

    self.promotionName = [aDecoder decodeObjectForKey:@"promotionName"];
    self.bn = [aDecoder decodeObjectForKey:@"bn"];
    self.countMax = [aDecoder decodeDoubleForKey:@"countMax"];
    self.adjustPrice = [aDecoder decodeObjectForKey:@"adjustPrice"];
    self.memo = [aDecoder decodeObjectForKey:@"memo"];
    self.suitId = [aDecoder decodeObjectForKey:@"suitId"];
    self.giftBn = [aDecoder decodeObjectForKey:@"giftBn"];
    self.type = [aDecoder decodeObjectForKey:@"type"];
    self.promotionId = [aDecoder decodeObjectForKey:@"promotionId"];
    self.giftNumber = [aDecoder decodeDoubleForKey:@"giftNumber"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_promotionName forKey:@"promotionName"];
    [aCoder encodeObject:_bn forKey:@"bn"];
    [aCoder encodeDouble:_countMax forKey:@"countMax"];
    [aCoder encodeObject:_adjustPrice forKey:@"adjustPrice"];
    [aCoder encodeObject:_memo forKey:@"memo"];
    [aCoder encodeObject:_suitId forKey:@"suitId"];
    [aCoder encodeObject:_giftBn forKey:@"giftBn"];
    [aCoder encodeObject:_type forKey:@"type"];
    [aCoder encodeObject:_promotionId forKey:@"promotionId"];
    [aCoder encodeDouble:_giftNumber forKey:@"giftNumber"];
}



@end
