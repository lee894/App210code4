//
//  CannelCategires.m
//
//  Created by malan  on 14-4-3
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "CannelCategires.h"


@interface CannelCategires ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CannelCategires

@synthesize categoriesPictext = _categoriesPictext;
@synthesize response = _response;


+ (CannelCategires *)modelObjectWithDictionary:(NSDictionary *)dict
{
    CannelCategires *instance = [[CannelCategires alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
    NSObject *receivedCannelCategoriesPictext = [dict objectForKey:@"categories_pictext"];
    NSMutableArray *parsedCannelCategoriesPictext = [NSMutableArray array];
    if ([receivedCannelCategoriesPictext isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedCannelCategoriesPictext) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedCannelCategoriesPictext addObject:[CannelCategoriesPictext modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedCannelCategoriesPictext isKindOfClass:[NSDictionary class]]) {
       [parsedCannelCategoriesPictext addObject:[CannelCategoriesPictext modelObjectWithDictionary:(NSDictionary *)receivedCannelCategoriesPictext]];
    }

    self.categoriesPictext = [NSArray arrayWithArray:parsedCannelCategoriesPictext];
            self.response = [self objectOrNilForKey:@"response" fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
NSMutableArray *tempArrayForCategoriesPictext = [NSMutableArray array];
    for (NSObject *subArrayObject in self.categoriesPictext) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForCategoriesPictext addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForCategoriesPictext addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForCategoriesPictext] forKey:@"categories_pictext"];
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

    self.categoriesPictext = [aDecoder decodeObjectForKey:@"categoriesPictext"];
    self.response = [aDecoder decodeObjectForKey:@"response"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_categoriesPictext forKey:@"categoriesPictext"];
    [aCoder encodeObject:_response forKey:@"response"];
}

@end
