//
//  YKMarqueeView.h
//  womaiw
//
//  Created by cai cating on 12-10-23.
//  Copyright (c) 2012年 yek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKMarqueeView : UIView
{
    @private
    NSTimer* timer;
}

-(void)stop;
- (id)initWithFrame:(CGRect)frame andTitle:(NSString*)_title andTimeInterval:(NSTimeInterval)_timeInterval andFontSize:(NSInteger)_fontSize andTextColor:(UIColor*)_color;
@end
