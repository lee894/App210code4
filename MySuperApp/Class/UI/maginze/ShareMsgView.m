//
//  ShareMsgView.m
//  MySuperApp
//
//  Created by bonan on 14-3-17.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "ShareMsgView.h"
#import "MYMacro.h"

@implementation ShareMsgView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)awakeFromNib{
    UIView *tempView = [self viewWithTag:306];
    if (isiPhone5) {
        [tempView setFrame:CGRectMake(164, 130, 240, 164)];
    }else{
        [tempView setFrame:CGRectMake(120, 130, 240, 164)];
    }
}

#pragma mark -- 按钮事件
- (IBAction)cancel:(id)sender//取消
{
    [self removeFromSuperview];
}

@end
