//
//  AimerHeadCell.m
//  MySuperApp
//
//  Created by LEE on 14-3-30.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "AimerHeadCell.h"
#import "MoerUserinfo.h"

@implementation AimerHeadCell

@synthesize buttonintegral,changeBut,InfterFaceBut;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setContent:(MoerUserinfo *)userInfo//购物车，待处理，待评价内容
{
    int shopcount = (int)userInfo.shopcartcount;
    int noaccess = (int)userInfo.norates;
    labelShopCar.text = [NSString stringWithFormat:@"%d",shopcount];
    labelName.text = userInfo.username;
    
    labelUnhandel.text = [userInfo.nodispose isKindOfClass:[NSNull class]] ? @"0" : userInfo.nodispose;
    labelUnaccess.text = [NSString stringWithFormat:@"%d",noaccess];
    
    NSString *strInteral = [NSString stringWithFormat:@"%@  >",userInfo.validScore == nil?@"0":userInfo.validScore];
    
    [self.buttonintegral setTitle:strInteral forState:UIControlStateNormal];
    [self.buttonintegral setTitle:strInteral forState:UIControlStateHighlighted];
}

@end
