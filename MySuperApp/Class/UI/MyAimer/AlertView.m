//
//  AlertView.m
//  MySuperApp
//
//  Created by bonan on 14-9-16.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "AlertView.h"

@implementation AlertView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (IBAction)btnNoClick:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(alertViewWithStates:)]) {
        [self.delegate alertViewWithStates:NO];
    }
}

- (IBAction)btnYesClick:(UIButton *)sender
{
    NSLog(@"noyes");
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(alertViewWithStates:)]) {
        [self.delegate alertViewWithStates:YES];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
