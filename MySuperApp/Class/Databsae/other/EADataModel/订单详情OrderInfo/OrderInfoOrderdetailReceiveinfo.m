//
//  OrderInfoOrderdetailReceiveinfo.m
//
//  Created by malan  on 14-4-19
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "OrderInfoOrderdetailReceiveinfo.h"


@interface OrderInfoOrderdetailReceiveinfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation OrderInfoOrderdetailReceiveinfo

@synthesize detail = _detail;
@synthesize area = _area;
@synthesize city = _city;
@synthesize name = _name;
@synthesize zipcode = _zipcode;
@synthesize email = _email;
@synthesize mobilephone = _mobilephone;
@synthesize telphone = _telphone;
@synthesize province = _province;


+ (OrderInfoOrderdetailReceiveinfo *)modelObjectWithDictionary:(NSDictionary *)dict
{
    OrderInfoOrderdetailReceiveinfo *instance = [[OrderInfoOrderdetailReceiveinfo alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.detail = [self objectOrNilForKey:@"detail" fromDictionary:dict];
            self.area = [self objectOrNilForKey:@"area" fromDictionary:dict];
            self.city = [self objectOrNilForKey:@"city" fromDictionary:dict];
            self.name = [self objectOrNilForKey:@"name" fromDictionary:dict];
            self.zipcode = [self objectOrNilForKey:@"zipcode" fromDictionary:dict];
            self.email = [self objectOrNilForKey:@"email" fromDictionary:dict];
            self.mobilephone = [self objectOrNilForKey:@"mobilephone" fromDictionary:dict];
            self.telphone = [self objectOrNilForKey:@"telphone" fromDictionary:dict];
            self.province = [self objectOrNilForKey:@"province" fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.detail forKey:@"detail"];
    [mutableDict setValue:self.area forKey:@"area"];
    [mutableDict setValue:self.city forKey:@"city"];
    [mutableDict setValue:self.name forKey:@"name"];
    [mutableDict setValue:self.zipcode forKey:@"zipcode"];
    [mutableDict setValue:self.email forKey:@"email"];
    [mutableDict setValue:self.mobilephone forKey:@"mobilephone"];
    [mutableDict setValue:self.telphone forKey:@"telphone"];
    [mutableDict setValue:self.province forKey:@"province"];

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

    self.detail = [aDecoder decodeObjectForKey:@"detail"];
    self.area = [aDecoder decodeObjectForKey:@"area"];
    self.city = [aDecoder decodeObjectForKey:@"city"];
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.zipcode = [aDecoder decodeObjectForKey:@"zipcode"];
    self.email = [aDecoder decodeObjectForKey:@"email"];
    self.mobilephone = [aDecoder decodeObjectForKey:@"mobilephone"];
    self.telphone = [aDecoder decodeObjectForKey:@"telphone"];
    self.province = [aDecoder decodeObjectForKey:@"province"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_detail forKey:@"detail"];
    [aCoder encodeObject:_area forKey:@"area"];
    [aCoder encodeObject:_city forKey:@"city"];
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_zipcode forKey:@"zipcode"];
    [aCoder encodeObject:_email forKey:@"email"];
    [aCoder encodeObject:_mobilephone forKey:@"mobilephone"];
    [aCoder encodeObject:_telphone forKey:@"telphone"];
    [aCoder encodeObject:_province forKey:@"province"];
}

@end
