
//
//  COCheckOutModel.m
//
//  Created by malan  on 14-4-7
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "COCheckOutModel.h"



@interface COCheckOutModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation COCheckOutModel

@synthesize suitlist = _suitlist;
@synthesize packagelist = _packagelist;
@synthesize checkoutStatistics = _checkoutStatistics;
@synthesize checkoutPaywayNew = _checkoutPaywayNew;
@synthesize checkoutCouponcard = _checkoutCouponcard;
@synthesize checkout_usev6cards = _checkout_usev6cards;
@synthesize checkout_usecouponcard = _checkout_usecouponcard;
@synthesize checkout_usev6cardsres = _checkout_usev6cardsres;
@synthesize response = _response;
@synthesize promotions = _promotions;
@synthesize checkoutConsigneeinfo = _checkoutConsigneeinfo;
@synthesize checkoutProductlist = _checkoutProductlist;
@synthesize checkoutV6cards = _checkoutV6cards;
@synthesize checkoutCountv6 = _checkoutCountv6;
@synthesize arrCheckout_couponcard =_arrCheckout_couponcard;
@synthesize checkout_freepostcard = _checkout_freepostcard;

@synthesize checkout_usefreepost = _checkout_usefreepost;


@synthesize requestTag;
@synthesize errorMessage;


