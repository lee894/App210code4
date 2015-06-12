//
//  OrdersOrdersList.h
//
//  Created by malan  on 14-4-19
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface OrdersOrdersList : NSObject <NSCoding>

@property (nonatomic, retain) NSString *status;
@property (nonatomic, retain) id commentFlag;
@property (nonatomic, retain) NSString *time;
@property (nonatomic, retain) NSString *price;
@property (nonatomic, retain) NSString *orderid;
@property (nonatomic, retain) NSString *expresscorn;
@property (nonatomic, retain) NSString *expressid;
@property (nonatomic, retain) NSString *name;

//lee999 新增属性
@property (nonatomic, retain) NSString *order_status;
@property (nonatomic, retain) NSString *order_pic;
@property (nonatomic, retain) NSString *goodscount;
@property (nonatomic, retain) NSString *pay_status;
@property (nonatomic, retain) NSString *delivery_type;
@property(nonatomic, retain) NSMutableArray* itemAllowpaytype;//允许的支付方式
//end

+ (OrdersOrdersList *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
