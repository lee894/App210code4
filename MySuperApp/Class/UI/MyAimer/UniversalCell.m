//
//  UniversalCell.m
//  MySuperApp
//
//  Created by LEE on 14-9-3.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "UniversalCell.h"

@implementation UniversalCell
@synthesize labelTitle;
@synthesize labelDetail;
@synthesize imgViewBg;

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
@end
