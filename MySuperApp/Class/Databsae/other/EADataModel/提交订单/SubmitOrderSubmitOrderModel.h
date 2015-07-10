//
//  SubmitOrderSubmitOrderModel.h
//
//  Created by malan  on 14-4-4
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBaseModel.h"
#import "SubmitOrderSubmitorder.h"

@interface SubmitOrderSubmitOrderModel : LBaseModel <NSCoding>

@property (nonatomic, assign) BOOL ispay;
@property (nonatomic, retain) NSString *payway;
@property (nonatomic, retain) NSString *response;
@property (nonatomic, retain) SubmitOrderSubmitorder *submitorder;
@property (nonatomic, retain) NSString *orderid;
@property (retain, nonatomic) NSString *key;
@property (nonatomic, retain) NSString *tf_tradeNo;
@property (nonatomic, assign) BOOL zunxiang;


@property (retain, nonatomic) NSString *errorMessage;
@property (nonatomic, assign) NSInteger requestTag; /*这个与相应的请求的tag是同步的*/

+ (SubmitOrderSubmitOrderModel *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
