//
//  LoginUserinfo.m
//
//  Created by malan  on 14-4-8
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "LoginUserinfo.h"


@interface LoginUserinfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LoginUserinfo

@synthesize username = _username;
@synthesize addressnum = _addressnum;
@synthesize favoritenum = _favoritenum;
@synthesize ordernum = _ordernum;



+ (LoginUserinfo *)modelObjectWithDictionary:(NSDictionary *)dict
{
    LoginUserinfo *instance = [[LoginUserinfo alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.username = [self objectOrNilForKey:@"username" fromDictionary:dict];
            self.addressnum = [self objectOrNilForKey:@"addressnum" fromDictionary:dict];
            self.favoritenum = [self objectOrNilForKey:@"favoritenum" fromDictionary:dict];
            self.ordernum = [self objectOrNilForKey:@"ordernum" fromDictionary:dict];


    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.username forKey:@"username"];
    [mutableDict setValue:self.addressnum forKey:@"addressnum"];
    [mutableDict setValue:self.favoritenum forKey:@"favoritenum"];
    [mutableDict setValue:self.ordernum forKey:@"ordernum"];

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

    self.username = [aDecoder decodeObjectForKey:@"username"];
    self.addressnum = [aDecoder decodeObjectForKey:@"addressnum"];
    self.favoritenum = [aDecoder decodeObjectForKey:@"favoritenum"];
    self.ordernum = [aDecoder decodeObjectForKey:@"ordernum"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_username forKey:@"username"];
    [aCoder encodeObject:_addressnum forKey:@"addressnum"];
    [aCoder encodeObject:_favoritenum forKey:@"favoritenum"];
    [aCoder encodeObject:_ordernum forKey:@"ordernum"];
}

@end
