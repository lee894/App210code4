//
//  COPromotions.m
//
//  Created by malan  on 14-4-7
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "COPromotions.h"
#import "COPrice.h"


@interface COPromotions ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation COPromotions

@synthesize price = _price;
@synthesize exempt = _exempt;


+ (COPromotions *)modelObjectWithDictionary:(NSDictionary *)dict
{
    COPromotions *instance = [[COPromotions alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
    NSObject *receivedCOPrice = [dict objectForKey:@"price"];
    NSMutableArray *parsedCOPrice = [NSMutableArray array];
    if ([receivedCOPrice isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedCOPrice) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedCOPrice addObject:[COPrice modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedCOPrice isKindOfClass:[NSDictionary class]]) {
       [parsedCOPrice addObject:[COPrice modelObjectWithDictionary:(NSDictionary *)receivedCOPrice]];
    }

    self.price = [NSArray arrayWithArray:parsedCOPrice];
            self.exempt = [self objectOrNilForKey:@"exempt" fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
NSMutableArray *tempArrayForPrice = [NSMutableArray array];
    for (NSObject *subArrayObject in self.price) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForPrice addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForPrice addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForPrice] forKey:@"price"];
NSMutableArray *tempArrayForExempt = [NSMutableArray array];
    for (NSObject *subArrayObject in self.exempt) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForExempt addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForExempt addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForExempt] forKey:@"exempt"];

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

    self.price = [aDecoder decodeObjectForKey:@"price"];
    self.exempt = [aDecoder decodeObjectForKey:@"exempt"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_price forKey:@"price"];
    [aCoder encodeObject:_exempt forKey:@"exempt"];
}


@end
