//
//  CouponcardListCouponcardListModel.m
//
//  Created by malan  on 14-4-26
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "CouponcardListCouponcardListModel.h"
#import "CouponcardListCheckoutCouponcard.h"


@interface CouponcardListCouponcardListModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CouponcardListCouponcardListModel

@synthesize requestTag;
@synthesize errorMessage;

@synthesize currentPage = _currentPage;
@synthesize recordCount = _recordCount;
@synthesize response = _response;
@synthesize pageCount = _pageCount;
@synthesize checkoutCouponcard = _checkoutCouponcard;


+ (CouponcardListCouponcardListModel *)modelObjectWithDictionary:(NSDictionary *)dict
{
    CouponcardListCouponcardListModel *instance = [[CouponcardListCouponcardListModel alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        self.currentPage = [[dict objectForKey:@"current_page"] intValue];
        self.recordCount = [self objectOrNilForKey:@"record_count" fromDictionary:dict];
        self.response = [self objectOrNilForKey:@"response" fromDictionary:dict];
        self.pageCount = [[dict objectForKey:@"page_count"] intValue];
        self.cards_count = [[self objectOrNilForKey:@"cards_count" fromDictionary:dict] intValue];
        self.couponcard_count = [[self objectOrNilForKey:@"couponcard_count" fromDictionary:dict] intValue];
        self.checkoutCards = [dict objectForKey:@"checkout_carts"];
        self.checkoutCouponcard = [dict objectForKey:@"checkout_couponcard"];
    }
    return self;
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.currentPage] forKey:@"current_page"];
    [mutableDict setValue:self.recordCount forKey:@"record_count"];
    [mutableDict setValue:self.response forKey:@"response"];
    [mutableDict setValue:[NSNumber numberWithDouble:self.pageCount] forKey:@"page_count"];
    NSMutableArray *tempArrayForCheckoutCouponcard = [NSMutableArray array];
    for (NSObject *subArrayObject in self.checkoutCouponcard) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForCheckoutCouponcard addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForCheckoutCouponcard addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForCheckoutCouponcard] forKey:@"checkout_couponcard"];
    
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
    self.recordCount = [aDecoder decodeObjectForKey:@"recordCount"];
    self.response = [aDecoder decodeObjectForKey:@"response"];
    self.pageCount = [aDecoder decodeDoubleForKey:@"pageCount"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeDouble:_currentPage forKey:@"currentPage"];
    [aCoder encodeObject:_recordCount forKey:@"recordCount"];
    [aCoder encodeObject:_response forKey:@"response"];
    [aCoder encodeDouble:_pageCount forKey:@"pageCount"];
}


@end
