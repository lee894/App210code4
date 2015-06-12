//
//  EndCell.m
//  MySuperApp
//
//  Created by LEE on 14-4-5.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "OrderpaynowEndCell.h"

@implementation OrderpaynowEndCell

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
        
        [self.buttonLogistics setTitle:@"立即支付" forState:UIControlStateNormal];
        [self.buttonLogistics setTitle:@"立即支付" forState:UIControlStateHighlighted];
        [self.buttonLogistics setBackgroundImage:[UIImage imageNamed:@"button_red.png"] forState:UIControlStateNormal];
        [self.buttonLogistics setBackgroundImage:[UIImage imageNamed:@"button_red_press.png"] forState:UIControlStateHighlighted];
        [self.buttonLogistics setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.buttonLogistics setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        self.buttonLogistics.tag = 5;
    }
    
    
}


@end
