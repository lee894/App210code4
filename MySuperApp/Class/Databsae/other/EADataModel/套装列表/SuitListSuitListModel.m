//
//  SuitListSuitListModel.m
//
//  Created by malan  on 14-4-23
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "SuitListSuitListModel.h"



@interface SuitListSuitListModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SuitListSuitListModel

@synthesize suitlist = _suitlist;
@synthesize response = _response;

@synthesize requestTag;
@synthesize errorMessage;


+ (SuitListSuitListModel *)modelObjectWithDictionary:(NSDictionary *)dict
{
    SuitListSuitListModel *instance = [[SuitListSuitListModel alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
    NSObject *receivedSuitListSuitlist = [dict objectForKey:@"suitlist"];
    NSMutableArray *parsedSuitListSuitlist = [NSMutableArray array];
    if ([receivedSuitListSuitlist isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedSuitListSuitlist) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedSuitListSuitlist addObject:[SuitListSuitlist modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedSuitListSuitlist isKindOfClass:[NSDictionary class]]) {
       [parsedSuitListSuitlist addObject:[SuitListSuitlist modelObjectWithDictionary:(NSDictionary *)receivedSuitListSuitlist]];
    }

    self.suitlist = [NSArray arrayWithArray:parsedSuitListSuitlist];
            self.response = [self objectOrNilForKey:@"response" fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
NSMutableArray *tempArrayForSuitlist = [NSMutableArray array];
    for (NSObject *subArrayObject in self.suitlist) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForSuitlist addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForSuitlist addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForSuitlist] forKey:@"suitlist"];
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

    self.suitlist = [aDecoder decodeObjectForKey:@"suitlist"];
    self.response = [aDecoder decodeObjectForKey:@"response"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_suitlist forKey:@"suitlist"];
    [aCoder encodeObject:_response forKey:@"response"];
}

@end
