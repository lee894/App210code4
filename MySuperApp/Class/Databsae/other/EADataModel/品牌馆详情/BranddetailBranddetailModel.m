//
//  BranddetailBranddetailModel.m
//
//  Created by malan  on 14-4-16
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "BranddetailBranddetailModel.h"


NSString *const kBranddetailBranddetailModelBrandDetail = @"brand_detail";
NSString *const kBranddetailBranddetailModelResponse = @"response";


@interface BranddetailBranddetailModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BranddetailBranddetailModel

@synthesize brandDetail = _brandDetail;
@synthesize response = _response;
@synthesize requestTag;
@synthesize errorMessage;


+ (BranddetailBranddetailModel *)modelObjectWithDictionary:(NSDictionary *)dict
{
    BranddetailBranddetailModel *instance = [[BranddetailBranddetailModel alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
    NSObject *receivedBranddetailBrandDetail = [dict objectForKey:kBranddetailBranddetailModelBrandDetail];
    NSMutableArray *parsedBranddetailBrandDetail = [NSMutableArray array];
    if ([receivedBranddetailBrandDetail isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedBranddetailBrandDetail) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedBranddetailBrandDetail addObject:[BranddetailBrandDetail modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedBranddetailBrandDetail isKindOfClass:[NSDictionary class]]) {
       [parsedBranddetailBrandDetail addObject:[BranddetailBrandDetail modelObjectWithDictionary:(NSDictionary *)receivedBranddetailBrandDetail]];
    }

    self.brandDetail = [NSArray arrayWithArray:parsedBranddetailBrandDetail];
            self.response = [self objectOrNilForKey:kBranddetailBranddetailModelResponse fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
NSMutableArray *tempArrayForBrandDetail = [NSMutableArray array];
    for (NSObject *subArrayObject in self.brandDetail) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForBrandDetail addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForBrandDetail addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForBrandDetail] forKey:@"kBranddetailBranddetailModelBrandDetail"];
    [mutableDict setValue:self.response forKey:kBranddetailBranddetailModelResponse];

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

    self.brandDetail = [aDecoder decodeObjectForKey:kBranddetailBranddetailModelBrandDetail];
    self.response = [aDecoder decodeObjectForKey:kBranddetailBranddetailModelResponse];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_brandDetail forKey:kBranddetailBranddetailModelBrandDetail];
    [aCoder encodeObject:_response forKey:kBranddetailBranddetailModelResponse];
}


@end
