//
//  OrderInfoOrderdetailInfo.m
//
//  Created by malan  on 14-4-19
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "OrderInfoOrderdetailInfo.h"


@interface OrderInfoOrderdetailInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation OrderInfoOrderdetailInfo

@synthesize deliveryPrice = _deliveryPrice;
@synthesize discountdes = _discountdes;
@synthesize sendtime = _sendtime;
@synthesize discountprice = _discountprice;
@synthesize freight = _freight;
@synthesize payway = _payway;
@synthesize price = _price;
@synthesize ordertime = _ordertime;
@synthesize expressid = _expressid;
@synthesize remarskmsg = _remarskmsg;
@synthesize expresscorn = _expresscorn;
@synthesize status = _status;
@synthesize deliveryType = _deliveryType;
@synthesize tf_tradeNo = _tf_tradeNo;

//lee999
@synthesize co_score = _co_score;
@synthesize co_price = _co_price;
//end

+ (OrderInfoOrderdetailInfo *)modelObjectWithDictionary:(NSDictionary *)dict
{
    OrderInfoOrderdetailInfo *instance = [[OrderInfoOrderdetailInfo alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.deliveryPrice = [self objectOrNilForKey:@"delivery_price" fromDictionary:dict];
            self.discountdes = [self objectOrNilForKey:@"discountdes" fromDictionary:dict];
            self.sendtime = [[dict objectForKey:@"sendtime"] boolValue];
            self.discountprice = [self objectOrNilForKey:@"discountprice" fromDictionary:dict];
            self.freight = [self objectOrNilForKey:@"freight" fromDictionary:dict];
            self.payway = [self objectOrNilForKey:@"payway" fromDictionary:dict];
            self.price = [self objectOrNilForKey:@"price" fromDictionary:dict];
            self.ordertime = [self objectOrNilForKey:@"ordertime" fromDictionary:dict];
            self.expressid = [self objectOrNilForKey:@"expressid" fromDictionary:dict];
            self.comment_flag = [[dict objectForKey:@"comment_flag"] boolValue];
            self.remarskmsg = [self objectOrNilForKey:@"remarskmsg" fromDictionary:dict];
            self.expresscorn = [self objectOrNilForKey:@"expresscorn" fromDictionary:dict];
            self.status = [self objectOrNilForKey:@"status" fromDictionary:dict];
        self.eticket = [self objectOrNilForKey:@"eticket" fromDictionary:dict];
            self.deliveryType = [self objectOrNilForKey:@"delivery_type" fromDictionary:dict];
        self.tf_tradeNo = [self objectOrNilForKey:@"tf_tradeNo" fromDictionary:dict];
        
        //lee999
        self.co_score = [self objectOrNilForKey:@"co_score" fromDictionary:dict];
        self.co_price = [self objectOrNilForKey:@"co_price" fromDictionary:dict];
        self.orer_status = [self objectOrNilForKey:@"orer_status" fromDictionary:dict];

        //end
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.deliveryPrice forKey:@"delivery_price"];
    [mutableDict setValue:self.discountdes forKey:@"discountdes"];
    [mutableDict setValue:[NSNumber numberWithBool:self.sendtime] forKey:@"sendtime"];
    [mutableDict setValue:self.discountprice forKey:@"discountprice"];
    [mutableDict setValue:self.freight forKey:@"freight"];
    [mutableDict setValue:self.payway forKey:@"payway"];
    [mutableDict setValue:self.price forKey:@"price"];
    [mutableDict setValue:self.ordertime forKey:@"ordertime"];
    [mutableDict setValue:self.expressid forKey:@"expressid"];
    [mutableDict setValue:self.remarskmsg forKey:@"remarskmsg"];
    [mutableDict setValue:self.expresscorn forKey:@"expresscorn"];
    [mutableDict setValue:self.status forKey:@"status"];
    [mutableDict setValue:self.deliveryType forKey:@"delivery_type"];
    [mutableDict setValue:self.tf_tradeNo forKey:@"tf_tradeNo"];

    //lee999
    [mutableDict setValue:self.co_score forKey:@"co_score"];
    [mutableDict setValue:self.co_price forKey:@"co_price"];
    [mutableDict setValue:self.orer_status forKey:@"orer_status"];

    //end
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

    self.deliveryPrice = [aDecoder decodeObjectForKey:@"deliveryPrice"];
    self.discountdes = [aDecoder decodeObjectForKey:@"discountdes"];
    self.sendtime = [aDecoder decodeBoolForKey:@"sendtime"];
    self.discountprice = [aDecoder decodeObjectForKey:@"discountprice"];
    self.freight = [aDecoder decodeObjectForKey:@"freight"];
    self.payway = [aDecoder decodeObjectForKey:@"payway"];
    self.price = [aDecoder decodeObjectForKey:@"price"];
    self.ordertime = [aDecoder decodeObjectForKey:@"ordertime"];
    self.expressid = [aDecoder decodeObjectForKey:@"expressid"];
    self.remarskmsg = [aDecoder decodeObjectForKey:@"remarskmsg"];
    self.expresscorn = [aDecoder decodeObjectForKey:@"expresscorn"];
    self.status = [aDecoder decodeObjectForKey:@"status"];
    self.deliveryType = [aDecoder decodeObjectForKey:@"deliveryType"];
    
    //lee999
    self.co_score = [aDecoder decodeObjectForKey:@"co_score"];
    self.co_price = [aDecoder decodeObjectForKey:@"co_price"];
    self.orer_status = [aDecoder decodeObjectForKey:@"orer_status"];
    //end
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_deliveryPrice forKey:@"deliveryPrice"];
    [aCoder encodeObject:_discountdes forKey:@"discountdes"];
    [aCoder encodeBool:_sendtime forKey:@"sendtime"];
    [aCoder encodeObject:_discountprice forKey:@"discountprice"];
    [aCoder encodeObject:_freight forKey:@"freight"];
    [aCoder encodeObject:_payway forKey:@"payway"];
    [aCoder encodeObject:_price forKey:@"price"];
    [aCoder encodeObject:_ordertime forKey:@"ordertime"];
    [aCoder encodeObject:_expressid forKey:@"expressid"];
    [aCoder encodeObject:_remarskmsg forKey:@"remarskmsg"];
    [aCoder encodeObject:_expresscorn forKey:@"expresscorn"];
    [aCoder encodeObject:_status forKey:@"status"];
    [aCoder encodeObject:_deliveryType forKey:@"deliveryType"];
    
    //lee999
    [aCoder encodeObject:_co_score forKey:@"co_score"];
    [aCoder encodeObject:_co_price forKey:@"co_price"];
    [aCoder encodeObject:_orer_status forKey:@"orer_status"];
    //end
}

@end
