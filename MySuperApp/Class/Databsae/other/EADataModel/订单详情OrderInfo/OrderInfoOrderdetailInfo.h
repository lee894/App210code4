//
//  OrderInfoOrderdetailInfo.h
//
//  Created by malan  on 14-4-19
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface OrderInfoOrderdetailInfo : NSObject <NSCoding>

@property (nonatomic, retain) NSString *deliveryPrice;
@property (nonatomic, retain) NSString *discountdes;
@property (nonatomic, assign) BOOL sendtime;
@property (nonatomic, retain) NSString *discountprice;
@property (nonatomic, retain) NSString *freight;
@property (nonatomic, retain) NSString *payway;
@property (nonatomic, retain) NSString *price;
@property (nonatomic, retain) NSString *ordertime;
@property (nonatomic, assign) BOOL comment_flag;
@property (nonatomic, retain) NSString *expressid;
@property (nonatomic, retain) NSString *remarskmsg;
@property (nonatomic, retain) id expresscorn;
@property (nonatomic, retain) NSString *status;
@property (nonatomic, retain) NSString *deliveryType;
@property (nonatomic, retain) NSString *eticket;

@property (nonatomic, retain) NSString *tf_tradeNo;


//lee999新增属性
@property (nonatomic, retain) NSString *co_price;
@property (nonatomic, retain) NSString *co_score;
@property (nonatomic, retain) NSString *orer_status;

//end



+ (OrderInfoOrderdetailInfo *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
