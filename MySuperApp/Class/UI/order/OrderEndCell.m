//
//  EndCell.m
//  MySuperApp
//
//  Created by LEE on 14-4-5.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "OrderEndCell.h"

@implementation OrderEndCell

@synthesize buttonLogistics;
//@synthesize labpayprice,labpayname222;

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

- (void)setImageAndTitlewithRow:(NSInteger)section andBool:(NSInteger )suitCount
{
    NSInteger row = 6;
    if (suitCount >0) {
        row--;
    }
    
    if (section == row+suitCount) {
        
        [self.buttonLogistics setBackgroundImage:[UIImage imageNamed:@"add_like_btn.png"] forState:UIControlStateNormal];
        [self.buttonLogistics setBackgroundImage:[UIImage imageNamed:@"add_like_btn_press.png"] forState:UIControlStateHighlighted];
        [self.buttonLogistics setTitleColor:[UIColor colorWithRed:99.0/255.0 green:99.0/255.0 blue:99.0/255.0 alpha:1] forState:UIControlStateNormal];
        [self.buttonLogistics setTitleColor:[UIColor colorWithRed:99.0/255.0 green:99.0/255.0 blue:99.0/255.0 alpha:1] forState:UIControlStateHighlighted];
        [self.buttonLogistics setTitle:@"取消订单" forState:UIControlStateNormal];
        [self.buttonLogistics setTitle:@"取消订单" forState:UIControlStateHighlighted];
        self.buttonLogistics.tag = 6;
    
    }else if (section == row+suitCount+1){
        

        [self.buttonLogistics setTitle:@"立即支付" forState:UIControlStateNormal];
        [self.buttonLogistics setTitle:@"立即支付" forState:UIControlStateHighlighted];
        [self.buttonLogistics setBackgroundImage:[UIImage imageNamed:@"btn_red_a_normal.png"] forState:UIControlStateNormal];
        [self.buttonLogistics setBackgroundImage:[UIImage imageNamed:@"btn_red_a_hover.png"] forState:UIControlStateHighlighted];
        [self.buttonLogistics setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.buttonLogistics setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        self.buttonLogistics.tag = 5;
    }
    
    if (section == 999222){

        [self.buttonLogistics setBackgroundImage:[UIImage imageNamed:@"btn_red_a_normal.png"] forState:UIControlStateNormal];
        [self.buttonLogistics setBackgroundImage:[UIImage imageNamed:@"btn_red_a_hover.png"] forState:UIControlStateHighlighted];
        [self.buttonLogistics setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.buttonLogistics setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [self.buttonLogistics setTitle:@"查看物流" forState:UIControlStateNormal];
        [self.buttonLogistics setTitle:@"查看物流" forState:UIControlStateHighlighted];
        self.buttonLogistics.tag = 1;
    }
}


@end
