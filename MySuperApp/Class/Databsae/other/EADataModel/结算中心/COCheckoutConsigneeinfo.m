//
//  COCheckoutConsigneeinfo.m
//
//  Created by malan  on 14-4-7
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "COCheckoutConsigneeinfo.h"


@interface COCheckoutConsigneeinfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation COCheckoutConsigneeinfo

@synthesize mobile = _mobile;
@synthesize county = _county;
@synthesize phone = _phone;
@synthesize checkoutConsigneeinfoIdentifier = _checkoutConsigneeinfoIdentifier;
@synthesize city = _city;
@synthesize zipCode = _zipCode;
@synthesize address = _address;
@synthesize defaultFlag = _defaultFlag;
@synthesize email = _email;
@synthesize userName = _userName;
@synthesize province = _province;


+ (COCheckoutConsigneeinfo *)modelObjectWithDictionary:(NSDictionary *)dict
{
    COCheckoutConsigneeinfo *instance = [[COCheckoutConsigneeinfo alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.mobile = [self objectOrNilForKey:@"mobile" fromDictionary:dict];
            self.county = [self objectOrNilForKey:@"county" fromDictionary:dict];
            self.phone = [self objectOrNilForKey:@"phone" fromDictionary:dict];
            self.checkoutConsigneeinfoIdentifier = [self objectOrNilForKey:@"id" fromDictionary:dict];
            self.city = [self objectOrNilForKey:@"city" fromDictionary:dict];
            self.zipCode = [self objectOrNilForKey:@"zip_code" fromDictionary:dict];
            self.address = [self objectOrNilForKey:@"address" fromDictionary:dict];
            self.defaultFlag = [self objectOrNilForKey:@"default_flag" fromDictionary:dict];
            self.email = [self objectOrNilForKey:@"email" fromDictionary:dict];
            self.userName = [self objectOrNilForKey:@"user_name" fromDictionary:dict];
            self.province = [self objectOrNilForKey:@"province" fromDictionary:dict];

    }
    
    return self;
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.mobile forKey:@"mobile"];
    [mutableDict setValue:self.county forKey:@"county"];
    [mutableDict setValue:self.phone forKey:@"phone"];
    [mutableDict setValue:self.checkoutConsigneeinfoIdentifier forKey:@"id"];
    [mutableDict setValue:self.city forKey:@"city"];
    [mutableDict setValue:self.zipCode forKey:@"zip_code"];
    [mutableDict setValue:self.address forKey:@"address"];
    [mutableDict setValue:self.defaultFlag forKey:@"default_flag"];
    [mutableDict setValue:self.email forKey:@"email"];
    [mutableDict setValue:self.userName forKey:@"user_name"];
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

    self.mobile = [aDecoder decodeObjectForKey:@"mobile"];
    self.county = [aDecoder decodeObjectForKey:@"county"];
    self.phone = [aDecoder decodeObjectForKey:@"phone"];
    self.checkoutConsigneeinfoIdentifier = [aDecoder decodeObjectForKey:@"checkoutConsigneeinfoIdentifier"];
    self.city = [aDecoder decodeObjectForKey:@"city"];
    self.zipCode = [aDecoder decodeObjectForKey:@"zipCode"];
    self.address = [aDecoder decodeObjectForKey:@"address"];
    self.defaultFlag = [aDecoder decodeObjectForKey:@"defaultFlag"];
    self.email = [aDecoder decodeObjectForKey:@"email"];
    self.userName = [aDecoder decodeObjectForKey:@"userName"];
    self.province = [aDecoder decodeObjectForKey:@"province"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_mobile forKey:@"mobile"];
    [aCoder encodeObject:_county forKey:@"county"];
    [aCoder encodeObject:_phone forKey:@"phone"];
    [aCoder encodeObject:_checkoutConsigneeinfoIdentifier forKey:@"checkoutConsigneeinfoIdentifier"];
    [aCoder encodeObject:_city forKey:@"city"];
    [aCoder encodeObject:_zipCode forKey:@"zipCode"];
    [aCoder encodeObject:_address forKey:@"address"];
    [aCoder encodeObject:_defaultFlag forKey:@"defaultFlag"];
    [aCoder encodeObject:_email forKey:@"email"];
    [aCoder encodeObject:_userName forKey:@"userName"];
    [aCoder encodeObject:_province forKey:@"province"];
}


@end
