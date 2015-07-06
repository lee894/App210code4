//
//  CouponDetail20ViewController.h
//  MyAimerApp
//
//  Created by 蒋博男 on 15/6/18.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "QrcodeView.h"
#import "LBaseViewController.h"

typedef enum : NSUInteger {
    kCoupon,
    kGift,
    kFreePost,
    kO2O
} EDetailType;

@interface CouponDetail20ViewController : LBaseViewController <QrcodeViewDelegate, UIWebViewDelegate>
@property (nonatomic, retain) id data;
@property (nonatomic, assign) EDetailType dType;

@property (nonatomic, assign) NSInteger isMycard; //0 是我的优惠券啊。   1不是我自己的优惠券，（自己的能显示二维码，不是自己的没有二维码）


@end
