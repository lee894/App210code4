//
//  ProductProductDetailModel.m
//
//  Created by malan  on 14-4-9
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "ProductProductDetailModel.h"

@interface ProductProductDetailModel ()


@end

@implementation ProductProductDetailModel


@synthesize requestTag;
@synthesize errorMessage,response;



+ (ProductProductDetailModel *)modelObjectWithDictionary:(NSDictionary *)dict
{
    ProductProductDetailModel *instance = [[ProductProductDetailModel alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)json
{
    self = [super init];
    
    
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [json isKindOfClass:[NSDictionary class]]) {
        
        
        _array_color_size=[[NSMutableArray alloc]init];
        _array_productid=[[NSMutableArray alloc]init];
        if (!self.currentColor_sev) {
            _currentColor_sev=[[NSString alloc]init];
            
        }
        _str_Pro_desc=[[NSString alloc]init];
        _array_size=[[NSMutableArray alloc]init];
        _price_market=[[NSString alloc]init];
        _price_aimer=[[NSString alloc]init];
        _price_market_label=[[NSString alloc]init];
        _price_aimer_label=[[NSString alloc]init];
        _sizeInfo=[[NSString alloc]init];
        _clientdownloadurl=[[NSString alloc]init];
        _webshowurl=[[NSString alloc]init];
        _suitid = [[NSString alloc] init];
        
        /**
         *商品图片
         */
        id success_pic=[json objectForKey:@"product_banner"];
        _bannerlist=[[YKBannerList alloc]init];
        
        for (id banners in success_pic) {
            YKBannerItem *banner = [[YKBannerItem alloc] init];
            NSArray *keyArray_banner = [banners allKeys];
            for (id key in keyArray_banner) {
                [banner setAttribute:[banners objectForKey:key] forKey:key];
            } // end for
            [self.bannerlist addBanner:banner];
        } // end for
        /**
         *颜色尺码id
         */
        id success_color_size=[json objectForKey:@"specs"];
        _color_sizelist=[[YKColor_SizeList alloc]init];
        for (id color_sizes in success_color_size) {
            YKColor_Size *color_size=[[YKColor_Size alloc]init];
            NSArray *color_key=[color_sizes allKeys];
            for (id key in color_key) {
                [color_size setAttribute:[color_sizes objectForKey:key] forKey:key];
            }
            [self.color_sizelist addColor_Size:color_size];
        }
        //NSLog(@"%@",color_sizelist);
        /**
         *货品信息数组
         */
#pragma mark 货品数组
        id success_products=[json objectForKey:@"products"];
        _productlist = [[YKProductsList alloc] init];
#pragma mark 只有有货的货品的数组
        NSMutableArray *pro_array=[[NSMutableArray alloc]init];
        for (id pro in success_products) {
            if (![[pro objectForKey:@"count"] isEqualToNumber:[NSNumber numberWithInt:0]]) {
//            if ([[pro objectForKey:@"count"] intValue] != 0) {

                [pro_array addObject:pro];
                //                self.productId = [pro objectForKey:@"id"];
            }
        }
        //NSLog(@"&&&&&&&&&&&&&&&&&&&%@",pro_array);
#pragma mark 有货品的尺码
        NSMutableArray *array_product=[[NSMutableArray alloc]init];
        NSString *str_record=@"";//[[NSString alloc]init];
        if ([pro_array count]!=0) {
            str_record=[[[pro_array objectAtIndex:0] objectForKey:@"_spec_value_ids"] objectForKey:@"1"];
            
            if ([[[pro_array objectAtIndex:0] objectForKey:@"_spec_value_ids"] objectForKey:@"1"] != nil) {
                [array_product addObject:[[[pro_array objectAtIndex:0] objectForKey:@"_spec_value_ids"] objectForKey:@"1"]];
            }
        }
        for (int i=0; i<[pro_array count]; i++) {
            if ([[[pro_array objectAtIndex:0] objectForKey:@"_spec_value_ids"] objectForKey:@"1"] != nil) {

            if (![[[[pro_array objectAtIndex:i] objectForKey:@"_spec_value_ids"]objectForKey:@"1"]isEqualToString:str_record]) {
                [array_product addObject:[[[pro_array objectAtIndex:i] objectForKey:@"_spec_value_ids"]objectForKey:@"1"]];
                str_record=[[[pro_array objectAtIndex:i] objectForKey:@"_spec_value_ids"]objectForKey:@"1"];
            }
            }
        }
#pragma mark 有货品的对象
        for (id products in pro_array) {
            YKProductsItem *product=[[YKProductsItem alloc]init];
            NSArray *keyarray_product=[products allKeys];
            for (id key in keyarray_product) {
                [product setAttribute:[products objectForKey:key] forKey:key];
            } // end for
            [self.productlist addProdcut:product];
//            [product release];
        } // end for
        [self.array_color_size removeAllObjects];
        for (int i=0; i<[self.productlist count];i++ ) {
            NSMutableString *str_size_color=[[NSMutableString alloc]init];
            
            for (int j=0; j<[self.color_sizelist count]; j++) {
                if ([[[self.color_sizelist objectAtIndex:j]Spec_type ]isEqualToString:@"color"]) {
                    [str_size_color appendFormat:@"%@",[[[self.productlist objectAtIndex:i]Spec_value_id] objectForKey:[[self.color_sizelist objectAtIndex:j]ID ]]];
                    [str_size_color appendFormat:@"|"];
                }
                if ([[[self.color_sizelist objectAtIndex:j]Spec_type ]isEqualToString:@"size"]) {
                    [str_size_color appendFormat:@"%@",[[[self.productlist objectAtIndex:i]Spec_value_id] objectForKey:[[self.color_sizelist objectAtIndex:j]ID ]]];
                    [str_size_color appendFormat:@"|"];
                }
            }
            [self.array_color_size addObject:str_size_color];
//            [str_size_color release];
        }
        //NSLog(@"######################%@",array_color_size);
        
        /**
         *尺码颜色数据
         */
        id success_size=[json objectForKey:@"spec_values"];
        NSArray *keys_size=[success_size allKeys];
        NSMutableArray *array_size_sev=[[NSMutableArray alloc]init];
        for (id ikey in keys_size) {
            [array_size_sev addObject:[success_size objectForKey:ikey]];
        }
        _colorlist=[[YKSizeList alloc]init];
        _sizelist=[[YKSizeList alloc]init];
        //self.currentColor_sev=[[[NSUserDefaults standardUserDefaults]objectForKey:@"currentColor"] intValue];
        colorid=[[NSString alloc]init];
        sizeid=[[NSString alloc]init];
        for (id iSize in array_size_sev) {
            NSArray *sizeKeys=[iSize allKeys];
            YKSizeItem *sizeitem=[[YKSizeItem alloc]init];
            for (id iKeySize in sizeKeys) {
                [sizeitem setAttribute:[iSize objectForKey:iKeySize] forKey:iKeySize];
            }
#pragma mark_sizeid_colorid
            id style=[json objectForKey:@"specs"];
            for (id key in style) {
                if ([[key objectForKey:@"spec_type"]isEqualToString:@"color"]) {
                    colorid=[key objectForKey:@"id"];
                }
                if ([[key objectForKey:@"spec_type"]isEqualToString:@"size"]) {
                    sizeid=[key objectForKey:@"id"];
                }
            }
#pragma mark_colorlist
            if([[iSize objectForKey:@"spec_id"] isEqual:colorid]) {
                NSLog(@"~~~~~~~~~~~~~~~~~~~~%d",[array_product indexOfObject:[sizeitem ID]]);
                if ([array_product indexOfObject:[sizeitem ID]]!=2147483647) {
                    [self.colorlist addSize:sizeitem];
                }
//                [sizeitem release];
            }
            if ([[iSize objectForKey:@"spec_id"]isEqual:sizeid]) {
                [self.sizelist addSize:sizeitem];
//                [sizeitem release];
            }
            
        }
        [self.array_size removeAllObjects];
        
        for (int j = 0; j< self.colorlist.count; j++) {
            
            NSMutableArray *arr = [NSMutableArray array];
            
            for (int i=0; i<[self.productlist count]; i++) {
                
                
                
                if ([[[[self.productlist objectAtIndex:i] Spec_value_id] objectForKey:colorid]isEqual:[[self.colorlist objectAtIndex:j]ID]]) {
                    
                    //               for (YKSizeItem *sizeTmp in self.sizelist) {
                    //                   if ([[[[self.productlist objectAtIndex:i] Spec_value_id] objectForKey:sizeid] isEqual:[sizeTmp ID]]) {
                    //
                    //
                    //                   }
                    //             }
                    
                    NSDictionary *str_size=[success_size objectForKey:[[[self.productlist objectAtIndex:i] Spec_value_id] objectForKey:sizeid]];
                    
                    
                    [arr addObject:str_size];
                    
            

                }
            
            
        }
        if (arr.count > 0) {
            
            NSDictionary *size_colorDic = [NSDictionary dictionaryWithObject:arr forKey:[[self.colorlist objectAtIndex:j]ID]];
            
            [self.array_size addObject:size_colorDic];
            
        }
        
    }
    
    //        NSMutableArray *array_dd=[[NSMutableArray alloc]init];
    //        for (int i=0; i<[pro_array count]; i++) {
    //            for (int j=0; j<[self.colorlist count]; j++) {
    //                if ([[[self.colorlist objectAtIndex:j] ID]isEqualToString:[[[pro_array objectAtIndex:i]objectForKey:@"_spec_value_ids"]objectForKey:@"1"]]) {
    //                    [array_dd addObject:[self.colorlist objectAtIndex:j]];
    //                }
    //            }
    //        }
    //NSLog(@"%@:%@:%@",colorid,sizeid,currentColor_sev);
    /**
     *推荐列表数据
     
     */
        //-------- 谢贤辉 begin------//
        //-------- 谢贤辉 end-------//
    id success_response=[json objectForKey:@"hotlist"];
    //NSLog(@"%@",[success_response class]);
    self.prodcutName=[[NSString alloc]initWithFormat:@"%@",[json objectForKey:@"productname"]];
    _recommendlist = [[YKRecommendList alloc] init];
    for (id iRec in success_response) {
        NSArray *keys = [iRec allKeys];
        YKRecommendItem *recommend = [[YKRecommendItem alloc] init];
        for (id iKey in keys) {
            [recommend setAttribute:[iRec objectForKey:iKey] forKey:iKey];
        } // end for
        [self.recommendlist addRecommend:recommend];
    } // end for
    [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"currentSize"];
    self.str_Pro_desc=[json objectForKey:@"product_multidesc"];
    
    [self.arr_desc removeAllObjects];
    _arr_desc=[[NSMutableArray alloc]init];
    id success_desc=[json objectForKey:@"props"];
    NSArray *array_desc=[success_desc allKeys];
    for (id kye in array_desc) {
        NSMutableString *str_desc=[[NSMutableString alloc]init];
        [str_desc appendFormat:@"%@",kye];
        [str_desc appendFormat:@"  :  "];
        [str_desc appendFormat:@"%@",[success_desc objectForKey:kye]];
        [self.arr_desc addObject:str_desc];
//        [str_desc release];
        
    }
    self.product_share_url = [json objectForKey:@"product_share_url"];
    self.price_aimer_label  =   [[json objectForKey:@"price"] objectForKey:@"name"];
    self.price_aimer        =   [[json objectForKey:@"price"] objectForKey:@"value"];
    self.price_market_label =   [[json objectForKey:@"price1"] objectForKey:@"name"];
    self.price_market       =   [[json objectForKey:@"price1"] objectForKey:@"value"];
    self.sizeInfo           =   [json objectForKey:@"product_sizeinfo"];
    self.clientdownloadurl  =   [json objectForKey:@"clientdownloadurl"];
    self.webshowurl         =   [json objectForKey:@"webshowurl"];
    self.suitid             =   [json objectForKey:@"suitid"];
    self.notice             =   [json objectForKey:@"notice"];
    self.commentcount       =   [json objectForKey:@"commentcount"];
        

    //lee999 新增尺码对照表的url
    self.size_url = [json objectForKey:@"size_url"];
    self.isSollection = [[json objectForKey:@"isSollection"] boolValue];

}

return self;

}


@end
