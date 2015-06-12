//
//  AlixPayOrder.m
//  AliPay
//
//  Created by WenBi on 11-5-18.
//  Copyright 2011 Alipay. All rights reserved.
//

#import "AlixPayOrder.h"
#import "SingletonState.h"


#pragma mark -
#pragma mark AlixPayOrder
@implementation AlixPayOrder

@synthesize partner = _partner;
@synthesize seller_id = _seller_id;
@synthesize tradeNO = _tradeNO;
@synthesize productName = _productName;
@synthesize productDescription = _productDescription;
@synthesize amount = _amount;
@synthesize notifyURL = _notifyURL;
@synthesize extraParams = _extraParams;

//lee支付宝钱包需要增加参数
@synthesize accesstoken = _accesstoken;

- (void)dealloc {
	self.partner = nil;
	self.seller_id = nil;
	self.tradeNO = nil;
	self.productName = nil;
	self.productDescription = nil;
	self.amount = nil;
	self.notifyURL = nil;
    self.service = nil;
    self.paymentType = nil;
    self.inputCharset = nil;
    self.itBPay = nil;
    self.showUrl = nil;
    //lee支付宝钱包需要增加参数
    self.accesstoken = nil;
    
//	[self.extraParams release];
	//[super dealloc];
}

//拼接订单字符串函数,运行外部商户自行优化
- (NSString *)description {
    NSMutableString * discription = [NSMutableString string];
    if (self.partner) {
        [discription appendFormat:@"partner=\"%@\"", self.partner];
    }
	
    if (self.seller_id) {
        [discription appendFormat:@"&seller_id=\"%@\"", self.seller_id];
    }
	if (self.tradeNO) {
        [discription appendFormat:@"&out_trade_no=\"%@\"", self.tradeNO];
    }
	if (self.productName) {
        [discription appendFormat:@"&subject=\"%@\"", self.productName];
    }
	
	if (self.productDescription) {
        [discription appendFormat:@"&body=\"%@\"", self.productDescription];
    }
	if (self.amount) {
        [discription appendFormat:@"&total_fee=\"%@\"", self.amount];
    }
    if (self.notifyURL) {
        [discription appendFormat:@"&notify_url=\"%@\"", self.notifyURL];
    }
	
    if (self.service) {
        [discription appendFormat:@"&service=\"%@\"",self.service];//mobile.securitypay.pay
    }
    if (self.paymentType) {
        [discription appendFormat:@"&payment_type=\"%@\"",self.paymentType];//1
    }
    
    if (self.inputCharset) {
        [discription appendFormat:@"&_input_charset=\"%@\"",self.inputCharset];//utf-8
    }
    if (self.itBPay) {
        [discription appendFormat:@"&it_b_pay=\"%@\"",self.itBPay];//30m
    }
    if (self.showUrl) {
        [discription appendFormat:@"&show_url=\"%@\"",self.showUrl];//m.alipay.com
    }
    if (self.rsaDate) {
        [discription appendFormat:@"&sign_date=\"%@\"",self.rsaDate];
    }
    if (self.appID) {
        [discription appendFormat:@"&app_id=\"%@\"",self.appID];
    }
    
    //lee支付宝钱包需要增加参数
//    if ([SingletonState sharedStateInstance].isfromAlipayWalet) {
//        [discription appendFormat:@"&extern_token=\"%@\"", self.accesstoken ? self.accesstoken : @""];
//    }
    
	for (NSString * key in [self.extraParams allKeys]) {
		[discription appendFormat:@"&%@=\"%@\"", key, [self.extraParams objectForKey:key]];
	}
	return discription;
}

@end
