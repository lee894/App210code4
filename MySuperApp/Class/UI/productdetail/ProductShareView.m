//
//  ProductShareView.m
//  MySuperApp
//
//  Created by LEE on 14-9-2.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "ProductShareView.h"
#import "MYMacro.h"

@implementation ProductShareView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


-(void)awakeFromNib
{
    UIView *tempView = [self viewWithTag:208];
    if (isiPhone5) {
        [tempView setFrame:CGRectMake(0, 338,320,230)];
    }
}

@end
