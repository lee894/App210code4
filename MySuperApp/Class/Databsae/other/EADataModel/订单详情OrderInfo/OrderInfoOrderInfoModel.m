//
//  OrderInfoOrderInfoModel.m
//
//  Created by malan  on 14-4-19
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "OrderInfoOrderInfoModel.h"
#import "YKProductsItem.h"
#import "YKItem.h"

@interface OrderInfoOrderInfoModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation OrderInfoOrderInfoModel

@synthesize iscancle = _iscancle;
@synthesize orderdetailInfo = _orderdetailInfo;
@synthesize ispay = _ispay;
@synthesize orderdetailReceiveinfo = _orderdetailReceiveinfo;
@synthesize response = _response;

@synthesize requestTag;
@synthesize errorMessage;


@synthesize isshowpaybar = _isshowpaybar;

+ (OrderInfoOrderInfoModel *)modelObjectWithDictionary:(NSDictionary *)dict
{
    OrderInfoOrderInfoModel *instance = [[OrderInfoOrderInfoModel alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    _itemList = [[NSMutableArray alloc] init];
    _itemSuit = [[NSMutableArray alloc] init];
//    _itemPackage = [[NSMutableArray alloc] init];
    
    //lee999 新增支付方式
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
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        //套装信息
        for (id dicdate in [dict objectForKey:@"suitlist"]) {
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
                //lee999recode这个字段弃用了，会导致崩溃
//                product.rate_flag = [[aSuit objectForKey:@"rate_flag"]boolValue];
                product.goodsid = [aSuit objectForKey:@"goods_id"];
                [item.suits addObject:product];

            }
//            item.goodsid   = [itemDic objectForKey:@"goods_id"];

            item.disountprice =[[dicdate objectForKey:@"discountprice"] floatValue];
            item.price = [[dicdate objectForKey:@"price"] floatValue];
            item.save = [[dicdate objectForKey:@"save"] floatValue];
            item.number = [[dicdate objectForKey:@"number"] intValue];
            item.suitid = [dicdate objectForKey:@"suitid"];
            item.name = [dicdate objectForKey:@"name"];
            [self.itemSuit addObject:item];

        }
    }
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        //礼包信息
        for (id dicdate in [dict objectForKey:@"packagelist"]) {
            YKSuitListItem * item = [[YKSuitListItem alloc] init];
            for (id aSuit in [dicdate objectForKey:@"package"]) {
                YKProductsItem *product=[[YKProductsItem alloc] init];
                product.package_id = [aSuit objectForKey:@"package_id"];
                product.product_id = [aSuit objectForKey:@"product_id"];
                product.name = [aSuit objectForKey:@"name"];
                product.pic = [aSuit objectForKey:@"pic"];
                product.mkt_price = [[aSuit objectForKey:@"mkt_price"] floatValue];
                product.price = [[aSuit objectForKey:@"price"] floatValue];
                product.size = [aSuit objectForKey:@"size"];
                product.color = [aSuit objectForKey:@"color"];
                //lee999recode这个字段弃用了，会导致崩溃
                //                product.rate_flag = [[aSuit objectForKey:@"rate_flag"]boolValue];
                product.goodsid = [aSuit objectForKey:@"goods_id"];
                [item.suits addObject:product];
                
            }
            //            item.goodsid   = [itemDic objectForKey:@"goods_id"];
            
            item.disountprice =[[dicdate objectForKey:@"discountprice"] floatValue];
            item.price = [[dicdate objectForKey:@"price"] floatValue];
            item.save = [[dicdate objectForKey:@"save"] floatValue];
            item.number = [[dicdate objectForKey:@"number"] intValue];
            item.packageid = [dicdate objectForKey:@"package_id"];
            item.name = [dicdate objectForKey:@"name"];
            [self.itemSuit addObject:item];
        }
        self.iscancle = [[dict objectForKey:@"iscancle"] boolValue];
        self.orderdetailInfo = [OrderInfoOrderdetailInfo modelObjectWithDictionary:[dict objectForKey:@"orderdetail_info"]];
        
        NSDictionary * productlistDic = [dict objectForKey:@"orderdetail_productlist"];
        if ([productlistDic count] > 0) {
            NSArray * keyArray = [productlistDic allKeys];
            for (int i = 0; i < [keyArray count]; i ++) {
                NSDictionary * itemDic = [productlistDic objectForKey:[keyArray objectAtIndex:i]];
                YKItem * item   = [[YKItem alloc] init];
                //lee999recode这个字段弃用了，会导致崩溃
//                item.rate_flag = [[itemDic objectForKey:@"rate_flag"] boolValue];
                item.color      = [itemDic objectForKey:@"color"];
                item.size       = [itemDic objectForKey:@"size"];
                item.productid  = [itemDic objectForKey:@"productid"];
                item.name       = [itemDic objectForKey:@"name"];
                item.price      = [itemDic objectForKey:@"price"];
                item.imgurl     = [itemDic objectForKey:@"imgurl"];
                item.number     = [NSString stringWithFormat:@"%@", [itemDic objectForKey:@"number"]];
                item.goodsid   = [itemDic objectForKey:@"goods_id"];
                [self.itemList addObject:item];
            }
        }
            self.ispay = [[dict objectForKey:@"ispay"] boolValue];
        
        //lee999
        self.isshowpaybar = [[dict objectForKey:@"isshowpaybar"] boolValue];
        //end
        
            self.orderdetailReceiveinfo = [OrderInfoOrderdetailReceiveinfo modelObjectWithDictionary:[dict objectForKey:@"orderdetail_receiveinfo"]];
            self.response = [self objectOrNilForKey:@"response" fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
NSMutableArray *tempArrayForSuitlist = [NSMutableArray array];
    for (NSObject *subArrayObject in self.itemSuit) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForSuitlist addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForSuitlist addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForSuitlist] forKey:@"suitlist"];
    [mutableDict setValue:[NSNumber numberWithBool:self.iscancle] forKey:@"iscancle"];
    [mutableDict setValue:[self.orderdetailInfo dictionaryRepresentation] forKey:@"orderdetail_info"];
    [mutableDict setValue:[NSNumber numberWithBool:self.ispay] forKey:@"ispay"];
    [mutableDict setValue:[self.orderdetailReceiveinfo dictionaryRepresentation] forKey:@"orderdetail_receiveinfo"];
    [mutableDict setValue:self.response forKey:@"response"];
    
    //lee999
    [mutableDict setValue:[NSNumber numberWithBool:self.isshowpaybar] forKey:@"isshowpaybar"];
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

    self.itemSuit = [aDecoder decodeObjectForKey:@"suitlist"];
    self.iscancle = [aDecoder decodeBoolForKey:@"iscancle"];
    self.orderdetailInfo = [aDecoder decodeObjectForKey:@"orderdetailInfo"];
    self.ispay = [aDecoder decodeBoolForKey:@"ispay"];
    self.orderdetailReceiveinfo = [aDecoder decodeObjectForKey:@"orderdetailReceiveinfo"];
    self.response = [aDecoder decodeObjectForKey:@"response"];
    
    //lee999
    self.isshowpaybar = [aDecoder decodeBoolForKey:@"isshowpaybar"];
    //end
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_itemSuit forKey:@"suitlist"];
    [aCoder encodeBool:_iscancle forKey:@"iscancle"];
    [aCoder encodeObject:_orderdetailInfo forKey:@"orderdetailInfo"];
    [aCoder encodeBool:_ispay forKey:@"ispay"];
    [aCoder encodeObject:_orderdetailReceiveinfo forKey:@"orderdetailReceiveinfo"];
    [aCoder encodeObject:_response forKey:@"response"];
    
    //lee999
    [aCoder encodeBool:_isshowpaybar forKey:@"isshowpaybar"];
    //end
}



@end
