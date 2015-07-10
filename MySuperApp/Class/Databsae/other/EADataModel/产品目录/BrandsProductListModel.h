//
//  BrandsProductListModel.h
//
//  Created by malan  on 14-4-13
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BrandsTypes.h"
#import "BrandsProductlistPictext.h"
#import "BrandsBrandInfo.h"
#import "BrandsProductlistFilter.h"
#import "LBaseModel.h"

@interface BrandsProductListModel : LBaseModel <NSCoding>

@property (nonatomic, assign) double recordCount;
@property (nonatomic, retain) NSArray *types;
@property (nonatomic, retain) NSArray *productlistPictext;
@property (nonatomic, retain) BrandsBrandInfo *brandInfo;
@property (nonatomic, assign) double currentPage;
@property (nonatomic, retain) NSArray *productlistFilter;
@property (nonatomic, retain) NSString *response;
@property (nonatomic, assign) double pageCount;
@property (nonatomic, assign) double shopcartcount;

@property (nonatomic, assign) NSInteger requestTag;
@property (retain, nonatomic) NSString *errorMessage;


//lee987 新增选中筛选
@property (nonatomic, retain) NSArray *productlist_select_filter;



+ (BrandsProductListModel *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
