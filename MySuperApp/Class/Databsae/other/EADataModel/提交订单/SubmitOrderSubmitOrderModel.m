//
//  SubmitOrderSubmitOrderModel.m
//
//  Created by malan  on 14-4-4
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "SubmitOrderSubmitOrderModel.h"



@interface SubmitOrderSubmitOrderModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SubmitOrderSubmitOrderModel

@synthesize ispay = _ispay;
@synthesize payway = _payway;
@synthesize response = _response;
@synthesize submitorder = _submitorder;
@synthesize orderid = _orderid;
@synthesize tf_tradeNo = _tf_tradeNo;


@synthesize requestTag;
@synthesize errorMessage;


+ (SubmitOrderSubmitOrderModel *)modelObjectWithDictionary:(NSDictionary *)dict
{
    SubmitOrderSubmitOrderModel *instance = [[SubmitOrderSubmitOrderModel alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.ispay = [[dict objectForKey:@"ispay"] boolValue];
            self.payway = [self objectOrNilForKey:@"payway" fromDictionary:dict];
            self.response = [self objectOrNilForKey:@"response" fromDictionary:dict];
            self.submitorder = [SubmitOrderSubmitorder modelObjectWithDictionary:[dict objectForKey:@"submitorder"]];
            self.orderid = [self objectOrNilForKey:@"orderid" fromDictionary:dict];
            self.key = [self objectOrNilForKey:@"key" fromDictionary:dict];
            self.tf_tradeNo = [self objectOrNilForKey:@"tradno" fromDictionary:dict];
            self.zunxiang = [[self objectOrNilForKey:@"zunxiang" fromDictionary:dict]boolValue];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithBool:self.ispay] forKey:@"ispay"];
    [mutableDict setValue:self.payway forKey:@"payway"];
    [mutableDict setValue:self.response forKey:@"response"];
    [mutableDict setValue:[self.submitorder dictionaryRepresentation] forKey:@"submitorder"];
    [mutableDict setValue:self.orderid forKey:@"orderid"];
    [mutableDict setValue:self.key forKey:@"key"];
    [mutableDict setValue:self.tf_tradeNo forKey:@"tradno"];

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

    self.ispay = [aDecoder decodeBoolForKey:@"ispay"];
    self.payway = [aDecoder decodeObjectForKey:@"payway"];
    self.response = [aDecoder decodeObjectForKey:@"response"];
    self.submitorder = [aDecoder decodeObjectForKey:@"submitorder"];
    self.orderid = [aDecoder decodeObjectForKey:@"orderid"];
    self.key = [aDecoder decodeObjectForKey:@"key"];

    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeBool:_ispay forKey:@"ispay"];
    [aCoder encodeObject:_payway forKey:@"payway"];
    [aCoder encodeObject:_response forKey:@"response"];
    [aCoder encodeObject:_submitorder forKey:@"submitorder"];
    [aCoder encodeObject:_orderid forKey:@"orderid"];
    [aCoder encodeObject:_key forKey:@"key"];

}

@end
