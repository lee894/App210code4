//
//  CancelOrderViewController.h
//  MySuperApp
//
//  Created by LEE on 14-4-5.
//  Copyright (c) 2014年 zan. All rights reserved.
//



#import "LBaseViewController.h"

@interface CancelOrderViewController : LBaseViewController<ServiceDelegate,UIAlertViewDelegate>
{
    UIButton *buttonlast;
    MainpageServ *mainSev;
    
    IBOutlet UIButton *buttonCancel;
}

@property (nonatomic, retain) NSString *orderid;
@property (nonatomic, retain) NSString *userName;
@property (nonatomic, retain) NSString *payWay;


@property (nonatomic, assign) BOOL isCar;

- (IBAction)cancelReason:(UIButton *)sender;//取消订单的原因
- (IBAction)cancelOrder:(id)sender;//取消订单
@end
