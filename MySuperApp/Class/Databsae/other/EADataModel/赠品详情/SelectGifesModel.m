//
//  SelectGifesModel.m
//  MySuperApp
//
//  Created by bonan on 14-4-28.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "SelectGifesModel.h"

@implementation SelectGifesModel

@synthesize requestTag;
@synthesize errorMessage,response;


+ (SelectGifesModel *)modelObjectWithDictionary:(NSDictionary *)dict{
    SelectGifesModel *instance = [[SelectGifesModel alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        
        _gifts = [[NSMutableArray alloc] init];
        _nogifts = [[NSMutableArray alloc] init];
    
        if ([dict objectForKey:@"selected"] == nil) {
            self.selected = NO;
        
        NSDictionary *giftDictionary = [dict objectForKey:@"select_gifts"];
        NSArray *giftArray = [giftDictionary objectForKey:@"gifts"];
        
        for (int i = 0; i < [giftArray count]; i ++) {
            
            NSMutableArray *giftsArr = [[NSMutableArray alloc] init];
            NSDictionary *oneDic = [giftArray objectAtIndex:i];
            NSArray *action = [oneDic objectForKey:@"action"];
            
            for (int j = 0; j < [action count]-2; j++) {
                
                NSMutableArray *sizeArray = [[NSMutableArray alloc] init];
                NSMutableArray *colorArray = [[NSMutableArray alloc] init];
                NSMutableArray *valueids = [[NSMutableArray alloc] init];
                
                NSDictionary* giftDic = (NSDictionary*)[action objectAtIndex:j];
                NSArray* productArray = [giftDic objectForKey:@"products"];
                NSMutableArray *pro_array=[[NSMutableArray alloc]init];
                for (id pro in productArray) {
                    if (![[pro objectForKey:@"count"]isEqualToNumber:[NSNumber numberWithInt:0]]) {
                        [pro_array addObject:pro];
                    }
                }
                NSString *colorid=[[NSString alloc]init];
                NSString *sizeid=[[NSString alloc]init];
                id style=[[action objectAtIndex:j] objectForKey:@"specs"];
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
//                    [item release];
                }
                NSMutableArray *array_product=[[NSMutableArray alloc]init];
                NSString *str_record=[[NSString alloc]init];
                if ([pro_array count]!=0) {
                    str_record=[[[pro_array objectAtIndex:0] objectForKey:@"_spec_value_ids"] objectForKey:@"1"];
                    [array_product addObject:[[[pro_array objectAtIndex:0] objectForKey:@"_spec_value_ids"] objectForKey:@"1"]];
                }
                for (int i=0; i<[pro_array count]; i++) {
                    // NSLog(@"%@",[[[pro_array objectAtIndex:i] objectForKey:@"_spec_value_ids"]objectForKey:@"1"]);
                    if (![[[[pro_array objectAtIndex:i] objectForKey:@"_spec_value_ids"]objectForKey:@"1"]isEqualToString:str_record]) {
                        [array_product addObject:[[[pro_array objectAtIndex:i] objectForKey:@"_spec_value_ids"]objectForKey:@"1"]];
                        str_record=[[[pro_array objectAtIndex:i] objectForKey:@"_spec_value_ids"]objectForKey:@"1"];
                    }
                }
                NSDictionary* valueDic = [giftDic objectForKey:@"spec_values"];
                NSArray* keyArray = [valueDic allKeys];
                // NSLog(@"------------------------&&&&&&&&&&&&&&&&&&&&&&%@:%@",colorid,sizeid);
                
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
//                                    if (![colorArray containsObject:specitem]) {
                                        [colorArray addObject:specitem];

//                                    }
                                }
                                //[colorArray addObject:specitem];
                            }
//                            if([specStr isEqualToString:sizeid]){
//
//                                NSMutableArray *arr = [NSMutableArray array];
//
//                                for (YKItem* item in valueids) {
//                                    
//                                    
//                                    if ([item.size isEqualToString:specitem.productid]) {
//                                        [arr addObject:specitem];
//                                        
//                                            [sizeArray addObject:specitem];
//                                    }
//                                
//                                }
//                            }
//                            [specitem release];

        }
                
                for (YKSpecitem *itemColor in colorArray) {
                    NSMutableArray *arr = [NSMutableArray array];
                    for (int i = 0;i < valueids.count;i++) {
                        YKItem *itemProduct  = [valueids objectAtIndex:i];
                        if ([itemProduct.color isEqualToString:itemColor.productid]) {
                            
                            YKSpecitem *itemSize = [valueDic objectForKey:itemProduct.size];
                            
                            [arr addObject:itemSize];
                        }
                    }
                    
                    if (arr.count > 0) {
                        NSDictionary *size_colorDic = [NSDictionary dictionaryWithObject:arr forKey:[itemColor productid]];
                        [sizeArray addObject:size_colorDic];

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
                [giftsArr addObject:giftitem];
                
                NSString *promotionName = [[action objectAtIndex:action.count-2] objectForKey:@"promotion_name"]?[[action objectAtIndex:action.count-2] objectForKey:@"promotion_name"]:@"";
                NSString *actionname = [[action lastObject] objectForKey:@"actionname"]?[[action lastObject] objectForKey:@"actionname"]:@"";
                [giftsArr addObject:promotionName];
                [giftsArr addObject:actionname];
                
                [self.gifts addObject:giftsArr];
//                [giftsArr release];
            }
        }
            
            
            
        
        NSArray *nogiftsArr = [giftDictionary objectForKey:@"nogifts"];
//            if (!nogiftsArr) {
            //lee999 修改判断
            if ([nogiftsArr count] != 0) {
                for (int k = 0; k < nogiftsArr.count; k++) {
                    
                    NSDictionary *nogiftsDic = [nogiftsArr objectAtIndex:k];
                    NogiftsModel *nogiftsModel = [NogiftsModel modelObjectWithDictionary:nogiftsDic];
                    
                    [self.nogifts addObject:nogiftsModel];
                }
            }
        }else {
            
            self.selected = YES;
            
            NSDictionary *giftDictionary = [dict objectForKey:@"select_gifts"];
            
            NSArray *giftArray = [giftDictionary objectForKey:@"gifts"];
            
            for (int k = 0; k < giftArray.count; k++) {
                
                NSDictionary *nogiftsDic = [giftArray objectAtIndex:k];
                
                NogiftsModel *nogiftsModel = [NogiftsModel modelObjectWithDictionary:nogiftsDic];
                
                [self.gifts addObject:nogiftsModel];
            }
            
            NSArray *nogiftsArr = [giftDictionary objectForKey:@"nogifts"];
            if (!nogiftsArr) {
                for (int k = 0; k < nogiftsArr.count; k++) {
                    
                    NSDictionary *nogiftsDic = [nogiftsArr objectAtIndex:k];
                    
                    NogiftsModel *nogiftsModel = [NogiftsModel modelObjectWithDictionary:nogiftsDic];
                    
                    [self.nogifts addObject:nogiftsModel];
                }

            }
        }
        
    }
    
    return self;
    
}

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}

- (NSDictionary *)dictionaryRepresentation{
    
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    //    [mutableDict setValue:self.res forKey:@"res"];
    
    return [NSDictionary dictionaryWithDictionary:mutableDict];
    
}


@end
