//
//  BonusCardCell.h
//  爱慕商场
//
//  Created by LEE on 14-8-29.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCell.h"
@interface BonusCardCell : BaseCell

@property (nonatomic, retain) IBOutlet UILabel *V6cardlabelTitle;


@property (nonatomic, retain) IBOutlet UILabel *labelTitle;
@property (nonatomic, retain) IBOutlet UILabel *labelId;
@property (nonatomic, retain) IBOutlet UILabel *labelBalance;
@property (nonatomic, retain) IBOutlet UILabel *labelFrozenBalance;
@property (nonatomic, retain) IBOutlet UIButton *btnCard;
@property (nonatomic, retain) IBOutlet UILabel *labelIntegral;//积分
@property (nonatomic, retain) IBOutlet UIButton *btnUse;//使用
@property (nonatomic, retain) IBOutlet UIButton *btnExchange;//兑换
@property (nonatomic, retain) IBOutlet UIButton *btnIntegralHelp;//积分说明
@property (nonatomic, retain) IBOutlet UIButton *btnExchangeRecord;//自助兑换记录

@property (nonatomic, retain) IBOutlet UILabel *labelcardState;// 积分卡的状态





@end
