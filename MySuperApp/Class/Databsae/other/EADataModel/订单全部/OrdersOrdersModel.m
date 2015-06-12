//
//  OrdersOrdersModel.m
//
//  Created by malan  on 14-4-19
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "OrdersOrdersModel.h"


@interface OrdersOrdersModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation OrdersOrdersModel

@synthesize currentPage = _currentPage;
@synthesize recordCount = _recordCount;
@synthesize response = _response;
@synthesize pageCount = _pageCount;
@synthesize ordersList = _ordersList;

@synthesize requestTag;
@synthesize errorMessage;


+ (OrdersOrdersModel *)modelObjectWithDictionary:(NSDictionary *)dict
{
    OrdersOrdersModel *instance = [[OrdersOrdersModel alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.currentPage = [[dict objectForKey:@"current_page"] doubleValue];
            self.recordCount = [self objectOrNilForKey:@"record_count" fromDictionary:dict];
            self.response = [self objectOrNilForKey:@"response" fromDictionary:dict];
            self.pageCount = [[dict objectForKey:@"page_count"] doubleValue];
    NSObject *receivedOrdersOrdersList = [dict objectForKey:@"orders_list"];
    NSMutableArray *parsedOrdersOrdersList = [NSMutableArray array];
    if ([receivedOrdersOrdersList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedOrdersOrdersList) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedOrdersOrdersList addObject:[OrdersOrdersList modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedOrdersOrdersList isKindOfClass:[NSDictionary class]]) {
       [parsedOrdersOrdersList addObject:[OrdersOrdersList modelObjectWithDictionary:(NSDictionary *)receivedOrdersOrdersList]];
    }

    self.ordersList = [NSArray arrayWithArray:parsedOrdersOrdersList];

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
NSMutableArray *tempArrayForOrdersList = [NSMutableArray array];
    for (NSObject *subArrayObject in self.ordersList) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForOrdersList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForOrdersList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForOrdersList] forKey:@"orders_list"];

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
    self.ordersList = [aDecoder decodeObjectForKey:@"ordersList"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_currentPage forKey:@"currentPage"];
    [aCoder encodeObject:_recordCount forKey:@"recordCount"];
    [aCoder encodeObject:_response forKey:@"response"];
    [aCoder encodeDouble:_pageCount forKey:@"pageCount"];
    [aCoder encodeObject:_ordersList forKey:@"ordersList"];
}

@end
