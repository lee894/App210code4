//
//  StoresStoresModel.m
//
//  Created by malan  on 14-4-27
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "StoresStoresModel.h"



@interface StoresStoresModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation StoresStoresModel

@synthesize stores = _stores;
@synthesize response = _response;


@synthesize requestTag;
@synthesize errorMessage;

+ (StoresStoresModel *)modelObjectWithDictionary:(NSDictionary *)dict
{
    StoresStoresModel *instance = [[StoresStoresModel alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
    NSObject *receivedStoresStores = [dict objectForKey:@"stores"];
    NSMutableArray *parsedStoresStores = [NSMutableArray array];
    if ([receivedStoresStores isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedStoresStores) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedStoresStores addObject:[StoresStores modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedStoresStores isKindOfClass:[NSDictionary class]]) {
       [parsedStoresStores addObject:[StoresStores modelObjectWithDictionary:(NSDictionary *)receivedStoresStores]];
    }

    self.stores = [NSArray arrayWithArray:parsedStoresStores];
            self.response = [self objectOrNilForKey:@"response" fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
NSMutableArray *tempArrayForStores = [NSMutableArray array];
    for (NSObject *subArrayObject in self.stores) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForStores addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForStores addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForStores] forKey:@"stores"];
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

    self.stores = [aDecoder decodeObjectForKey:@"stores"];
    self.response = [aDecoder decodeObjectForKey:@"response"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_stores forKey:@"stores"];
    [aCoder encodeObject:_response forKey:@"response"];
}

@end
