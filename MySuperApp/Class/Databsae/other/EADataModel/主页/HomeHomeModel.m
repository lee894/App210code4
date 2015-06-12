//
//  HomeHomeModel.m
//
//  Created by malan  on 14-4-12
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "HomeHomeModel.h"



@interface HomeHomeModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation HomeHomeModel

@synthesize notice = _notice;
@synthesize homeTestBanner = _homeTestBanner;
@synthesize response = _response;
@synthesize cartNum = _cartNum;
@synthesize homeBanner = _homeBanner;

@synthesize requestTag;
@synthesize errorMessage;


+ (HomeHomeModel *)modelObjectWithDictionary:(NSDictionary *)dict
{
    HomeHomeModel *instance = [[HomeHomeModel alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.notice = [self objectOrNilForKey:@"notice" fromDictionary:dict];
    NSObject *receivedHomeHomeTestBanner = [dict objectForKey:@"home_test_banner"];
    NSMutableArray *parsedHomeHomeTestBanner = [NSMutableArray array];
    if ([receivedHomeHomeTestBanner isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedHomeHomeTestBanner) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedHomeHomeTestBanner addObject:[HomeHomeTestBanner modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedHomeHomeTestBanner isKindOfClass:[NSDictionary class]]) {
       [parsedHomeHomeTestBanner addObject:[HomeHomeTestBanner modelObjectWithDictionary:(NSDictionary *)receivedHomeHomeTestBanner]];
    }

    self.homeTestBanner = [NSArray arrayWithArray:parsedHomeHomeTestBanner];
            self.response = [self objectOrNilForKey:@"response" fromDictionary:dict];
            self.cartNum = [[dict objectForKey:@"cart_num"] doubleValue];
    NSObject *receivedHomeHomeBanner = [dict objectForKey:@"home_banner"];
    NSMutableArray *parsedHomeHomeBanner = [NSMutableArray array];
    if ([receivedHomeHomeBanner isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedHomeHomeBanner) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedHomeHomeBanner addObject:[HomeHomeBanner modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedHomeHomeBanner isKindOfClass:[NSDictionary class]]) {
       [parsedHomeHomeBanner addObject:[HomeHomeBanner modelObjectWithDictionary:(NSDictionary *)receivedHomeHomeBanner]];
    }

    self.homeBanner = [NSArray arrayWithArray:parsedHomeHomeBanner];

    }
    return self;
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
NSMutableArray *tempArrayForNotice = [NSMutableArray array];
    for (NSObject *subArrayObject in self.notice) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForNotice addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForNotice addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForNotice] forKey:@"notice"];
NSMutableArray *tempArrayForHomeTestBanner = [NSMutableArray array];
    for (NSObject *subArrayObject in self.homeTestBanner) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForHomeTestBanner addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForHomeTestBanner addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForHomeTestBanner] forKey:@"home_test_banner"];
    [mutableDict setValue:self.response forKey:@"response"];
    [mutableDict setValue:[NSNumber numberWithDouble:self.cartNum] forKey:@"cart_num"];
NSMutableArray *tempArrayForHomeBanner = [NSMutableArray array];
    for (NSObject *subArrayObject in self.homeBanner) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForHomeBanner addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForHomeBanner addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForHomeBanner] forKey:@"home_banner"];

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

    self.notice = [aDecoder decodeObjectForKey:@"notice"];
    self.homeTestBanner = [aDecoder decodeObjectForKey:@"homeTestBanner"];
    self.response = [aDecoder decodeObjectForKey:@"response"];
    self.cartNum = [aDecoder decodeDoubleForKey:@"cartNum"];
    self.homeBanner = [aDecoder decodeObjectForKey:@"homeBanner"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_notice forKey:@"notice"];
    [aCoder encodeObject:_homeTestBanner forKey:@"homeTestBanner"];
    [aCoder encodeObject:_response forKey:@"response"];
    [aCoder encodeDouble:_cartNum forKey:@"cartNum"];
    [aCoder encodeObject:_homeBanner forKey:@"homeBanner"];
}


@end
