//
//  AlixPayOrder.h
//  AliPay
//
//  Created by WenBi on 11-5-18.
//  Copyright 2011 Alipay. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AlixPayOrder : NSObject {
	NSString * _partner;
	NSString * _seller_id;
	NSString * _tradeNO;
	NSString * _productName;
	NSString * _productDescription;
	NSString * _amount;
	NSString * _notifyURL;
	NSMutableDictionary * _extraParams;
    
    //lee支付宝钱包，需要增加参数
    NSString * _accesstoken;
    
}

@property(nonatomic, copy) NSString * partner;
@property(nonatomic, copy) NSString * seller_id;
@property(nonatomic, copy) NSString * tradeNO;
@property(nonatomic, copy) NSString * productName;
@property(nonatomic, copy) NSString * productDescription;
@property(nonatomic, copy) NSString * amount;
@property(nonatomic, copy) NSString * notifyURL;
@property(nonatomic, copy) NSString * service;
@property(nonatomic, copy) NSString * paymentType;
@property(nonatomic, copy) NSString * inputCharset;
@property(nonatomic, copy) NSString * itBPay;
@property(nonatomic, copy) NSString * showUrl;
@property(nonatomic, readonly) NSMutableDictionary * extraParams;

@property(nonatomic, copy) NSString * rsaDate;//可选
@property(nonatomic, copy) NSString * appID;//可选

//lee支付宝钱包，需要增加参数
@property(nonatomic, copy) NSString * accesstoken;

@end
