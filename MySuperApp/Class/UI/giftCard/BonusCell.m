//
//  BonusCell.m
//  爱慕商场
//
//  Created by LEE on 14-7-31.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "BonusCell.h"

@implementation BonusCell

- (void)awakeFromNib
{
    //按钮加上点击事件
    [self.btnBonus addTarget:self action:@selector(btnOnViewClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonUsed addTarget:self action:@selector(btnOnViewClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.btnBonus.tag = 6;
    self.buttonUsed.tag = 7;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
