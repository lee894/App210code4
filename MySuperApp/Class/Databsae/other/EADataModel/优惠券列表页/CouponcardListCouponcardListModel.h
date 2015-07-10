//
//  CouponcardListCouponcardListModel.h
//
//  Created by malan  on 14-4-26
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBaseModel.h"


@interface CouponcardListCouponcardListModel : LBaseModel <NSCoding>

@property (nonatomic, assign) int currentPage;
@property (nonatomic, retain) NSString *recordCount;
@property (nonatomic, retain) NSString *response;
@property (nonatomic, assign) int pageCount;
@property (nonatomic, retain) NSArray *checkoutCards;
@property (nonatomic, retain) NSArray *checkoutCouponcard;
@property (nonatomic, assign) int cards_count;//卡个数
@property (nonatomic, assign) NSInteger couponcard_count;//优惠券个数


@property (nonatomic, assign) NSInteger requestTag;
@property (retain, nonatomic) NSString *errorMessage;

+ (CouponcardListCouponcardListModel *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
