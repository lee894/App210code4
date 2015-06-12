//
//  CannelCannelHomeModel.m
//
//  Created by malan  on 14-4-3
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "CannelCannelHomeModel.h"



@interface CannelCannelHomeModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CannelCannelHomeModel

@synthesize channel = _channel;
@synthesize response = _response;


@synthesize requestTag;
@synthesize errorMessage;

+ (CannelCannelHomeModel *)modelObjectWithDictionary:(NSDictionary *)dict
{
    CannelCannelHomeModel *instance = [[CannelCannelHomeModel alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];

    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.channel = [CannelChannel modelObjectWithDictionary:[dict objectForKey:@"channel"]];
            self.response = [self objectOrNilForKey:@"response" fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.channel dictionaryRepresentation] forKey:@"channel"];
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

    self.channel = [aDecoder decodeObjectForKey:@"channel"];
    self.response = [aDecoder decodeObjectForKey:@"response"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_channel forKey:@"channel"];
    [aCoder encodeObject:_response forKey:@"response"];
}

@end
