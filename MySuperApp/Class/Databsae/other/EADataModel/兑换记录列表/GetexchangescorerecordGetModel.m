//
//  GetexchangescorerecordGetModel.m
//
//  Created by malan  on 14-4-27
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "GetexchangescorerecordGetModel.h"



@interface GetexchangescorerecordGetModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation GetexchangescorerecordGetModel

@synthesize record = _record;
@synthesize response = _response;

@synthesize requestTag;
@synthesize errorMessage;


+ (GetexchangescorerecordGetModel *)modelObjectWithDictionary:(NSDictionary *)dict
{
    GetexchangescorerecordGetModel *instance = [[GetexchangescorerecordGetModel alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
    NSObject *receivedGetexchangescorerecordRecord = [dict objectForKey:@"record"];
    NSMutableArray *parsedGetexchangescorerecordRecord = [NSMutableArray array];
    if ([receivedGetexchangescorerecordRecord isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedGetexchangescorerecordRecord) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedGetexchangescorerecordRecord addObject:[GetexchangescorerecordRecord modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedGetexchangescorerecordRecord isKindOfClass:[NSDictionary class]]) {
       [parsedGetexchangescorerecordRecord addObject:[GetexchangescorerecordRecord modelObjectWithDictionary:(NSDictionary *)receivedGetexchangescorerecordRecord]];
    }

    self.record = [NSArray arrayWithArray:parsedGetexchangescorerecordRecord];
            self.response = [self objectOrNilForKey:@"response" fromDictionary:dict];
    }
    return self;
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
NSMutableArray *tempArrayForRecord = [NSMutableArray array];
    for (NSObject *subArrayObject in self.record) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForRecord addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForRecord addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForRecord] forKey:@"record"];
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

    self.record = [aDecoder decodeObjectForKey:@"record"];
    self.response = [aDecoder decodeObjectForKey:@"response"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_record forKey:@"record"];
    [aCoder encodeObject:_response forKey:@"response"];
}


@end
