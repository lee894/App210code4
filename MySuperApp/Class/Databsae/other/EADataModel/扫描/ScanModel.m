//
//  ScanModel.m
//  MySuperApp
//
//  Created by bonan on 14-4-12.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "ScanModel.h"

@interface  ScanModel()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ScanModel

@synthesize goodsId = _goodsId;
@synthesize response = _response;

@synthesize requestTag;
@synthesize errorMessage;


+ (ScanModel *)modelObjectWithDictionary:(NSDictionary *)dict
{
    ScanModel *instance = [[ScanModel alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        self.goodsId = [self objectOrNilForKey:@"goodsId" fromDictionary:dict];
        self.response = [self objectOrNilForKey:@"response" fromDictionary:dict];
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.goodsId forKey:@"goodsId"];
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
    
    self.goodsId = [aDecoder decodeObjectForKey:@"goodsId"];
    self.response = [aDecoder decodeObjectForKey:@"response"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:_goodsId forKey:@"goodsId"];
    [aCoder encodeObject:_response forKey:@"response"];
}



@end