//
//  MoerMoreModel.m
//
//  Created by malan  on 14-4-15
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "MoerMoreModel.h"


@interface MoerMoreModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MoerMoreModel

@synthesize response = _response;
@synthesize islogin = _islogin;
@synthesize more = _more;
@synthesize userinfo = _userinfo;


@synthesize requestTag;
@synthesize errorMessage;


+ (MoerMoreModel *)modelObjectWithDictionary:(NSDictionary *)dict
{
    MoerMoreModel *instance = [[MoerMoreModel alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.response = [self objectOrNilForKey:@"response" fromDictionary:dict];
            self.islogin = [[dict objectForKey:@"islogin"] boolValue];

    NSObject *receivedMoerMore = [dict objectForKey:@"more"];
    NSMutableArray *parsedMoerMore = [NSMutableArray array];
    if ([receivedMoerMore isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedMoerMore) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedMoerMore addObject:[MoerMore modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedMoerMore isKindOfClass:[NSDictionary class]]) {
       [parsedMoerMore addObject:[MoerMore modelObjectWithDictionary:(NSDictionary *)receivedMoerMore]];
    }

    self.more = [NSArray arrayWithArray:parsedMoerMore];
            self.userinfo = [MoerUserinfo modelObjectWithDictionary:[dict objectForKey:@"userinfo"]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.response forKey:@"response"];
    [mutableDict setValue:[NSNumber numberWithBool:self.islogin] forKey:@"islogin"];

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

    self.response = [aDecoder decodeObjectForKey:@"response"];
    self.islogin = [aDecoder decodeBoolForKey:@"islogin"];
    self.more = [aDecoder decodeObjectForKey:@"more"];
    self.userinfo = [aDecoder decodeObjectForKey:@"userinfo"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_response forKey:@"response"];
    [aCoder encodeBool:_islogin forKey:@"islogin"];
    [aCoder encodeObject:_more forKey:@"more"];
    [aCoder encodeObject:_userinfo forKey:@"userinfo"];
}

@end
