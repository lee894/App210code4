//
//  CarCarModel.h
//
//  Created by malan  on 14-4-8
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YKItem.h"
#import "YKSpecitem.h"
#import "YKGiftItem.h"
#import "YKProductsItem.h"
#import "LBaseModel.h"




@interface CarCarModel : LBaseModel

@property (nonatomic, retain) NSString *notice;
@property (nonatomic, assign) BOOL showwarn;
@property (nonatomic, retain) NSMutableArray *hotlist;
@property (nonatomic, retain) id warn;
@property (nonatomic, retain) NSMutableArray *suitlist;
@property (nonatomic, retain) NSString *carStatistics;
@property (nonatomic, retain) NSString *response;
@property (nonatomic, retain) NSMutableArray *carProductlist;
@property (nonatomic, retain) NSMutableArray* gifts;
@property (nonatomic, retain) NSString* itemNumber; //商品总量
@property (nonatomic, retain) NSString* itemPrice;


@property (retain, nonatomic) NSString *errorMessage;
@property (nonatomic, assign) int requestTag; /*这个与相应的请求的tag是同步的*/


+ (CarCarModel *)modelObjectWithDictionary:(NSDictionary *)dict;
//- (id)initWithDictionary:(NSDictionary *)dict;
//- (NSDictionary *)dictionaryRepresentation;

@end
