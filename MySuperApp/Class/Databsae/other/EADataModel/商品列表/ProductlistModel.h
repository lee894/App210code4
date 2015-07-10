//
//  ProductlistModel.h
//
//  Created by malan  on 14-4-26
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBaseModel.h"


@interface ProductlistModel : LBaseModel <NSCoding>

@property (nonatomic, retain) NSString *recordCount;
@property (nonatomic, retain) NSArray *types;
@property (nonatomic, retain) NSArray *productlistPictext;
@property (nonatomic, retain) NSString *brandInfo;
@property (nonatomic, assign) double currentPage;
@property (nonatomic, retain) NSArray *productlistFilter;
@property (nonatomic, retain) NSString *response;
@property (nonatomic, assign) double pageCount;


@property (nonatomic, assign) NSInteger requestTag; /*这个与相应的请求的tag是同步的*/
@property (retain, nonatomic) NSString *errorMessage;



+ (ProductlistModel *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
