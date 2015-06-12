//
//  AlipayHelper.m
//  YouGou
//
//  Created by user on 12-1-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "AlipayHelper.h"
#import "MYMacro.h"
#import <AlipaySDK/AlipaySDK.h>
#import "JSON.h"


@implementation AlipayHelper
@synthesize delegate = _delegate;


+(void)alipayActionwithPrice:(NSString*)aPrice andOrderid:(NSString*)aorderid{

    AlixPayOrder *order = [[AlixPayOrder alloc] init];
    order.amount = [NSString stringWithFormat:@"%.2f",[aPrice floatValue]];//hiddle
    order.tradeNO = aorderid;
    order.productDescription = @"爱慕商城手机端订单详情";
    
    order.notifyURL = Alipay_notifyURL;
    
    [AlipayHelper payWithOrder:order CallbackBlock:^(NSDictionary *resultDic){
        [self dealPayResult:resultDic];
    }];
}

//lee999
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    //支付成功 跳转到订单详情
    if (alertView.tag == 109988) {
    }
}


-(void)callBack{

    if (self.delegate && [self.delegate respondsToSelector:@selector(AlipayHelperCallBack)]) {
        [self.delegate AlipayHelperCallBack];
    }

}


+(void)dealPayResult:(NSDictionary *)resultDic{
        NSDictionary* dic = resultDic;
        NSString *strmessage = [resultDic objectForKey:@"memo"];
        switch ([[dic objectForKey:@"resultStatus"] intValue]) {
            case 6001:
            {
                if (strmessage==nil || [strmessage length]==0)
                {
                    strmessage = @"用户中途取消";
                }
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:strmessage delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
                [alert show];
            }
                break;
            case 6002:
            {
                if (strmessage==nil || [strmessage length]==0)
                {
                    strmessage = @"网络连接出错";
                }
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:strmessage delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
                [alert show];
            }
                break;
            case 4000:
            {
                if (strmessage==nil || [strmessage length]==0)
                {
                    strmessage = @"订单支付失败";
                }
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:strmessage delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
                [alert show];
            }
                break;
            case 8000:
            {
                if (strmessage==nil || [strmessage length]==0)
                {
                    strmessage = @"正在处理中";
                }
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:strmessage delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
                [alert show];
            }
                break;
            case 9000:
            {
                
//                if ([SingletonState sharedStateInstance].isInCheckOKView) {
//                    [SingletonState sharedStateInstance].alipayisShowAlert = NO;
//                }else{
                    [SingletonState sharedStateInstance].alipayisShowAlert = YES;
//                }
                [[NSNotificationCenter defaultCenter] postNotificationName:@"alipayOKanjumptoOrderDetail" object:nil];
            }
                break;
            default:
                break;
        }
}

+ (void)payWithOrder:(AlixPayOrder*)order CallbackBlock:(CallbackBlock)callBackBlock
{

    NSString *partner = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"Partner"];
    NSString *seller = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"Seller"];
    order.partner=partner;
    order.seller_id=seller;
    
    order.productName = @"爱慕商城移动订单";
    //手机支付宝
    order.notifyURL = Alipay_notifyURL;

	//partner和seller获取失败,提示
	if ([partner length] == 0 || [seller length] == 0)
	{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
														message:@"缺少partner或者seller。"
													   delegate:self
											  cancelButtonTitle:@"确定"
											  otherButtonTitles:nil];
        alert.tag = 41112;
		[alert show];
		return;
	}
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
	
	//应用注册scheme,在AlixPayDemo-Info.plist定义URL types,用于安全支付成功后重新唤起商户应用
    //lee修改了这个地方,原来是com.android.yougou
	NSString *appScheme = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];//@"com.yintai.iphone";
    
	
	//将商品信息拼接成字符串
	NSString *orderSpec = [order description];
    
	
	//获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
	id<DataSigner> signer = CreateRSADataSigner([[NSBundle mainBundle] objectForInfoDictionaryKey:@"RSA private key"]);
	NSString *signedString = [signer signString:orderSpec];
	
	//将签名成功字符串格式化为订单字符串,请严格按照该格式
	NSString *orderString = nil;
	if (signedString != nil) {
		orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
	}

    [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        NSLog(@"reslut = %@",resultDic);
        callBackBlock(resultDic);

    }];
//    [[AlipaySDK defaultService] pay:orderString From:appScheme CallbackBlock:^(NSString *resultString){
//        callBackBlock(resultString);
//    }];
}

@end
