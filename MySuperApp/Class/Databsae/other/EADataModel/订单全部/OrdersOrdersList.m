//
//  OrdersOrdersList.m
//
//  Created by malan  on 14-4-19
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "OrdersOrdersList.h"
#import "YKProductsItem.h"

@interface OrdersOrdersList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation OrdersOrdersList

@synthesize status = _status;
@synthesize commentFlag = _commentFlag;
@synthesize expressid = _expressid;
@synthesize time = _time;
@synthesize price = _price;
@synthesize orderid = _orderid;
@synthesize expresscorn = _expresscorn;
@synthesize name = _name;

//lee999 新增属性
@synthesize order_status = _order_status;
@synthesize order_pic = _order_pic;
@synthesize goodscount = _goodscount;
@synthesize pay_status = _pay_status;
@synthesize delivery_type = _delivery_type;
//end


+ (OrdersOrdersList *)modelObjectWithDictionary:(NSDictionary *)dict
{
    OrdersOrdersList *instance = [[OrdersOrdersList alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.status = [self objectOrNilForKey:@"status" fromDictionary:dict];
            self.commentFlag = [self objectOrNilForKey:@"comment_flag" fromDictionary:dict];
            self.expressid = [self objectOrNilForKey:@"expressid" fromDictionary:dict];
            self.time = [self objectOrNilForKey:@"time" fromDictionary:dict];
            self.price = [self objectOrNilForKey:@"price" fromDictionary:dict];
            self.orderid = [self objectOrNilForKey:@"orderid" fromDictionary:dict];
            self.expresscorn = [self objectOrNilForKey:@"expresscorn" fromDictionary:dict];
            self.name = [self objectOrNilForKey:@"name" fromDictionary:dict];
        
        //lee999
        self.order_status = [self objectOrNilForKey:@"order_status" fromDictionary:dict];
        self.order_pic = [self objectOrNilForKey:@"pic" fromDictionary:dict];
        self.goodscount = [NSString stringWithFormat:@"%d",[[self objectOrNilForKey:@"goodscount" fromDictionary:dict] intValue]];
        self.pay_status = [self objectOrNilForKey:@"pay_status" fromDictionary:dict];
        self.delivery_type = [self objectOrNilForKey:@"delivery_type" fromDictionary:dict];

        _itemAllowpaytype = [[NSMutableArray alloc] init];
        if(self && [dict isKindOfClass:[NSDictionary class]]) {
            if (![[dict objectForKey:@"allowpaywaytype"] isKindOfClass:[NSNull class]]) {
                for (id dicdate2 in [dict objectForKey:@"allowpaywaytype"]) {
                    YKAllowPayType * item2 = [[YKAllowPayType alloc] init];
                    item2.payid =[[dicdate2 objectForKey:@"id"] intValue];
                    item2.paytypeDesc =[dicdate2 objectForKey:@"desc"];
                    [self.itemAllowpaytype addObject:item2];
                }
            }
        }
        
        //end
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.status forKey:@"status"];
    [mutableDict setValue:self.commentFlag forKey:@"comment_flag"];
    [mutableDict setValue:self.expressid forKey:@"expressid"];
    [mutableDict setValue:self.time forKey:@"time"];
    [mutableDict setValue:self.price forKey:@"price"];
    [mutableDict setValue:self.orderid forKey:@"orderid"];
    [mutableDict setValue:self.expresscorn forKey:@"expresscorn"];
    [mutableDict setValue:self.name forKey:@"name"];
    
    //lee999
    [mutableDict setValue:self.order_status forKey:@"order_status"];
    [mutableDict setValue:self.order_pic forKey:@"pic"];
    [mutableDict setValue:self.goodscount forKey:@"goodscount"];
    [mutableDict setValue:self.pay_status forKey:@"pay_status"];
    [mutableDict setValue:self.delivery_type forKey:@"delivery_type"];

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

    self.status = [aDecoder decodeObjectForKey:@"status"];
    self.commentFlag = [aDecoder decodeObjectForKey:@"commentFlag"];
    self.expressid = [aDecoder decodeObjectForKey:@"expressid"];
    self.time = [aDecoder decodeObjectForKey:@"time"];
    self.price = [aDecoder decodeObjectForKey:@"price"];
    self.orderid = [aDecoder decodeObjectForKey:@"orderid"];
    self.expresscorn = [aDecoder decodeObjectForKey:@"expresscorn"];
    self.name = [aDecoder decodeObjectForKey:@"name"];
    
    //lee999
    self.order_status = [aDecoder decodeObjectForKey:@"order_status"];
    self.order_pic = [aDecoder decodeObjectForKey:@"pic"];
    self.goodscount = [aDecoder decodeObjectForKey:@"goodscount"];
    self.pay_status = [aDecoder decodeObjectForKey:@"pay_status"];
    self.delivery_type = [aDecoder decodeObjectForKey:@"delivery_type"];

    //end
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_status forKey:@"status"];
    [aCoder encodeObject:_commentFlag forKey:@"commentFlag"];
    [aCoder encodeObject:_expressid forKey:@"expressid"];
    [aCoder encodeObject:_time forKey:@"time"];
    [aCoder encodeObject:_price forKey:@"price"];
    [aCoder encodeObject:_orderid forKey:@"orderid"];
    [aCoder encodeObject:_expresscorn forKey:@"expresscorn"];
    [aCoder encodeObject:_name forKey:@"name"];
    
    //lee999
    [aCoder encodeObject:_order_status forKey:@"order_status"];
    [aCoder encodeObject:_order_pic forKey:@"pic"];
    [aCoder encodeObject:_goodscount forKey:@"goodscount"];
    [aCoder encodeObject:_pay_status forKey:@"pay_status"];
    [aCoder encodeObject:_delivery_type forKey:@"delivery_type"];

    //end
}

@end



