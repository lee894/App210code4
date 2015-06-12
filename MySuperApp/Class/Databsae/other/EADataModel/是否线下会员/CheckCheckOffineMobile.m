//
//  CheckCheckOffineMobile.m
//
//  Created by malan  on 14-4-9
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "CheckCheckOffineMobile.h"


@interface CheckCheckOffineMobile ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CheckCheckOffineMobile

@synthesize offline = _offline;
@synthesize response = _response;

@synthesize requestTag,errorMessage;


+ (CheckCheckOffineMobile *)modelObjectWithDictionary:(NSDictionary *)dict
{
    CheckCheckOffineMobile *instance = [[CheckCheckOffineMobile alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.offline = [self objectOrNilForKey:@"offline" fromDictionary:dict];
            self.response = [self objectOrNilForKey:@"response" fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.offline forKey:@"offline"];
    [mutableDict setValue:self.response forKey:@"response"];

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

    self.offline = [aDecoder decodeObjectForKey:@"offline"];
    self.response = [aDecoder decodeObjectForKey:@"response"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_offline forKey:@"offline"];
    [aCoder encodeObject:_response forKey:@"response"];
}

@end
