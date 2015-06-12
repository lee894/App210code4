//
//  BaseCell.m
//  zf
//
//  Created by malan on 13-7-12.
//  Copyright (c) 2014年 malan. All rights reserved.
//

#import "BaseCell.h"
#import "CouponsListTableViewController.h"

@implementation BaseCell
@synthesize parent;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

- (void)btnOnViewClicked:(UIButton *)btn
{
    [self.parent btnClicked:btn onCell:self];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}

@end
