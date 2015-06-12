//
//  OrderMessageCell.h
//  MySuperApp
//
//  Created by LEE on 14-4-5.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderMessageCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UILabel *labelOrderNum;
@property (nonatomic, retain) IBOutlet UILabel *labelPayMode;
@property (nonatomic, retain) IBOutlet UILabel *labelStatus;
@property (nonatomic, retain) IBOutlet UILabel *labelFare;
@property (nonatomic, retain) IBOutlet UILabel *labelCouponMoney;
@property (nonatomic, retain) IBOutlet UILabel *labelCouponMessage;
@property (retain, nonatomic) IBOutlet UILabel *labelDemicMessage;
@property (nonatomic, retain) IBOutlet UILabel *labelOrderMoney;


//lee999新增
//立即支付
@property (retain, nonatomic) IBOutlet UIButton *paynowBtn;
@property (weak, nonatomic) IBOutlet UILabel *labordertime;
@property (weak, nonatomic) IBOutlet UILabel *labsendtype;
@property (weak, nonatomic) IBOutlet UILabel *laborderallprice;
@property (weak, nonatomic) IBOutlet UILabel *labgetscore;
//end

@end