+ (COCheckOutModel *)modelObjectWithDictionary:(NSDictionary *)dict
{
    COCheckOutModel *instance = [[COCheckOutModel alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)json
{
    self = [super init];
    
    if(self && [json isKindOfClass:[NSDictionary class]]) {

        _checkout_usecouponcard = [self objectOrNilForKey:@"checkout_usecouponcard" fromDictionary:json];
        _checkout_usev6cards = [self objectOrNilForKey:@"checkout_usev6cards" fromDictionary:json];
        //使用v6card
        _checkout_usev6cardsres = [self objectOrNilForKey:@"checkout_usev6cardsres" fromDictionary:json];
        //使用包邮卡
        _checkout_freepostcard = [self objectOrNilForKey:@"checkout_usefreepost" fromDictionary:json];
        
        self.checkout_score = [[self objectOrNilForKey:@"checkout_score" fromDictionary:json] intValue];
        
        _checkoutProductlist = [[NSMutableArray alloc] init] ;
        _suitlist = [[NSMutableArray alloc] init] ;
        _packagelist = [[NSMutableArray alloc] init];
        _checkoutCouponcard = [[NSMutableArray alloc] init] ;
        _checkoutConsigneeinfo = [[NSMutableArray alloc] init] ;
        _checkoutPaywayNew = [[NSMutableArray alloc] init] ;
        self.checkoutV6cards = [self objectOrNilForKey:@"checkout_v6cards" fromDictionary:json];
        self.checkoutCountv6 = [[self objectOrNilForKey:@"checkout_countv6" fromDictionary:json] intValue];
        self.arrCheckout_couponcard = [self objectOrNilForKey:@"checkout_couponcard" fromDictionary:json];
        
        self.checkout_freepostcard = [self objectOrNilForKey:@"checkout_freepostcard" fromDictionary:json];
        
        
        NSArray* array = [json objectForKey:@"checkout_productlist"];
        for (int i = 0; i < [array count]; i++) {
            NSDictionary* dic = (NSDictionary*)[array objectAtIndex:i];
            YKItem* item = [[YKItem alloc] init];
            item.productid = [dic objectForKey:@"productid"];
            item.type = [dic objectForKey:@"type"];
            item.name = [dic objectForKey:@"name"];
            item.number = [dic objectForKey:@"number"];
            item.price = [NSString stringWithFormat:@"%@",[dic objectForKey:@"price"]];
            item.subtotal = [dic objectForKey:@"subtotal"];
            item.color = [dic objectForKey:@"color"];
            item.size = [dic objectForKey:@"size"];
            item.imgurl = [dic objectForKey:@"imgurl"];
            item.bn = [dic objectForKey:@"bn"];
            item.score = [[dic objectForKey:@"score"] intValue];
            [self.checkoutProductlist addObject:item];

        }
        
        NSArray* array1 = [json objectForKey:@"checkout_consigneeinfo"];
        for (int i = 0; i < [array1 count]; i ++) {
            YKAdressItem* addressItem = [[YKAdressItem alloc] init];
            NSDictionary* dic = (NSDictionary*)[array1 objectAtIndex:i];
            addressItem.addressId = [dic objectForKey:@"id"];
            addressItem.user_name = [dic objectForKey:@"user_name"];
            addressItem.address = [dic objectForKey:@"address"];
            addressItem.zip_code = [dic objectForKey:@"zip_code"];
            addressItem.phone = [dic objectForKey:@"phone"];
            addressItem.mobile = [dic objectForKey:@"mobile"];
            addressItem.email = [dic objectForKey:@"email"];
            addressItem.default_flag = [dic objectForKey:@"default_flag"];
            addressItem.province = [dic objectForKey:@"province"];
            addressItem.city = [dic objectForKey:@"city"];
            addressItem.county = [dic objectForKey:@"county"];
            [self.checkoutConsigneeinfo addObject:addressItem];

        }
        
        id array2 = [json objectForKey:@"checkout_couponcard"];
        if ([array2 isKindOfClass:[NSArray class]]) {
            for (int i = 0; i < [array2 count]; i ++) {
                YKCouponcardItem* item = [[YKCouponcardItem alloc] init];
                NSDictionary* dic = (NSDictionary*)[array2 objectAtIndex:i];
                item.code = [dic objectForKey:@"code"];
                item.desc = [dic objectForKey:@"desc"];
                item.title = [dic objectForKey:@"title"];
                [self.checkoutCouponcard addObject:item];
            }
        }
    
        
        for (id dicdate in [json objectForKey:@"suitlist"]) {
            YKSuitListItem * item = [[YKSuitListItem alloc] init];
            for (id aSuit in [dicdate objectForKey:@"suit"]) {
                YKProductsItem *product=[[YKProductsItem alloc] init];
                product.product_id = [aSuit objectForKey:@"product_id"];
                product.name = [aSuit objectForKey:@"name"];
                product.pic = [aSuit objectForKey:@"pic"];
                product.mkt_price = [[aSuit objectForKey:@"mkt_price"] floatValue];
                product.price = [[aSuit objectForKey:@"price"] floatValue];
                product.size = [aSuit objectForKey:@"size"];
                product.color = [aSuit objectForKey:@"color"];
                [item.suits addObject:product];
            }
            item.disountprice =[[dicdate objectForKey:@"discountprice"] floatValue];
            item.price = [[dicdate objectForKey:@"price"] floatValue];
            item.save = [[dicdate objectForKey:@"save"] floatValue];
            item.number = [[dicdate objectForKey:@"number"] intValue];
            item.suitid = [dicdate objectForKey:@"suitid"];
            //lee999 新增套装积分
            item.suit_score = [[dicdate objectForKey:@"suit_score"] intValue];
            NSLog(@"arrSuit:%@",item);
            [self.suitlist addObject:item];
        }
        
        
        //lee999 150628 新增礼包
        for (id dicdate in [json objectForKey:@"packagelist"]) {
            YKSuitListItem * item = [[YKSuitListItem alloc] init];
            for (id aSuit in [dicdate objectForKey:@"package"]) {
                YKProductsItem *product=[[YKProductsItem alloc] init];
                product.product_id = [aSuit objectForKey:@"product_id"];
                product.name = [aSuit objectForKey:@"name"];
                product.Count = [aSuit objectForKey:@"count"];
                product.pic = [aSuit objectForKey:@"pic"];
                product.mkt_price = [[aSuit objectForKey:@"mkt_price"] floatValue];
                product.price = [[aSuit objectForKey:@"price"] floatValue];
                product.size = [aSuit objectForKey:@"size"];
                product.color = [aSuit objectForKey:@"color"];
                product.stock = [aSuit objectForKey:@"stock"];
                [item.suits addObject:product];
                
            }
            item.disountprice =[[dicdate objectForKey:@"discountprice"] floatValue];
            item.price = [[dicdate objectForKey:@"price"] floatValue];
            item.save = [[dicdate objectForKey:@"save"] floatValue];
            item.packageid = [dicdate objectForKey:@"packageid"];
            item.selected = [[dicdate objectForKey:@"selected"] boolValue];
            item.uk = [dicdate objectForKey:@"uk"];
            NSLog(@"arrSuit:%@",item);
            [self.packagelist addObject:item];
            
        }
        
        
        NSDictionary* dic = [json objectForKey:@"checkout_statistics"];
        NSDictionary* price1 = [dic objectForKey:@"price1"];
        NSDictionary* price2 = [dic objectForKey:@"price2"];
        NSDictionary* price3 = [dic objectForKey:@"price3"];
        NSDictionary* price4 = [dic objectForKey:@"price4"];
        NSDictionary* price5 = [dic objectForKey:@"price5"];
        NSDictionary *price6 = [dic objectForKey:@"price6"];
        self.itemPrice = [price1 objectForKey:@"value"];
        self.carriagePrice = [price2 objectForKey:@"value"];
        self.voucherPrice = [price3 objectForKey:@"value"];
        self.orderPrice = [price4 objectForKey:@"value"];
        self.preferentialPrice = [price5 objectForKey:@"value"];
        self.zuxiangPrice = [price6 objectForKey:@"value"];
        //支付方式
        NSArray * aArr = [json objectForKey:@"checkout_payway_new"];
        for (NSDictionary * aD in aArr) {
            NSDictionary * a = [[NSDictionary alloc] initWithDictionary:aD];
            [self.checkoutPaywayNew addObject:a];
        }
    }
    return self;
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForSuitlist = [NSMutableArray array];
    for (NSObject *subArrayObject in self.suitlist) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForSuitlist addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForSuitlist addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForSuitlist] forKey:@"suitlist"];

    
    //lee999 150626 新增礼包
    NSMutableArray *tempArrayForSuitlist2 = [NSMutableArray array];
    for (NSObject *subArrayObject in self.packagelist) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            [tempArrayForSuitlist2 addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            [tempArrayForSuitlist2 addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForSuitlist2] forKey:@"packagelist"];
    //end
    
    
    NSMutableArray *tempArrayForCheckoutPaywayNew = [NSMutableArray array];
    for (NSObject *subArrayObject in self.checkoutPaywayNew) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForCheckoutPaywayNew addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForCheckoutPaywayNew addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForCheckoutPaywayNew] forKey:@"checkout_payway_new"];
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
    [mutableDict setValue:self.response forKey:@"response"];
    [mutableDict setValue:[self.promotions dictionaryRepresentation] forKey:@"promotions"];
    NSMutableArray *tempArrayForCheckoutConsigneeinfo = [NSMutableArray array];
    for (NSObject *subArrayObject in self.checkoutConsigneeinfo) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForCheckoutConsigneeinfo addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForCheckoutConsigneeinfo addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForCheckoutConsigneeinfo] forKey:@"checkout_consigneeinfo"];
    NSMutableArray *tempArrayForCheckoutProductlist = [NSMutableArray array];
    for (NSObject *subArrayObject in self.checkoutProductlist) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForCheckoutProductlist addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForCheckoutProductlist addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForCheckoutProductlist] forKey:@"checkout_productlist"];
    
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
    
    self.suitlist = [aDecoder decodeObjectForKey:@"suitlist"];
    self.packagelist = [aDecoder decodeObjectForKey:@"packagelist"];

    self.checkoutStatistics = [aDecoder decodeObjectForKey:@"checkoutStatistics"];
    self.checkoutPaywayNew = [aDecoder decodeObjectForKey:@"checkoutPaywayNew"];
    self.checkoutCouponcard = [aDecoder decodeObjectForKey:@"checkoutCouponcard"];
    self.response = [aDecoder decodeObjectForKey:@"response"];
    self.promotions = [aDecoder decodeObjectForKey:@"promotions"];
    self.checkoutConsigneeinfo = [aDecoder decodeObjectForKey:@"checkoutConsigneeinfo"];
    self.checkoutProductlist = [aDecoder decodeObjectForKey:@"checkoutProductlist"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:_suitlist forKey:@"suitlist"];
    [aCoder encodeObject:_packagelist forKey:@"packagelist"];

    [aCoder encodeObject:_checkoutStatistics forKey:@"checkoutStatistics"];
    [aCoder encodeObject:_checkoutPaywayNew forKey:@"checkoutPaywayNew"];
    [aCoder encodeObject:_checkoutCouponcard forKey:@"checkoutCouponcard"];
    [aCoder encodeObject:_response forKey:@"response"];
    [aCoder encodeObject:_promotions forKey:@"promotions"];
    [aCoder encodeObject:_checkoutConsigneeinfo forKey:@"checkoutConsigneeinfo"];
    [aCoder encodeObject:_checkoutProductlist forKey:@"checkoutProductlist"];
}

@end
