//
//  AddressAddresslist.m
//
//  Created by malan  on 14-4-15
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "AddressAddresslist.h"


@interface AddressAddresslist ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation AddressAddresslist

@synthesize addresslistIdentifier = _addresslistIdentifier;
@synthesize phone = _phone;
@synthesize countyId = _countyId;
@synthesize mobile = _mobile;
@synthesize province = _province;
@synthesize zipCode = _zipCode;
@synthesize userId = _userId;
@synthesize cityId = _cityId;
@synthesize address = _address;
@synthesize defaultFlag = _defaultFlag;
@synthesize city = _city;
@synthesize userName = _userName;
@synthesize county = _county;
@synthesize email = _email;
@synthesize provinceId = _provinceId;


+ (AddressAddresslist *)modelObjectWithDictionary:(NSDictionary *)dict
{
    AddressAddresslist *instance = [[AddressAddresslist alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.addresslistIdentifier = [self objectOrNilForKey:@"id" fromDictionary:dict];
            self.phone = [self objectOrNilForKey:@"phone" fromDictionary:dict];
            self.countyId = [self objectOrNilForKey:@"county_id" fromDictionary:dict];
            self.mobile = [self objectOrNilForKey:@"mobile" fromDictionary:dict];
            self.province = [self objectOrNilForKey:@"province" fromDictionary:dict];
            self.zipCode = [self objectOrNilForKey:@"zip_code" fromDictionary:dict];
            self.userId = [self objectOrNilForKey:@"user_id" fromDictionary:dict];
            self.cityId = [self objectOrNilForKey:@"city_id" fromDictionary:dict];
            self.address = [self objectOrNilForKey:@"address" fromDictionary:dict];
            self.defaultFlag = [self objectOrNilForKey:@"default_flag" fromDictionary:dict];
            self.city = [self objectOrNilForKey:@"city" fromDictionary:dict];
            self.userName = [self objectOrNilForKey:@"user_name" fromDictionary:dict];
            self.county = [self objectOrNilForKey:@"county" fromDictionary:dict];
            self.email = [self objectOrNilForKey:@"email" fromDictionary:dict];
            self.provinceId = [self objectOrNilForKey:@"province_id" fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.addresslistIdentifier forKey:@"id"];
    [mutableDict setValue:self.phone forKey:@"phone"];
    [mutableDict setValue:self.countyId forKey:@"county_id"];
    [mutableDict setValue:self.mobile forKey:@"mobile"];
    [mutableDict setValue:self.province forKey:@"province"];
    [mutableDict setValue:self.zipCode forKey:@"zip_code"];
    [mutableDict setValue:self.userId forKey:@"user_id"];
    [mutableDict setValue:self.cityId forKey:@"city_id"];
    [mutableDict setValue:self.address forKey:@"address"];
    [mutableDict setValue:self.defaultFlag forKey:@"default_flag"];
    [mutableDict setValue:self.city forKey:@"city"];
    [mutableDict setValue:self.userName forKey:@"user_name"];
    [mutableDict setValue:self.county forKey:@"county"];
    [mutableDict setValue:self.email forKey:@"email"];
    [mutableDict setValue:self.provinceId forKey:@"province_id"];

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

    self.addresslistIdentifier = [aDecoder decodeObjectForKey:@"addresslistIdentifier"];
    self.phone = [aDecoder decodeObjectForKey:@"phone"];
    self.countyId = [aDecoder decodeObjectForKey:@"countyId"];
    self.mobile = [aDecoder decodeObjectForKey:@"mobile"];
    self.province = [aDecoder decodeObjectForKey:@"province"];
    self.zipCode = [aDecoder decodeObjectForKey:@"zipCode"];
    self.userId = [aDecoder decodeObjectForKey:@"userId"];
    self.cityId = [aDecoder decodeObjectForKey:@"cityId"];
    self.address = [aDecoder decodeObjectForKey:@"address"];
    self.defaultFlag = [aDecoder decodeObjectForKey:@"defaultFlag"];
    self.city = [aDecoder decodeObjectForKey:@"city"];
    self.userName = [aDecoder decodeObjectForKey:@"userName"];
    self.county = [aDecoder decodeObjectForKey:@"county"];
    self.email = [aDecoder decodeObjectForKey:@"email"];
    self.provinceId = [aDecoder decodeObjectForKey:@"provinceId"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_addresslistIdentifier forKey:@"addresslistIdentifier"];
    [aCoder encodeObject:_phone forKey:@"phone"];
    [aCoder encodeObject:_countyId forKey:@"countyId"];
    [aCoder encodeObject:_mobile forKey:@"mobile"];
    [aCoder encodeObject:_province forKey:@"province"];
    [aCoder encodeObject:_zipCode forKey:@"zipCode"];
    [aCoder encodeObject:_userId forKey:@"userId"];
    [aCoder encodeObject:_cityId forKey:@"cityId"];
    [aCoder encodeObject:_address forKey:@"address"];
    [aCoder encodeObject:_defaultFlag forKey:@"defaultFlag"];
    [aCoder encodeObject:_city forKey:@"city"];
    [aCoder encodeObject:_userName forKey:@"userName"];
    [aCoder encodeObject:_county forKey:@"county"];
    [aCoder encodeObject:_email forKey:@"email"];
    [aCoder encodeObject:_provinceId forKey:@"provinceId"];
}



@end
