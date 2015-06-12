//
//  CategoriesModel.m
//
//  Created by malan  on 14-4-26
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "CategoriesModel.h"
#import "CategoriesPictext.h"


@interface CategoriesModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CategoriesModel

@synthesize response = _response;
@synthesize categoriesPictext = _categoriesPictext;


@synthesize requestTag;
@synthesize errorMessage;

+ (CategoriesModel *)modelObjectWithDictionary:(NSDictionary *)dict
{
    CategoriesModel *instance = [[CategoriesModel alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.response = [self objectOrNilForKey:@"response" fromDictionary:dict];
    NSObject *receivedCategoriesPictext = [dict objectForKey:@"categories_pictext"];
    NSMutableArray *parsedCategoriesPictext = [NSMutableArray array];
    if ([receivedCategoriesPictext isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedCategoriesPictext) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedCategoriesPictext addObject:[CategoriesPictext modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedCategoriesPictext isKindOfClass:[NSDictionary class]]) {
       [parsedCategoriesPictext addObject:[CategoriesPictext modelObjectWithDictionary:(NSDictionary *)receivedCategoriesPictext]];
    }

    self.categoriesPictext = [NSArray arrayWithArray:parsedCategoriesPictext];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.response forKey:@"response"];
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
    self.categoriesPictext = [aDecoder decodeObjectForKey:@"categoriesPictext"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_response forKey:@"response"];
    [aCoder encodeObject:_categoriesPictext forKey:@"categoriesPictext"];
}


@end
