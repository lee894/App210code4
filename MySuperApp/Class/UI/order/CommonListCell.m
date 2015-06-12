//
//  ProductListCell.m
//  MySuperApp
//
//  Created by LEE on 14-4-5.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "CommonListCell.h"
#import "SingletonState.h"


@implementation CommonListCell

@synthesize imageViewCommodity,labelIntroduce,labelColor,labelSize;
@synthesize textcellAccess1;

@synthesize urlbtn11,urlbtn12,urlbtn13;
@synthesize urlbtn21,urlbtn22,urlbtn23;
@synthesize urlbtn31,urlbtn32,urlbtn33;



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

#pragma mark  textView

@end
