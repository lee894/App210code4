//
//  CarCarModel.m
//
//  Created by malan  on 14-4-8
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "CarCarModel.h"



@interface CarCarModel ()

@end

@implementation CarCarModel

@synthesize notice = _notice;
@synthesize showwarn = _showwarn;
@synthesize hotlist = _hotlist;
@synthesize warn = _warn;
@synthesize suitlist = _suitlist;
@synthesize carStatistics = _carStatistics;
@synthesize response = _response;
@synthesize carProductlist = _carProductlist;


@synthesize requestTag;
@synthesize errorMessage;


+ (CarCarModel *)modelObjectWithDictionary:(NSDictionary *)dict
{
    
    CarCarModel *instance = [[CarCarModel alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)json
{
    self = [super init];

    _carProductlist = [[NSMutableArray alloc] init];
    _gifts = [[NSMutableArray alloc] init];
    _suitlist = [[NSMutableArray alloc] init];
    _hotlist =  [[NSMutableArray alloc] init];
    _packagelist = [[NSMutableArray alloc] init];
    
    if(self && [json isKindOfClass:[NSDictionary class]]) {
        
        [self.carProductlist removeAllObjects];
        [self.hotlist removeAllObjects];
        [self.suitlist removeAllObjects];
        
        NSArray* array = [json objectForKey:@"car_productlist"];
        NSArray *array_num=[[json objectForKey:@"car_statistics"]componentsSeparatedByString:@"|"];
        NSArray *array_NUM=[[array_num objectAtIndex:0]componentsSeparatedByString:@":"];
        [[NSUserDefaults standardUserDefaults]setObject:[array_NUM objectAtIndex:1] forKey:@"totalNUM"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TotleNumber" object:nil];

        for (int i = 0; i < [array count]; i++) {
            NSDictionary* dic = (NSDictionary*)[array objectAtIndex:i];
            YKItem* item = [[YKItem alloc] init];
            item.productid = [dic objectForKey:@"productid"];
            item.goodsid = [dic objectForKey:@"goodsid"];
            item.type = [dic objectForKey:@"type"];
            item.imgurl = [dic objectForKey:@"imgurl"];
            item.name = [dic objectForKey:@"name"];
            item.number = [dic objectForKey:@"number"];
            item.price = [dic objectForKey:@"price"];
            item.count = [[dic objectForKey:@"count"] integerValue];
            item.subtotal = [dic objectForKey:@"subtotal"];
            item.color = [dic objectForKey:@"color"];
            item.size = [dic objectForKey:@"size"];
            item.stock = [dic objectForKey:@"stock"];
            item.isSollection = [dic objectForKey:@"isSollection"];
            item.uk = [dic objectForKey:@"uk"];
            item.selected = [[dic objectForKey:@"selected"] boolValue];
            item.is_valid = [[dic objectForKey:@"is_valid" isDictionary:nil] boolValue];
            [self.carProductlist addObject:item];
        }
        self.selectedItemCount = [json objectForKey:@"itemprice"];
        NSString* car_statistics = [json objectForKey:@"car_statistics"];
        NSArray* array1 = [car_statistics componentsSeparatedByString:@"|"];
        if (array1.count >= 1) {
            NSArray* numberArray = [[array1 objectAtIndex:0] componentsSeparatedByString:@":"];
            self.itemNumber = [numberArray objectAtIndex:1];
            NSArray* priceArray = [[array1 objectAtIndex:1] componentsSeparatedByString:@":"];
            self.itemPrice = [priceArray objectAtIndex:1];
        }
   
        //购物车气泡 lee999 新增显示购物车的气泡
        self.bubble_count = [json objectForKey:@"bubble_count"];

        
        //选择赠品
		
        [self.gifts removeAllObjects];
        
        //-------- 谢贤辉 begin------//
        //-------- 谢贤辉 end-------//
        NSArray* giftArray = [json objectForKey:@"select_gifts"];
        for (int i = 0; i < [giftArray count]; i ++) {
            NSMutableArray *sizeArray = [[NSMutableArray alloc] init];
            NSMutableArray *colorArray = [[NSMutableArray alloc] init];
            NSMutableArray *valueids = [[NSMutableArray alloc] init];
            
            NSDictionary* giftDic = (NSDictionary*)[giftArray objectAtIndex:i];
            NSArray* productArray = [giftDic objectForKey:@"products"];
            NSMutableArray *pro_array=[[NSMutableArray alloc]init];
            for (id pro in productArray) {
                if (![[pro objectForKey:@"count"]isEqualToNumber:[NSNumber numberWithInt:0]]) {
                    [pro_array addObject:pro];
                }
            }
            NSString *colorid=[[NSString alloc]init];
            NSString *sizeid=[[NSString alloc]init];
            id style=[[giftArray objectAtIndex:i] objectForKey:@"specs"];
            // NSLog(@"!!!!!!!!!!!@~~~~~~~~~~~~~~~~~~~%@",style);
            for (id key in style) {
                if ([[key objectForKey:@"type"]isEqualToString:@"img"]) {
                    colorid=[key objectForKey:@"id"];
                }
                if ([[key objectForKey:@"type"]isEqualToString:@"txt"]) {
                    sizeid=[key objectForKey:@"id"];
                }
            }
            for (int j = 0;j < [pro_array count]; j ++) {
                NSDictionary* productDic = (NSDictionary*)[pro_array objectAtIndex:j];
                YKItem* item = [[YKItem alloc] init];
                item.productid = [productDic objectForKey:@"id"];
                item.number = [productDic objectForKey:@"count"];
                NSDictionary* valueDic = [productDic objectForKey:@"_spec_value_ids"];
                item.color = [valueDic objectForKey:colorid];
                item.size = [valueDic objectForKey:sizeid];
                [valueids addObject:item];
            }
            NSMutableArray *array_product=[[NSMutableArray alloc]init];
            NSString *str_record=[[NSString alloc]init];
            if ([pro_array count]!=0) {
                str_record=[[[pro_array objectAtIndex:0] objectForKey:@"_spec_value_ids"] objectForKey:@"1"];
                [array_product addObject:[[[pro_array objectAtIndex:0] objectForKey:@"_spec_value_ids"] objectForKey:@"1"]];
            }
            for (int i=0; i<[pro_array count]; i++) {
                if (![[[[pro_array objectAtIndex:i] objectForKey:@"_spec_value_ids"]objectForKey:@"1"]isEqualToString:str_record]) {
                    [array_product addObject:[[[pro_array objectAtIndex:i] objectForKey:@"_spec_value_ids"]objectForKey:@"1"]];
                    str_record=[[[pro_array objectAtIndex:i] objectForKey:@"_spec_value_ids"]objectForKey:@"1"];
                }
            }
            NSDictionary* valueDic = [giftDic objectForKey:@"spec_values"];
            NSArray* keyArray = [valueDic allKeys];
            for (int k = 0; k < [keyArray count]; k ++) {
                NSDictionary* specDic = [valueDic objectForKey:[keyArray objectAtIndex:k]];
                YKSpecitem* specitem = [[YKSpecitem alloc] init];
                specitem.productid = [specDic objectForKey:@"id"];
                specitem.spec_id = [specDic objectForKey:@"spec_id"];
                specitem.spec_value = [specDic objectForKey:@"spec_value"];
                specitem.spec_alias = [specDic objectForKey:@"spec_alias"];
                specitem.imgurl = [specDic objectForKey:@"imgurl"];
                NSString* specStr = [specDic objectForKey:@"spec_id"];
                if ([specStr isEqualToString:colorid]) {
                    if ([array_product indexOfObject:[specitem productid]]!=2147483647) {
                        [colorArray addObject:specitem];
                    }
                }
                if([specStr isEqualToString:sizeid]){
                    [sizeArray addObject:specitem];
                }
            }
            YKGiftItem* giftitem = [[YKGiftItem alloc] init];
            giftitem.productname = [giftDic objectForKey:@"productname"];
            giftitem.imageurl = [giftDic objectForKey:@"imageurl"];
            giftitem.price = [giftDic objectForKey:@"price"];
            giftitem.goodsid = [giftDic objectForKey:@"goodsid"];
            giftitem.promotion_id = [giftDic objectForKey:@"promotion_id"];
            giftitem.colorArray = colorArray;
            giftitem.sizeArray = sizeArray;
            giftitem.idArray = valueids;
            [self.gifts addObject:giftitem];
        }
        
        //推荐商品
        NSArray* hotlist = [json objectForKey:@"hotlist"];
        for (int i = 0; i < [hotlist count]; i ++) {
            NSDictionary* dic = (NSDictionary*)[hotlist objectAtIndex:i];
            YKItem* item = [[YKItem alloc] init];
            item.productid = [dic objectForKey:@"id"];
            item.imgurl = [dic objectForKey:@"pic"];
            item.name = [dic objectForKey:@"name"];
            item.strdiscountprice = [dic objectForKey:@"price"];
            item.price = [dic objectForKey:@"mkt_price"];
            [self.hotlist addObject:item];
        }
        
        //套装
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
                product.stock = [aSuit objectForKey:@"stock"];
                
                [item.suits addObject:product];

            }
            item.name = [dicdate objectForKey:@"name"];
            item.disountprice =[[dicdate objectForKey:@"discountprice"] floatValue];
            item.price = [[dicdate objectForKey:@"price"] floatValue];
            item.save = [[dicdate objectForKey:@"save"] floatValue];
            item.number = [[dicdate objectForKey:@"number"] intValue];
            item.suitid = [dicdate objectForKey:@"suitid"];
            item.selected = [[dicdate objectForKey:@"selected"] boolValue];
            item.uk = [dicdate objectForKey:@"uk"];
            item.is_valid = [[dicdate objectForKey:@"is_valid"] boolValue];
            [self.suitlist addObject:item];

        }
        
        //礼包
        for (id dicdate in [json objectForKey:@"packagelist"]) {
            YKSuitListItem * item = [[YKSuitListItem alloc] init];
            for (id aSuit in [dicdate objectForKey:@"package_product"]) {
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
            item.name = [dicdate objectForKey:@"name"];
            item.disountprice =[[dicdate objectForKey:@"discountprice"] floatValue];
            item.price = [[dicdate objectForKey:@"price"] floatValue];
            item.save = [[dicdate objectForKey:@"save"] floatValue];
            item.number = [[dicdate objectForKey:@"number"] intValue];
            item.packageid = [dicdate objectForKey:@"packageid"];
            item.selected = [[dicdate objectForKey:@"selected"] boolValue];
            item.uk = [dicdate objectForKey:@"uk"];
            item.is_valid = [[dicdate objectForKey:@"is_valid"] boolValue];
            [self.packagelist addObject:item];
            
        }
        
        id value = [json objectForKey:@"showwarn"];
        if ([value isKindOfClass:[NSNull class]]) {
            value = nil;
        }
        self.showwarn = [value boolValue];
        value = [json objectForKey:@"warn"];
        if ([value isKindOfClass:[NSNull class]]) {
            value = nil;
        }
        self.warn = value;
        //公告信息
        NSDictionary * d = [json objectForKey:@"notice"];
        self.notice = [d objectForKey:@"title"];
        
        
    }
    
    return self;
    
}

@end
