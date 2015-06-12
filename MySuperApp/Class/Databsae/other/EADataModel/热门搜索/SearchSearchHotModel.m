//
//  SearchSearchHotModel.m
//
//  Created by malan  on 14-4-22
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "SearchSearchHotModel.h"


@interface SearchSearchHotModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SearchSearchHotModel

@synthesize keyword = _keyword;
@synthesize response = _response;

@synthesize requestTag;
@synthesize errorMessage;

+ (SearchSearchHotModel *)modelObjectWithDictionary:(NSDictionary *)dict
{
    SearchSearchHotModel *instance = [[SearchSearchHotModel alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
    NSObject *receivedSearchKeyword = [dict objectForKey:@"keyword"];
    NSMutableArray *parsedSearchKeyword = [NSMutableArray array];
    if ([receivedSearchKeyword isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedSearchKeyword) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedSearchKeyword addObject:[SearchKeyword modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedSearchKeyword isKindOfClass:[NSDictionary class]]) {
       [parsedSearchKeyword addObject:[SearchKeyword modelObjectWithDictionary:(NSDictionary *)receivedSearchKeyword]];
    }

    self.keyword = [NSArray arrayWithArray:parsedSearchKeyword];
            self.response = [self objectOrNilForKey:@"response" fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
NSMutableArray *tempArrayForKeyword = [NSMutableArray array];
    for (NSObject *subArrayObject in self.keyword) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForKeyword addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForKeyword addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForKeyword] forKey:@"keyword"];
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

    self.keyword = [aDecoder decodeObjectForKey:@"keyword"];
    self.response = [aDecoder decodeObjectForKey:@"response"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_keyword forKey:@"keyword"];
    [aCoder encodeObject:_response forKey:@"response"];
}

@end
