//
//  PPBuyCircleCommonCell.h
//  paipaiiphone
//
//  Created by JDMAC on 15-3-26.
//  Copyright (c) 2015年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UrlImageView.h"
#import "NewMaginzeListInfo.h"

@interface PPBuyCircleCommonCell : UITableViewCell


@property (nonatomic,strong) NewMaginzeData *item;
@property (weak, nonatomic) IBOutlet UIButton *delMaginzeBtn;


@property (weak, nonatomic) IBOutlet UrlImageView *showImageV;
@property (strong, nonatomic)IBOutlet  UILabel *showtitleLab;
@property (strong, nonatomic)IBOutlet  UILabel *showDesLab;
@property (strong, nonatomic)IBOutlet  UIView *textBackGroundView;



@end
