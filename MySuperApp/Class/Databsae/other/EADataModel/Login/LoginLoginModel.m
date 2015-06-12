//
//  LoginLoginModel.m
//
//  Created by malan  on 14-4-8
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "LoginLoginModel.h"



@interface LoginLoginModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LoginLoginModel

@synthesize userssion = _userssion;
@synthesize userid = _userid;
@synthesize response = _response;
@synthesize name = _name;
@synthesize more = _more;
@synthesize userinfo = _userinfo;
@synthesize vip= _vip;
@synthesize shopcartcount = _shopcartcount;
@synthesize userfaceurl = _userfaceurl;

@synthesize requestTag;
@synthesize errorMessage;


+ (LoginLoginModel *)modelObjectWithDictionary:(NSDictionary *)dict
{
    LoginLoginModel *instance = [[LoginLoginModel alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.userfaceurl = [self objectOrNilForKey:@"userfaceurl" fromDictionary:dict];
            self.userssion = [self objectOrNilForKey:@"userssion" fromDictionary:dict];
            self.userid = [self objectOrNilForKey:@"userid" fromDictionary:dict];
            self.response = [self objectOrNilForKey:@"response" fromDictionary:dict];
            self.name = [self objectOrNilForKey:@"name" fromDictionary:dict];
            self.vip = [self objectOrNilForKey:@"vip" fromDictionary:dict];
        self.shopcartcount = [[dict objectForKey:@"shopcartcount"] doubleValue];

    NSObject *receivedLoginMore = [dict objectForKey:@"more"];
    NSMutableArray *parsedLoginMore = [NSMutableArray array];
    if ([receivedLoginMore isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedLoginMore) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedLoginMore addObject:[LoginMore modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedLoginMore isKindOfClass:[NSDictionary class]]) {
       [parsedLoginMore addObject:[LoginMore modelObjectWithDictionary:(NSDictionary *)receivedLoginMore]];
    }

    self.more = [NSArray arrayWithArray:parsedLoginMore];
            self.userinfo = [LoginUserinfo modelObjectWithDictionary:[dict objectForKey:@"userinfo"]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.userssion forKey:@"userssion"];
    [mutableDict setValue:self.userid forKey:@"userid"];
    [mutableDict setValue:self.response forKey:@"response"];
    [mutableDict setValue:self.name forKey:@"name"];
    [mutableDict setValue:self.vip forKey:@"vip"];
    [mutableDict setValue:self.userfaceurl forKey:@"userfaceurl"];
    NSMutableArray *tempArrayForMore = [NSMutableArray array];
    for (NSObject *subArrayObject in self.more) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForMore addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForMore addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForMore] forKey:@"more"];
    [mutableDict setValue:[self.userinfo dictionaryRepresentation] forKey:@"userinfo"];

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

    self.userssion = [aDecoder decodeObjectForKey:@"userssion"];
    self.userid = [aDecoder decodeObjectForKey:@"userid"];
    self.response = [aDecoder decodeObjectForKey:@"response"];
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.more = [aDecoder decodeObjectForKey:@"more"];
    self.userinfo = [aDecoder decodeObjectForKey:@"userinfo"];
    self.vip = [aDecoder decodeObjectForKey:@"vip"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_userssion forKey:@"userssion"];
    [aCoder encodeObject:_userid forKey:@"userid"];
    [aCoder encodeObject:_response forKey:@"response"];
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_more forKey:@"more"];
    [aCoder encodeObject:_userinfo forKey:@"userinfo"];
    [aCoder encodeObject:_vip forKey:@"vip"];
}

@end
