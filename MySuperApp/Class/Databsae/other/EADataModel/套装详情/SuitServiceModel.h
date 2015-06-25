//
//  SuitServiceModel.h
//  MySuperApp
//
//  Created by bonan on 14-4-23.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "LBaseModel.h"
#import "UrlImageButton.h"
#import "YKBaseEntity.h"
#import "YKSizeList.h"
#import "YKProductsList.h"


@interface YKSuitItem : YKBaseEntity{
    YKSizeList *sizelist;
    YKSizeList *colorlist;
    YKProductsList *productlist;
    YKColor_SizeList *color_sizelist;
    NSString* currentColor_sev;
    NSMutableArray *array_color_size;
    NSMutableArray *array_size;
    NSString *colorid;
    NSString *sizeid;
    
    NSString *productName;
    NSString *productId;
    NSInteger selectIndex;
//    NSString * pic;
    
    //数据源
    NSInteger currentColor;//滚动picker时给这b赋值
    NSInteger currentSize;
    NSString *productSubId;
    
}
@property(nonatomic, retain)YKSizeList *sizelist;
@property(nonatomic, retain)YKSizeList *colorlist;
@property(nonatomic, retain)YKProductsList *productlist;
@property(nonatomic, retain)YKColor_SizeList *color_sizelist;
@property(nonatomic, retain)NSString* currentColor_sev;
@property(nonatomic, retain)NSMutableArray *array_color_size;
@property(nonatomic, retain)NSMutableArray *array_size;
@property(nonatomic, retain)NSString *colorid;
@property(nonatomic, retain)NSString *sizeid;

@property(nonatomic, retain)NSString *productName;
@property(nonatomic, retain)NSString *productId;
@property(nonatomic, assign)NSInteger selectIndex;
@property(nonatomic, assign)NSString * pic;

//数据源
@property(nonatomic, assign)NSInteger currentColor;//滚动picker时给这b赋值
@property(nonatomic, assign)NSInteger currentSize;
@property(nonatomic, retain)NSString *productSubId;

@property(nonatomic, retain) UrlImageButton *buttonForSelect;
@property(nonatomic, retain) UrlImageButton *buttonForSize;


@end

@interface SuitServiceModel : LBaseModel

@property(nonatomic, retain) NSMutableArray *suitArray;

@property(nonatomic, retain)NSString *response;
@property(nonatomic, assign)float discountprice;
@property(nonatomic, assign)float price;
@property(nonatomic, assign)float save;
@property(nonatomic, retain)NSString *suitid;

@property (nonatomic, assign) int requestTag;
@property (retain, nonatomic) NSString *errorMessage;


+ (SuitServiceModel *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;



@end
