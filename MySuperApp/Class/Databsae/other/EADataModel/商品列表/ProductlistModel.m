//
//  ProductlistModel.m
//
//  Created by malan  on 14-4-26
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "ProductlistModel.h"
#import "ProductlistPictext.h"
#import "ProductlistFilter.h"


@interface ProductlistModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ProductlistModel

@synthesize recordCount = _recordCount;
@synthesize types = _types;
@synthesize productlistPictext = _productlistPictext;
@synthesize brandInfo = _brandInfo;
@synthesize currentPage = _currentPage;
@synthesize productlistFilter = _productlistFilter;
@synthesize response = _response;
@synthesize pageCount = _pageCount;


@synthesize requestTag;
@synthesize errorMessage;


+ (ProductlistModel *)modelObjectWithDictionary:(NSDictionary *)dict
{
    ProductlistModel *instance = [[ProductlistModel alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.recordCount = [self objectOrNilForKey:@"record_count" fromDictionary:dict];
            self.types = [self objectOrNilForKey:@"types" fromDictionary:dict];
    NSObject *receivedProductlistPictext = [dict objectForKey:@"productlist_pictext"];
    NSMutableArray *parsedProductlistPictext = [NSMutableArray array];
    if ([receivedProductlistPictext isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedProductlistPictext) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedProductlistPictext addObject:[ProductlistPictext modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedProductlistPictext isKindOfClass:[NSDictionary class]]) {
       [parsedProductlistPictext addObject:[ProductlistPictext modelObjectWithDictionary:(NSDictionary *)receivedProductlistPictext]];
    }

    self.productlistPictext = [NSArray arrayWithArray:parsedProductlistPictext];
            self.brandInfo = [self objectOrNilForKey:@"brand_info" fromDictionary:dict];
            self.currentPage = [[dict objectForKey:@"current_page"] doubleValue];
    NSObject *receivedProductlistFilter = [dict objectForKey:@"productlist_filter"];
    NSMutableArray *parsedProductlistFilter = [NSMutableArray array];
    if ([receivedProductlistFilter isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedProductlistFilter) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedProductlistFilter addObject:[ProductlistFilter modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedProductlistFilter isKindOfClass:[NSDictionary class]]) {
       [parsedProductlistFilter addObject:[ProductlistFilter modelObjectWithDictionary:(NSDictionary *)receivedProductlistFilter]];
    }

    self.productlistFilter = [NSArray arrayWithArray:parsedProductlistFilter];
            self.response = [self objectOrNilForKey:@"response" fromDictionary:dict];
            self.pageCount = [[dict objectForKey:@"page_count"] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.recordCount forKey:@"record_count"];
NSMutableArray *tempArrayForTypes = [NSMutableArray array];
    for (NSObject *subArrayObject in self.types) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForTypes addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForTypes addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForTypes] forKey:@"types"];
NSMutableArray *tempArrayForProductlistPictext = [NSMutableArray array];
    for (NSObject *subArrayObject in self.productlistPictext) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForProductlistPictext addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForProductlistPictext addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForProductlistPictext] forKey:@"productlist_pictext"];
    [mutableDict setValue:self.brandInfo forKey:@"brand_info"];
    [mutableDict setValue:[NSNumber numberWithDouble:self.currentPage] forKey:@"current_page"];
NSMutableArray *tempArrayForProductlistFilter = [NSMutableArray array];
    for (NSObject *subArrayObject in self.productlistFilter) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForProductlistFilter addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForProductlistFilter addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForProductlistFilter] forKey:@"productlist_filter"];
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

    self.recordCount = [aDecoder decodeObjectForKey:@"recordCount"];
    self.types = [aDecoder decodeObjectForKey:@"types"];
    self.productlistPictext = [aDecoder decodeObjectForKey:@"productlistPictext"];
    self.brandInfo = [aDecoder decodeObjectForKey:@"brandInfo"];
    self.currentPage = [aDecoder decodeDoubleForKey:@"currentPage"];
    self.productlistFilter = [aDecoder decodeObjectForKey:@"productlistFilter"];
    self.response = [aDecoder decodeObjectForKey:@"response"];
    self.pageCount = [aDecoder decodeDoubleForKey:@"pageCount"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_recordCount forKey:@"recordCount"];
    [aCoder encodeObject:_types forKey:@"types"];
    [aCoder encodeObject:_productlistPictext forKey:@"productlistPictext"];
    [aCoder encodeObject:_brandInfo forKey:@"brandInfo"];
    [aCoder encodeDouble:_currentPage forKey:@"currentPage"];
    [aCoder encodeObject:_productlistFilter forKey:@"productlistFilter"];
    [aCoder encodeObject:_response forKey:@"response"];
    [aCoder encodeDouble:_pageCount forKey:@"pageCount"];
}


@end
