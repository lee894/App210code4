//
//  UIButton+Badge.m
//  ImagePickerDemo
//
//  Created by raozhongxiong on 12-11-23.
//  Copyright (c) 2012年 raozhongxiong. All rights reserved.
//

#import "UIButton+Badge.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIButton (Badge)

- (void)badgeNumber:(int)number
{
    if (self) 
    {
        UIImageView *tmpImgView  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hhws_badge_icon"]];
        tmpImgView.frame = CGRectMake(0, 0, 46/2, 35/2);
        tmpImgView.center = CGPointMake(self.frame.size.width-10, 6);
        tmpImgView.tag = 999;
        [self addSubview:tmpImgView];
//        [tmpImgView release];
        
        UILabel *badgerLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 46/2, 35/2)];
        badgerLab.backgroundColor =[UIColor clearColor];
        badgerLab.textColor = [UIColor whiteColor];
        badgerLab.text = [NSString stringWithFormat:@"%d",number];
        badgerLab.textAlignment = UITextAlignmentCenter;
        badgerLab.center = CGPointMake(self.frame.size.width-10, 6);
        badgerLab.font = [UIFont systemFontOfSize:14];
        badgerLab.adjustsFontSizeToFitWidth = YES;
        badgerLab.tag = 1000;
        [self addSubview:badgerLab];
//        [badgerLab release];
    }
}

- (void)setBadge:(int)badge
{
    if (self) {
        UILabel *lab = (UILabel *)[self viewWithTag:1000];
        UIImageView *imgView  =(UIImageView *)[self viewWithTag:999];
        if (badge == -1) {
            lab.hidden = YES;
            imgView.hidden = YES;
        }
        else
        {
            if (!lab)
            {
                [self badgeNumber:badge];
                lab = (UILabel *)[self viewWithTag:1000];
                imgView  =(UIImageView *)[self viewWithTag:999];
            }
            
            lab.hidden = (badge == 0 ? YES:NO);
            imgView.hidden = (badge == 0 ? YES:NO);
            lab.text = [NSString stringWithFormat:@"%d",badge];
        }
    }
}

@end
