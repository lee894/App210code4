//
//  FavoriteFavoriteModel.m
//
//  Created by malan  on 14-4-19
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "FavoriteFavoriteModel.h"

@interface FavoriteFavoriteModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation FavoriteFavoriteModel

@synthesize currentPage = _currentPage;
@synthesize favoritePic = _favoritePic;
@synthesize recordCount = _recordCount;
@synthesize response = _response;
@synthesize pageCount = _pageCount;


@synthesize requestTag;
@synthesize errorMessage;

+ (FavoriteFavoriteModel *)modelObjectWithDictionary:(NSDictionary *)dict
{
    FavoriteFavoriteModel *instance = [[FavoriteFavoriteModel alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.currentPage = [[dict objectForKey:@"current_page"] doubleValue];
    NSObject *receivedFavoriteFavoritePic = [dict objectForKey:@"favorite_pic"];
    NSMutableArray *parsedFavoriteFavoritePic = [NSMutableArray array];
    if ([receivedFavoriteFavoritePic isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedFavoriteFavoritePic) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedFavoriteFavoritePic addObject:[FavoriteFavoritePic modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedFavoriteFavoritePic isKindOfClass:[NSDictionary class]]) {
       [parsedFavoriteFavoritePic addObject:[FavoriteFavoritePic modelObjectWithDictionary:(NSDictionary *)receivedFavoriteFavoritePic]];
    }

    self.favoritePic = [NSMutableArray arrayWithArray:parsedFavoriteFavoritePic];
            self.recordCount = [self objectOrNilForKey:@"record_count" fromDictionary:dict];
            self.response = [self objectOrNilForKey:@"response" fromDictionary:dict];
            self.pageCount = [[dict objectForKey:@"page_count"] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.currentPage] forKey:@"current_page"];
NSMutableArray *tempArrayForFavoritePic = [NSMutableArray array];
    for (NSObject *subArrayObject in self.favoritePic) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForFavoritePic addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForFavoritePic addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForFavoritePic] forKey:@"favorite_pic"];
    [mutableDict setValue:self.recordCount forKey:@"record_count"];
    [mutableDict setValue:self.response forKey:@"response"];
    [mutableDict setValue:[NSNumber numberWithDouble:self.pageCount] forKey:@"page_count"];

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

    self.currentPage = [aDecoder decodeDoubleForKey:@"currentPage"];
    self.favoritePic = [aDecoder decodeObjectForKey:@"favoritePic"];
    self.recordCount = [aDecoder decodeObjectForKey:@"recordCount"];
    self.response = [aDecoder decodeObjectForKey:@"response"];
    self.pageCount = [aDecoder decodeDoubleForKey:@"pageCount"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeDouble:_currentPage forKey:@"currentPage"];
    [aCoder encodeObject:_favoritePic forKey:@"favoritePic"];
    [aCoder encodeObject:_recordCount forKey:@"recordCount"];
    [aCoder encodeObject:_response forKey:@"response"];
    [aCoder encodeDouble:_pageCount forKey:@"pageCount"];
}

@end
