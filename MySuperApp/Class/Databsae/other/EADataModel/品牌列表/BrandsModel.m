//
//  BrandsModel.m
//
//  Created by malan  on 14-4-26
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "BrandsModel.h"



@interface BrandsModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BrandsModel

@synthesize response = _response;
@synthesize brandsWall = _brandsWall;

@synthesize requestTag;
@synthesize errorMessage;


+ (BrandsModel *)modelObjectWithDictionary:(NSDictionary *)dict
{
    BrandsModel *instance = [[BrandsModel alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.response = [self objectOrNilForKey:@"response" fromDictionary:dict];
    NSObject *receivedBrandsWall = [dict objectForKey:@"brands_wall"];
    NSMutableArray *parsedBrandsWall = [NSMutableArray array];
    if ([receivedBrandsWall isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedBrandsWall) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedBrandsWall addObject:[BrandsWall modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedBrandsWall isKindOfClass:[NSDictionary class]]) {
       [parsedBrandsWall addObject:[BrandsWall modelObjectWithDictionary:(NSDictionary *)receivedBrandsWall]];
    }

    self.brandsWall = [NSArray arrayWithArray:parsedBrandsWall];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.response forKey:@"response"];
NSMutableArray *tempArrayForBrandsWall = [NSMutableArray array];
    for (NSObject *subArrayObject in self.brandsWall) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForBrandsWall addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForBrandsWall addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForBrandsWall] forKey:@"brands_wall"];

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
    self.brandsWall = [aDecoder decodeObjectForKey:@"brandsWall"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_response forKey:@"response"];
    [aCoder encodeObject:_brandsWall forKey:@"brandsWall"];
}


@end
