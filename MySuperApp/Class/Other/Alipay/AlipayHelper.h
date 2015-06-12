//
//  AlipayHelper.h
//  YouGou
//
//  Created by user on 12-1-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AlixPayOrder.h"
#import "DataSigner.h"
#import "AlixPay.h"


@protocol AlipayHelperDelegate <NSObject>

-(void)AlipayHelperCallBack;

@end


@interface AlipayHelper : NSObject <UIAlertViewDelegate>

@property (nonatomic,assign) id<AlipayHelperDelegate>delegate;


typedef void(^CallbackBlock)(NSDictionary* resultDic);

+(void)alipayActionwithPrice:(NSString*)aPrice andOrderid:(NSString*)aorderid;
+(void)payWithOrder:(AlixPayOrder*)order CallbackBlock:(CallbackBlock)callBackBlock;

+(void)dealPayResult:(NSDictionary *)resultDic;

@end
