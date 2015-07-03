//
//  OrderInfoOrderInfoModel.h
//
//  Created by malan  on 14-4-19
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderInfoOrderdetailInfo.h"
#import "OrderInfoOrderdetailReceiveinfo.h"
#import "LBaseModel.h"

@interface OrderInfoOrderInfoModel : LBaseModel <NSCoding>

@property (nonatomic, assign) BOOL iscancle;
@property (nonatomic, retain) OrderInfoOrderdetailInfo *orderdetailInfo;
@property (nonatomic, assign) BOOL ispay;
@property (nonatomic, retain) OrderInfoOrderdetailReceiveinfo *orderdetailReceiveinfo;
@property (nonatomic, retain) NSString *response;
@property (nonatomic, retain) NSMutableArray* itemSuit;//套装列表
//@property (nonatomic, retain) NSMutableArray* itemPackage;//套装列表
@property (nonatomic, retain) NSMutableArray* itemList;

@property(nonatomic, retain) NSMutableArray* itemAllowpaytype;//允许的支付方式


@property (retain, nonatomic) NSString *errorMessage;
@property (nonatomic, assign) int requestTag; /*这个与相应的请求的tag是同步的*/


//lee999
@property (nonatomic, assign) BOOL isshowpaybar;


+ (OrderInfoOrderInfoModel *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end

