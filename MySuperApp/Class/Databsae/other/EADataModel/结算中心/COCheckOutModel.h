//
//  COCheckOutModel.h
//
//  Created by malan  on 14-4-7
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBaseModel.h"
#import "YKItem.h"
#import "YKAdressItem.h"
#import "YKCouponcardItem.h"
#import "YKProductsItem.h"
#import "COPromotions.h"

@class COCheckoutStatistics, COPromotions;

@interface COCheckOutModel : LBaseModel <NSCoding>

@property (nonatomic, retain) NSMutableArray *suitlist;
@property (nonatomic, retain) NSMutableArray *packagelist;

@property (nonatomic, retain) COCheckoutStatistics *checkoutStatistics;
@property (nonatomic, retain) NSMutableArray *checkoutPaywayNew;
@property (nonatomic, retain) NSMutableArray *checkoutCouponcard;
@property (nonatomic, retain) NSString *response;
@property (nonatomic, retain) COPromotions *promotions;
@property (nonatomic, retain) NSMutableArray *checkoutConsigneeinfo;
@property (nonatomic, retain) NSMutableArray *checkoutProductlist;
@property (nonatomic, assign) int checkout_score;


@property(nonatomic,retain) NSString* itemPrice;
@property(nonatomic,retain) NSString* orderPrice;
@property(nonatomic,retain) NSString* carriagePrice;
@property(nonatomic,retain) NSString* voucherPrice;
@property(nonatomic,retain) NSString* preferentialPrice;
@property (nonatomic, retain) NSString *zuxiangPrice;

@property (nonatomic, retain) NSArray *checkout_usev6cards;
@property(nonatomic,retain) NSDictionary *checkout_usecouponcard;  //使用优惠券
@property(nonatomic,retain) NSString *checkout_usev6cardsres;  //使用v6card
@property(nonatomic,retain) NSString *checkout_usefreepost;   //使用包邮卡


@property (nonatomic, retain) NSArray *checkoutV6cards;
@property (nonatomic, assign) int checkoutCountv6;

@property (nonatomic, retain) NSArray *checkout_freepostcard;  //包邮卡
@property (nonatomic, retain) NSArray *arrCheckout_couponcard; //优惠券




@property (retain, nonatomic) NSString *errorMessage;
@property (nonatomic, assign) NSInteger requestTag; /*这个与相应的请求的tag是同步的*/


+ (COCheckOutModel *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
