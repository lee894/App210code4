//
//  BonusCardCell.m
//  爱慕商场
//
//  Created by LEE on 14-8-29.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "BonusCardCell.h"

@implementation BonusCardCell


- (void)awakeFromNib
{
    //按钮加上点击事件
    [self.btnCard addTarget:self action:@selector(btnOnViewClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnUse addTarget:self action:@selector(btnOnViewClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnExchange addTarget:self action:@selector(btnOnViewClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnIntegralHelp addTarget:self action:@selector(btnOnViewClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnExchangeRecord addTarget:self action:@selector(btnOnViewClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.btnCard.tag = 1;
    self.btnUse.tag = 2;
    self.btnExchange.tag = 3;
    self.btnIntegralHelp.tag = 4;
    self.btnExchangeRecord.tag = 5;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
