//
//  AddressAddressLIstModel.m
//
//  Created by malan  on 14-4-15
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "AddressAddressLIstModel.h"




@interface AddressAddressLIstModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation AddressAdd

@synthesize response = _response;
@synthesize requestTag;
@synthesize errorMessage;


+ (AddressAdd *)modelObjectWithDictionary:(NSDictionary *)dict
{
    AddressAdd *instance = [[AddressAdd alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        self.response = [self objectOrNilForKey:@"response" fromDictionary:dict];

    }
    return self;
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}

@end

@implementation AddressAddressLIstModel

@synthesize currentPage = _currentPage;
@synthesize addresslist = _addresslist;
@synthesize recordCount = _recordCount;
@synthesize response = _response;
@synthesize pageCount = _pageCount;

@synthesize requestTag;
@synthesize errorMessage;


+ (AddressAddressLIstModel *)modelObjectWithDictionary:(NSDictionary *)dict
{
    AddressAddressLIstModel *instance = [[AddressAddressLIstModel alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.currentPage = [[dict objectForKey:@"current_page"] doubleValue];
    NSObject *receivedAddressAddresslist = [dict objectForKey:@"addresslist"];
    NSMutableArray *parsedAddressAddresslist = [NSMutableArray array];
    if ([receivedAddressAddresslist isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedAddressAddresslist) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedAddressAddresslist addObject:[AddressAddresslist modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedAddressAddresslist isKindOfClass:[NSDictionary class]]) {
       [parsedAddressAddresslist addObject:[AddressAddresslist modelObjectWithDictionary:(NSDictionary *)receivedAddressAddresslist]];
    }

    self.addresslist = [NSMutableArray arrayWithArray:parsedAddressAddresslist];
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
NSMutableArray *tempArrayForAddresslist = [NSMutableArray array];
    for (NSObject *subArrayObject in self.addresslist) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForAddresslist addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForAddresslist addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForAddresslist] forKey:@"addresslist"];
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
    self.addresslist = [aDecoder decodeObjectForKey:@"addresslist"];
    self.recordCount = [aDecoder decodeObjectForKey:@"recordCount"];
    self.response = [aDecoder decodeObjectForKey:@"response"];
    self.pageCount = [aDecoder decodeDoubleForKey:@"pageCount"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_currentPage forKey:@"currentPage"];
    [aCoder encodeObject:_addresslist forKey:@"addresslist"];
    [aCoder encodeObject:_recordCount forKey:@"recordCount"];
    [aCoder encodeObject:_response forKey:@"response"];
    [aCoder encodeDouble:_pageCount forKey:@"pageCount"];
}

@end
