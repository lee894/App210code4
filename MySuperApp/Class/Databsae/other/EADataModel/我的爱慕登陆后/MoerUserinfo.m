//
//  MoerUserinfo.m
//
//  Created by malan  on 14-4-15
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "MoerUserinfo.h"


@interface MoerUserinfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MoerUserinfo

@synthesize isbind = _isbind;
@synthesize validScore = _validScore;
@synthesize ordernum = _ordernum;
@synthesize shopcartcount = _shopcartcount;
@synthesize orderCount = _orderCount;
@synthesize norates = _norates;
@synthesize username = _username;
@synthesize nodispose = _nodispose;
@synthesize addressnum = _addressnum;
@synthesize ordcancel = _ordcancel;
@synthesize favoritenum = _favoritenum;


+ (MoerUserinfo *)modelObjectWithDictionary:(NSDictionary *)dict
{
    MoerUserinfo *instance = [[MoerUserinfo alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.isbind = [self objectOrNilForKey:@"isbind" fromDictionary:dict];
            self.validScore = [self objectOrNilForKey:@"valid_score" fromDictionary:dict];
            self.ordernum = [self objectOrNilForKey:@"ordernum" fromDictionary:dict];
            self.shopcartcount = [[dict objectForKey:@"shopcartcount"] doubleValue];
            self.orderCount = [self objectOrNilForKey:@"order_count" fromDictionary:dict];
            self.norates = [[dict objectForKey:@"norates"] doubleValue];
            self.username = [self objectOrNilForKey:@"username" fromDictionary:dict];
            self.nodispose = [self objectOrNilForKey:@"nodispose" fromDictionary:dict];
            self.addressnum = [self objectOrNilForKey:@"addressnum" fromDictionary:dict];
            self.ordcancel = [self objectOrNilForKey:@"ordcancel" fromDictionary:dict];
            self.favoritenum = [self objectOrNilForKey:@"favoritenum" fromDictionary:dict];
            self.userface = [self objectOrNilForKey:@"userface" fromDictionary:dict];


    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.isbind forKey:@"isbind"];
    [mutableDict setValue:self.validScore forKey:@"valid_score"];
    [mutableDict setValue:self.ordernum forKey:@"ordernum"];
    [mutableDict setValue:[NSNumber numberWithDouble:self.shopcartcount] forKey:@"shopcartcount"];
    [mutableDict setValue:self.orderCount forKey:@"order_count"];
    [mutableDict setValue:[NSNumber numberWithDouble:self.norates] forKey:@"norates"];
    [mutableDict setValue:self.username forKey:@"username"];
    [mutableDict setValue:self.nodispose forKey:@"nodispose"];
    [mutableDict setValue:self.addressnum forKey:@"addressnum"];
    [mutableDict setValue:self.ordcancel forKey:@"ordcancel"];
    [mutableDict setValue:self.favoritenum forKey:@"favoritenum"];
    [mutableDict setValue:self.userface forKey:@"userface"];

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

    self.isbind = [aDecoder decodeObjectForKey:@"isbind"];
    self.validScore = [aDecoder decodeObjectForKey:@"validScore"];
    self.ordernum = [aDecoder decodeObjectForKey:@"ordernum"];
    self.shopcartcount = [aDecoder decodeDoubleForKey:@"shopcartcount"];
    self.orderCount = [aDecoder decodeObjectForKey:@"orderCount"];
    self.norates = [aDecoder decodeDoubleForKey:@"norates"];
    self.username = [aDecoder decodeObjectForKey:@"username"];
    self.nodispose = [aDecoder decodeObjectForKey:@"nodispose"];
    self.addressnum = [aDecoder decodeObjectForKey:@"addressnum"];
    self.ordcancel = [aDecoder decodeObjectForKey:@"ordcancel"];
    self.favoritenum = [aDecoder decodeObjectForKey:@"favoritenum"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_isbind forKey:@"isbind"];
    [aCoder encodeObject:_validScore forKey:@"validScore"];
    [aCoder encodeObject:_ordernum forKey:@"ordernum"];
    [aCoder encodeDouble:_shopcartcount forKey:@"shopcartcount"];
    [aCoder encodeObject:_orderCount forKey:@"orderCount"];
    [aCoder encodeDouble:_norates forKey:@"norates"];
    [aCoder encodeObject:_username forKey:@"username"];
    [aCoder encodeObject:_nodispose forKey:@"nodispose"];
    [aCoder encodeObject:_addressnum forKey:@"addressnum"];
    [aCoder encodeObject:_ordcancel forKey:@"ordcancel"];
    [aCoder encodeObject:_favoritenum forKey:@"favoritenum"];
}

@end
