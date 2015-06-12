//
//  BrandsProductListModel.m
//
//  Created by malan  on 14-4-13
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "BrandsProductListModel.h"



@interface BrandsProductListModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BrandsProductListModel

@synthesize recordCount = _recordCount;
@synthesize types = _types;
@synthesize productlistPictext = _productlistPictext;
@synthesize brandInfo = _brandInfo;
@synthesize currentPage = _currentPage;
@synthesize productlistFilter = _productlistFilter;
@synthesize response = _response;
@synthesize pageCount = _pageCount;
@synthesize shopcartcount = _shopcartcount;
@synthesize productlist_select_filter = _productlist_select_filter;

@synthesize requestTag;
@synthesize errorMessage;

+ (BrandsProductListModel *)modelObjectWithDictionary:(NSDictionary *)dict
{
    BrandsProductListModel *instance = [[BrandsProductListModel alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        self.shopcartcount = [[dict objectForKey:@"shopcartcount"] doubleValue];
        
        
        [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%.f", self.shopcartcount] forKey:@"totalNUM"];
        
        
        [UIApplication sharedApplication].applicationIconBadgeNumber=[[[NSUserDefaults standardUserDefaults]objectForKey:@"totalNUM"]intValue];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TotleNumber" object:nil];

            self.recordCount = [[dict objectForKey:@"record_count"] doubleValue];
    NSObject *receivedBrandsTypes = [dict objectForKey:@"types"];
    NSMutableArray *parsedBrandsTypes = [NSMutableArray array];
    if ([receivedBrandsTypes isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedBrandsTypes) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedBrandsTypes addObject:[BrandsTypes modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedBrandsTypes isKindOfClass:[NSDictionary class]]) {
       [parsedBrandsTypes addObject:[BrandsTypes modelObjectWithDictionary:(NSDictionary *)receivedBrandsTypes]];
    }

    self.types = [NSArray arrayWithArray:parsedBrandsTypes];
    NSObject *receivedBrandsProductlistPictext = [dict objectForKey:@"productlist_pictext"];
    NSMutableArray *parsedBrandsProductlistPictext = [NSMutableArray array];
    if ([receivedBrandsProductlistPictext isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedBrandsProductlistPictext) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedBrandsProductlistPictext addObject:[BrandsProductlistPictext modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedBrandsProductlistPictext isKindOfClass:[NSDictionary class]]) {
       [parsedBrandsProductlistPictext addObject:[BrandsProductlistPictext modelObjectWithDictionary:(NSDictionary *)receivedBrandsProductlistPictext]];
    }

    self.productlistPictext = [NSArray arrayWithArray:parsedBrandsProductlistPictext];
            self.brandInfo = [BrandsBrandInfo modelObjectWithDictionary:[dict objectForKey:@"brand_info"]];
            self.currentPage = [[dict objectForKey:@"current_page"] doubleValue];
        
    //lee987 新增选中筛选
    self.productlist_select_filter = [dict objectForKey:@"productlist_select_filter"];

        
    NSObject *receivedBrandsProductlistFilter = [dict objectForKey:@"productlist_filter"];
    NSMutableArray *parsedBrandsProductlistFilter = [NSMutableArray array];
    if ([receivedBrandsProductlistFilter isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedBrandsProductlistFilter) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedBrandsProductlistFilter addObject:[BrandsProductlistFilter modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedBrandsProductlistFilter isKindOfClass:[NSDictionary class]]) {
       [parsedBrandsProductlistFilter addObject:[BrandsProductlistFilter modelObjectWithDictionary:(NSDictionary *)receivedBrandsProductlistFilter]];
    }

    self.productlistFilter = [NSArray arrayWithArray:parsedBrandsProductlistFilter];
            self.response = [self objectOrNilForKey:@"response" fromDictionary:dict];
            self.pageCount = [[dict objectForKey:@"page_count"] doubleValue];

    }
    
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.recordCount] forKey:@"record_count"];
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
    [mutableDict setValue:[self.brandInfo dictionaryRepresentation] forKey:@"brand_info"];
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

    self.recordCount = [aDecoder decodeDoubleForKey:@"recordCount"];
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

    [aCoder encodeDouble:_recordCount forKey:@"recordCount"];
    [aCoder encodeObject:_types forKey:@"types"];
    [aCoder encodeObject:_productlistPictext forKey:@"productlistPictext"];
    [aCoder encodeObject:_brandInfo forKey:@"brandInfo"];
    [aCoder encodeDouble:_currentPage forKey:@"currentPage"];
    [aCoder encodeObject:_productlistFilter forKey:@"productlistFilter"];
    [aCoder encodeObject:_response forKey:@"response"];
    [aCoder encodeDouble:_pageCount forKey:@"pageCount"];
}


@end
