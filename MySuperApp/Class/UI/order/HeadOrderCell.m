//
//  HeadCell.m
//  MySuperApp
//
//  Created by LEE on 14-4-5.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "HeadOrderCell.h"

@implementation HeadOrderCell
@synthesize labelHead;

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
}

- (void)setName:(NSInteger)section andBool:(NSInteger)Count{
    
    
    if (section == 0) {
        self.labelHead.text = @"订单信息";

    }else if (section == 2) {
        self.labelHead.text = @"商品清单";

    }else if(section == 4 +Count) {
        self.labelHead.text = @"收货人信息";

    }else if(section == 5 +Count){
        
        self.labelHead.text = @"订单附言";
    }
}


@end
