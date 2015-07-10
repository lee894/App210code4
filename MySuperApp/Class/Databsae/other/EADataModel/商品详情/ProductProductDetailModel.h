//
//  ProductProductDetailModel.h
//
//  Created by malan  on 14-4-9
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YKProductsList.h"
#import "YKProductdetailSuper.h"
#import "YKRecommendList.h"
#import "YKSizeList.h"
#import "LBaseModel.h"

@interface ProductProductDetailModel : LBaseModel  {
    NSString *colorid;
    NSString *sizeid;
    
    YKProductdetailList *detailList;
}




@property(nonatomic, retain) YKProductdetailSuper *detailSuper;
@property(nonatomic, retain) YKRecommendList *recommendlist;
@property(nonatomic, retain) YKSizeList *sizelist;
@property(nonatomic, retain) YKSizeList *colorlist;
@property(nonatomic, retain)YKProductsList *productlist;
@property(nonatomic, retain)YKColor_SizeList *color_sizelist;
@property(nonatomic, retain)YKBannerList *bannerlist;
@property(nonatomic, retain)NSString* currentColor_sev;
@property(nonatomic, retain)NSString *prodcutName;
@property(nonatomic, retain)NSMutableArray *array_color_size;
@property(nonatomic, retain)NSMutableArray *array_productid;
@property(nonatomic, retain)NSMutableArray *arr_desc;
@property(nonatomic, retain)NSString *str_Pro_desc;
@property(nonatomic, retain)NSMutableArray *array_size;
@property(nonatomic, retain)NSString *price_market;
@property(nonatomic, retain)NSString *price_aimer;
@property(nonatomic, retain)NSString *price_market_label;
@property(nonatomic, retain)NSString *price_aimer_label;
@property(nonatomic, retain)NSString *sizeInfo;
@property(nonatomic, retain)NSString *clientdownloadurl;
@property(nonatomic, retain)NSString *webshowurl;
@property(nonatomic, retain)NSString * suitid;
@property (nonatomic, retain) NSString *commentcount;

@property (nonatomic, retain) NSString *productId;

//8.29
@property (nonatomic, retain) NSString *product_share_url;
@property (nonatomic, retain) NSString *notice;
@property (nonatomic, retain) NSString *size_url;  //尺码对照表的url

@property (nonatomic, assign) BOOL isSollection;


@property (retain, nonatomic) NSString *errorMessage;
@property (nonatomic, assign) NSInteger requestTag; /*这个与相应的请求的tag是同步的*/
@property (nonatomic, retain) NSString *response;



+ (ProductProductDetailModel *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;

@end
