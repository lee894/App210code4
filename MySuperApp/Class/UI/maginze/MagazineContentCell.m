//
//  MagazineContentCell.m
//  MySuperApp
//
//  Created by LEE on 14-4-7.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "MagazineContentCell.h"


@implementation MagazineContentCell
@synthesize imageBig;
@synthesize labelTitle,textContext;
@synthesize buttonBigImg;
@synthesize myScrollview;

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
