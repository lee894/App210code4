//
//  OrderCell.h
//  MySuperApp
//
//  Created by LEE on 14-4-5.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrdersOrdersList.h"
#import "UrlImageView.h"

@interface OrderCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UILabel *labelOrderNum;
@property (nonatomic, retain) IBOutlet UILabel *labelTime;
@property (nonatomic, retain) IBOutlet UILabel *labelStatus;
@property (nonatomic, retain) IBOutlet UILabel *labelDelivery;
@property (nonatomic, retain) IBOutlet UILabel *labelDeliveryNum;
@property (nonatomic, retain) IBOutlet UILabel *labelName;
@property (nonatomic, retain) IBOutlet UILabel *labelMoney;

@property (weak, nonatomic) IBOutlet UIImageView *cellbg2;
@property (weak, nonatomic) IBOutlet UIImageView *cellbg3;

//lee999
@property (weak, nonatomic) IBOutlet UrlImageView *orderImage;
@property (weak, nonatomic) IBOutlet UIButton *redBtn;
@property (weak, nonatomic) IBOutlet UIButton *graybtn;

@property (nonatomic, assign)int tag;


- (void)setCellContent:(OrdersOrdersList *)orderList;//设置cell上面的数据

@end
