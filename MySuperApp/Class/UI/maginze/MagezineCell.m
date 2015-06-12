//
//  MagezineCell.m
//  MySuperApp
//
//  Created by LEE on 14-4-7.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "MagezineCell.h"

@implementation MagezineCell
@synthesize imgsmall,labelBrief,labelTitle;


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
}


@end
