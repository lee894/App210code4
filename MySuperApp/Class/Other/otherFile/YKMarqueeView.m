//
//  YKMarqueeView.m
//  womaiw
//
//  Created by cai cating on 12-10-23.
//  Copyright (c) 2012年 yek. All rights reserved.
//

#import "YKMarqueeView.h"

@implementation YKMarqueeView


- (id)initWithFrame:(CGRect)frame andTitle:(NSString*)_title andTimeInterval:(NSTimeInterval)_timeInterval andFontSize:(NSInteger)_fontSize andTextColor:(UIColor*)_color
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UILabel* title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [_title sizeWithFont:[UIFont systemFontOfSize:_fontSize]].width, frame.size.height)];
        [title setTextAlignment:NSTextAlignmentCenter];
        [title setFont:[UIFont systemFontOfSize:_fontSize]];
        [title setText:_title];
        [title setTextColor:_color];
        [title setBackgroundColor:[UIColor clearColor]];
        [self setClipsToBounds:YES];
        [title setLineBreakMode:NSLineBreakByClipping];
        [self addSubview:title];
        [title release];
        int width = [title.text sizeWithFont:title.font].width;
        if (width > frame.size.width) {
            [title setFrame:CGRectMake(20, 0, title.frame.size.width, title.frame.size.height)];
            timer = [NSTimer scheduledTimerWithTimeInterval:_timeInterval target:self selector:@selector(start:) userInfo:title repeats:YES];
        }else {
            [title setFrame:CGRectMake((frame.size.width - title.frame.size.width) / 2, 0, title.frame.size.width, title.frame.size.height)];
        }
    }
    return self;
}

-(void)start:(id)sender
{
    UILabel* lbl = ((NSTimer*)sender).userInfo;
    int x = lbl.frame.origin.x;
    int strWidth = [lbl.text sizeWithFont:lbl.font].width;
    if (x < -strWidth) {
        lbl.frame=CGRectMake(self.frame.size.width, 0, lbl.frame.size.width, lbl.frame.size.height);
    }else {
        lbl.frame=CGRectMake(x -= 3, 0, lbl.frame.size.width, lbl.frame.size.height);
    }
}

-(void)stop
{
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
}


@end
