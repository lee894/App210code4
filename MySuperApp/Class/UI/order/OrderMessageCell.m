//
//  OrderMessageCell.m
//  MySuperApp
//
//  Created by LEE on 14-4-5.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "OrderMessageCell.h"

@implementation OrderMessageCell
@synthesize labelOrderNum,labelPayMode,labelStatus,labelFare,labelCouponMoney,labelCouponMessage,labelOrderMoney;

@synthesize paynowBtn;

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


@end
