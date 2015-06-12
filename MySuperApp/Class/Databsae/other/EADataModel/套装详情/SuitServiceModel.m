//
//  SuitServiceModel.m
//  MySuperApp
//
//  Created by bonan on 14-4-23.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "SuitServiceModel.h"
#import "YKProductsList.h"

@implementation YKSuitItem

@synthesize sizelist;
@synthesize colorlist;
@synthesize productlist;
@synthesize color_sizelist;
@synthesize currentColor_sev;
@synthesize array_color_size;
@synthesize array_size;
@synthesize sizeid;
@synthesize colorid;

@synthesize productName;
@synthesize productId;
@synthesize selectIndex;
@synthesize pic;

@synthesize currentSize,currentColor,productSubId;


-(id)init
{
	if (self = [super init])
	{
        array_color_size=[[NSMutableArray alloc]init];
        currentColor_sev=[[NSString alloc]init];
        array_size=[[NSMutableArray alloc]init];
	}
    
    return self;
}



@end

@interface SuitServiceModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SuitServiceModel
@synthesize response;
@synthesize requestTag;
@synthesize errorMessage;


- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict{
    return nil;
}

+ (SuitServiceModel *)modelObjectWithDictionary:(NSDictionary *)dict
{
    SuitServiceModel *instance = [[SuitServiceModel alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        
        _suitArray  = [[NSMutableArray alloc] init];
        //颜色尺码id
        id jsontempone = [dict objectForKey:@"suitlist"];
        if (self.suitArray) {
            [self.suitArray removeAllObjects];
        }
        
        for (id json in jsontempone) {
            YKSuitItem *item = [[YKSuitItem alloc] init];
            item.productName = [json objectForKey:@"name"];
            item.productId = [json objectForKey:@"productid"];
            item.pic = [json objectForKey:@"pic"];
            item.currentSize = 0;
            item.currentColor = 0;
            
            //解析“specs”字段，该字段报春了key对应的相关信息，例如颜色和尺码的相关信息，数量一般不多，如果只有颜色和尺码，则数量会为2
            //即尺码颜色对应的key数据

            //-------- 谢贤辉 begin------//
            //-------- 谢贤辉 end-------//
            id success_color_size=[json objectForKey:@"specs"];
            item.color_sizelist = [[YKColor_SizeList alloc]init];
            for (id color_sizes in success_color_size) {
                YKColor_Size *color_size=[[YKColor_Size alloc]init];
                NSArray *color_key=[color_sizes allKeys];
                for (id key in color_key) {
                    [color_size setAttribute:[color_sizes objectForKey:key] forKey:key];
                }
                [item.color_sizelist addColor_Size:color_size];
            }
            
            /**
             *货品信息数组
             */
            //-------- 谢贤辉 begin------//
            //-------- 谢贤辉 end-------//
            id success_products = [json objectForKey:@"products"];
            //lee999 150608
            if ([(NSArray*)success_products count] > 0) {
                item.productlist = [[YKProductsList alloc] init];
                NSMutableArray *pro_array = [[NSMutableArray alloc] init];
                for (id pro in success_products) {
                    //过滤商品数量为0的商品
                    if (![[pro objectForKey:@"count"]isEqualToNumber:[NSNumber numberWithInt:0]]) {
                        [pro_array addObject:pro];
                    }
                }
                
                //添加有颜色的货品的颜色到array_product数组
                NSMutableArray *array_product = [[NSMutableArray alloc] init];
                NSString *str_record = [[NSString alloc] init];
                NSDictionary *dic = [pro_array objectAtIndex:0];
                if ([pro_array count] != 0) {
                    str_record = [[dic objectForKey:@"_spec_value_ids"] objectForKey:@"1"];
                    [array_product addObject:[[dic objectForKey:@"_spec_value_ids"] objectForKey:@"1"]];
                }
                for (int i = 0; i < [pro_array count]; i++) {
                    dic = [pro_array objectAtIndex:i];
                    if (![[[dic objectForKey:@"_spec_value_ids"] objectForKey:@"1"] isEqualToString:str_record]) {
                        [array_product addObject:[[dic objectForKey:@"_spec_value_ids"] objectForKey:@"1"]];
                        str_record=[[dic objectForKey:@"_spec_value_ids"] objectForKey:@"1"];
                    }
                }

                
                //添加所有商品到productlist数组
                for (id products in pro_array) {
                    //lee999 150608
                    if ([(NSArray*)products count] <= 0) {
                        continue;
                    }
                    YKProductsItem *product = [[YKProductsItem alloc] init];
                    NSArray *keyarray_product = [products allKeys];
                    for (id key in keyarray_product) {
                        [product setAttribute:[products objectForKey:key] forKey:key];
                    }
                    [item.productlist addProdcut:product];

                }
                //-------- 谢贤辉 begin------//
                //-------- 谢贤辉 end-------//
                //将某个商品的颜色和数组拼装，组成的元素保存到数组array_color_size中
                [item.array_color_size removeAllObjects];
                for (int i=0; i<[item.productlist count];i++ )
                {
                    YKProductsItem *pItem = [item.productlist objectAtIndex:i];
                    NSMutableString *str_size_color = [[NSMutableString alloc]init];
                    
                    for (int j=0; j<[item.color_sizelist count]; j++)
                    {
                        YKColor_Size *colorsizeItem = [item.color_sizelist objectAtIndex:j];
                        
                        if ([colorsizeItem.Spec_type isEqualToString:@"color"]) {
                            [str_size_color appendFormat:@"%@|",[pItem.Spec_value_id objectForKey:colorsizeItem.ID]];
                        }
                        if ([colorsizeItem.Spec_type isEqualToString:@"size"]) {
                            [str_size_color appendFormat:@"%@|",[pItem.Spec_value_id objectForKey:colorsizeItem.ID]];
                        }
                    }
                    NSLog(@"str_size_color:%@",str_size_color);
                    [item.array_color_size addObject:str_size_color];

                }
                
                //尺码颜色对应的value数据
                id success_size = [json objectForKey:@"spec_values"];
                NSArray *keys_size = [success_size allKeys];
                NSMutableArray *array_size_sev = [[NSMutableArray alloc] init];
                for (id ikey in keys_size) {
                    [array_size_sev addObject:[success_size objectForKey:ikey]];
                }
                //-------- 谢贤辉 begin------//
                //-------- 谢贤辉 end-------//
                item.colorlist = [[YKSizeList alloc] init];
                item.sizelist = [[YKSizeList alloc] init];
                item.colorid = [[NSString alloc] init];
                item.sizeid = [[NSString alloc] init];
                
                //添加所有的color和size到colorlist和sizelist
                for (id iSize in array_size_sev) {
                    NSArray *sizeKeys = [iSize allKeys];
                    YKSizeItem *sizeitem = [[YKSizeItem alloc] init];
                    for (id iKeySize in sizeKeys) {
                        [sizeitem setAttribute:[iSize objectForKey:iKeySize] forKey:iKeySize];
                    }
                    //寻找sizeid 和 colorid
                    id style = [json objectForKey:@"specs"];
                    for (id key in style) {
                        if ([[key objectForKey:@"spec_type"] isEqualToString:@"color"]) {
                            item.colorid = [key objectForKey:@"id"];
                        }
                        if ([[key objectForKey:@"spec_type"]isEqualToString:@"size"]) {
                            item.sizeid = [key objectForKey:@"id"];
                        }
                    }
                    //colorlist
                    if([[iSize objectForKey:@"spec_id"] isEqual:item.colorid]) {
                        if ([array_product indexOfObject:[sizeitem ID]] != 2147483647) {
                            [item.colorlist addSize:sizeitem];
                        }
                    }
                    if ([[iSize objectForKey:@"spec_id"] isEqual:item.sizeid]) {
                        [item.sizelist addSize:sizeitem];
                    }

                }

                [item.array_size removeAllObjects];
                
                

                 for (int j = 0; j<item.colorlist.count; j++) {
                
                    
                    
                    NSMutableArray *arr = [NSMutableArray array];
                     for (int i=0; i<[item.productlist count]; i++) {
                         
                         YKProductsItem *pItem = [item.productlist objectAtIndex:i];
                        if ([[pItem.Spec_value_id objectForKey:item.colorid] isEqual:[[item.colorlist objectAtIndex:j] ID]]) {

                            NSDictionary *str_size=[success_size objectForKey:[pItem.Spec_value_id objectForKey:item.sizeid]];
                            [arr addObject:str_size];
                        }
                    }
                    
                    if (arr.count > 0) {
                        
                        NSDictionary *size_colorDic = [NSDictionary dictionaryWithObject:arr forKey:[[item.colorlist objectAtIndex:j] ID]];
                        
                        [item.array_size addObject:size_colorDic];
                        
                    }
                }
                if ([item.productlist count]) {
                    item.productSubId = [[item.productlist objectAtIndex:0] ID];
                }
            }
            [self.suitArray addObject:item];
            }

        
        self.response = [dict objectForKey:@"response"];
        self.discountprice = [[dict objectForKey:@"discountprice"] floatValue];
        self.price = [[dict objectForKey:@"price"] floatValue];
        self.save = [[dict objectForKey:@"save"] floatValue];
        self.suitid = [dict objectForKey:@"suitid"];
    }
    
    return self;
    
}



@end
