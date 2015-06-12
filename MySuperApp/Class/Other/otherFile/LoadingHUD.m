

//
//  LoadingHUD.m
//  paipaiiphone
//
//  Created by 蒋博男 on 14-10-20.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "AppDelegate.h"
#import "LoadingHUD.h"
#import "UIImage+ImageEffects.h"

@implementation LoadingHUD

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+(void)startLoadingwithtext:(NSString*)text
{
    if ([((AppDelegate*)[UIApplication sharedApplication].delegate).window viewWithTag:982839478]) {
        [LoadingHUD stopLoading];
    }
    
    UIView *_blurView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _blurView.tag = 982839478;
    _blurView.layer.backgroundColor = [UIColor colorWithRed:70.0/255.0 green:52.0/255.0 blue:23.0/255.0f    alpha:.2].CGColor;
    

    
    [((AppDelegate*)[UIApplication sharedApplication].delegate).window addSubview:_blurView];
    
    
    UIView* vBG = [[UIView alloc] initWithFrame:CGRectMake((_blurView.frame.size.width - 100) / 2, (_blurView.frame.size.height - 106) / 2, 100, 106)];
    [vBG.layer setCornerRadius:5];
    [vBG.layer setMasksToBounds:YES];
    [vBG setBackgroundColor:[UIColor whiteColor]];
    [_blurView addSubview:vBG];
    
    UIImageView* ivLoading = [[UIImageView alloc] initWithFrame:CGRectMake(37.5, 30, 25, 25)];
    [ivLoading setImage:[UIImage imageNamed:@"picLoading"]];
    [vBG addSubview:ivLoading];
    
    UILabel* lblMsg = [[UILabel alloc] initWithFrame:CGRectMake(0, 85, vBG.frame.size.width, 11)];
    [lblMsg setText:text];
    [lblMsg setTextColor:[UIColor colorWithHexString:@"#463417"]];
    [lblMsg setFont:[UIFont systemFontOfSize:11]];
    [lblMsg setTextAlignment:NSTextAlignmentCenter];
    [vBG addSubview:lblMsg];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.delegate = self;
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI / 2, 0, 0, 1)];
    animation.duration = 0.25;
    animation.cumulative = YES;
    animation.repeatCount = INT_MAX;
    
    [ivLoading.layer addAnimation:animation forKey:@"animation"];
}

+(void)stopLoading
{
    [[((AppDelegate*)[UIApplication sharedApplication].delegate).window viewWithTag:982839478] removeFromSuperview];
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
