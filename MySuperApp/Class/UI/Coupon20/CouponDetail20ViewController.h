//
//  CouponDetail20ViewController.h
//  MyAimerApp
//
//  Created by 蒋博男 on 15/6/18.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "LBaseViewController.h"

typedef enum : NSUInteger {
    kCoupon,
    kGift,
    kFreePost,
    kO2O
} EDetailType;

@interface CouponDetail20ViewController : LBaseViewController
@property (nonatomic, retain) id data;
@property (nonatomic, assign) EDetailType dType;
@end
