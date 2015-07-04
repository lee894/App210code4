//
//  ManageGiftViewController.h
//  MyAimerApp
//
//  Created by 蒋博男 on 15/6/29.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "CouponListInfoParser.h"
#import "LBaseViewController.h"

@interface ManageGiftViewController : LBaseViewController <UITableViewDataSource, UITableViewDelegate, ServiceDelegate, UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic, retain) CouponInfo* couponInfo;
@end
