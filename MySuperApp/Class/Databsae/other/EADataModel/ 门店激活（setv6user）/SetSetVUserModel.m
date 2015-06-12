//
//  SetSetVUserModel.m
//
//  Created by malan  on 14-4-10
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "SetSetVUserModel.h"


@interface SetSetVUserModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SetSetVUserModel

@synthesize res = _res;
@synthesize mobile = _mobile;
@synthesize response = _response;

@synthesize requestTag;
@synthesize errorMessage;

@synthesize userssion = _userssion;


+ (SetSetVUserModel *)modelObjectWithDictionary:(NSDictionary *)dict
{
    SetSetVUserModel *instance = [[SetSetVUserModel alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.res = [self objectOrNilForKey:@"res" fromDictionary:dict];
            self.mobile = [self objectOrNilForKey:@"mobile" fromDictionary:dict];
            self.response = [self objectOrNilForKey:@"response" fromDictionary:dict];

        self.userssion = [self objectOrNilForKey:@"userssion" fromDictionary:dict];

        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.res forKey:@"res"];
    [mutableDict setValue:self.mobile forKey:@"mobile"];
    [mutableDict setValue:self.response forKey:@"response"];

    [mutableDict setValue:self.userssion forKey:@"userssion"];

    
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

    self.res = [aDecoder decodeObjectForKey:@"res"];
    self.mobile = [aDecoder decodeObjectForKey:@"mobile"];
    self.response = [aDecoder decodeObjectForKey:@"response"];
    
    self.userssion = [aDecoder decodeObjectForKey:@"userssion"];

    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_res forKey:@"res"];
    [aCoder encodeObject:_mobile forKey:@"mobile"];
    [aCoder encodeObject:_response forKey:@"response"];
    
    [aCoder encodeObject:_userssion forKey:@"userssion"];
}

@end
