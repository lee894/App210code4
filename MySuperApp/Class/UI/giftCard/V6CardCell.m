//
//  V6CardCell.m
//  爱慕商场
//
//  Created by malan on 14-9-26.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "V6CardCell.h"

@implementation V6CardCell


- (void)awakeFromNib
{
    //按钮加上点击事件
    [_btnCancel addTarget:self action:@selector(btnOnViewClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

@end
