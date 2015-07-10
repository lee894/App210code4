//
//  ButtonInSection.m
//  ChiHao
//
//  Created by user on 12-2-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ButtonInSection.h"
#import "UIColorAdditions.h"
#import "MYMacro.h"
#import "AppDelegate.h"

@implementation ButtonInSection
@synthesize delegate,section,sectionLable,sectionButton,opened,arr,dataDic;

-(id)initWithFrame:(CGRect)frame title:(id)otherID section:(NSInteger )sectionnumber opened:(BOOL)isopened delegate:(id<ButtonInSeactionDelegate>)aDelegate
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toggleAction:)];
        [self addGestureRecognizer:tapGesture];
        self.userInteractionEnabled = YES;

        section  = sectionnumber;
        delegate = aDelegate;
        opened = isopened;
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        imgView.image = [UIImage imageNamed:@"gift_list_bg.png"];
        [self addSubview:imgView];

        
        NSString *actionStr = [otherID objectForKey:@"actionname"];
        NSString *promotion_name = [otherID objectForKey:@"promotion_name"];
        
        CGRect titleLabelFrame = CGRectMake(frame.origin.x+15, frame.origin.y, 40, frame.size.height);
        NSInteger fontSize = 14;
        if (![actionStr isKindOfClass:[NSNull class]]) {
        CGSize size = [actionStr sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
            titleLabelFrame.size.width = size.width;
        }
        
        BOOL isMeet = [[otherID objectForKey:@"ismeet"] boolValue];
        BOOL isSelect = [[otherID objectForKey:@"isSelect"] boolValue];
        
        sectionLable = [[UILabel alloc]initWithFrame:titleLabelFrame];
        sectionLable.backgroundColor = [UIColor clearColor];
        [sectionLable setTextColor:[UIColor blackColor]];
        sectionLable.text = actionStr?actionStr:@"";
        sectionLable.font = [UIFont systemFontOfSize:fontSize];
        [self addSubview:sectionLable];
       
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(sectionLable.frame.origin.x + sectionLable.frame.size.width + 10, 0, 300 - (sectionLable.frame.origin.x + sectionLable.frame.size.width - 10), frame.size.height)];
        [titleLabel setTextColor:[UIColor blackColor]];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel setFont:[UIFont systemFontOfSize:fontSize]];
        titleLabel.text = promotion_name;
        [self addSubview:titleLabel];
        
        if (isMeet || isSelect) {//已满足  红色
            [sectionLable setTextColor:RGBACOLOR(199, 0, 38, 1)];
            [titleLabel setTextColor:RGBACOLOR(199, 0, 38, 1)];
        }

        
        sectionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        sectionButton.frame = CGRectMake(320-50, (44-27/2)/2, 15, 15);
        sectionButton.userInteractionEnabled = NO;
        sectionButton.selected = isopened;
        [self addSubview:sectionButton];
        
        UIImageView *grayLine = [[UIImageView alloc] initWithFrame:CGRectMake(320 -20, 10, 7, 11)];
        CGPoint point = grayLine.center;
        grayLine.tag = 10;
        point.y = frame.size.height/2;
        grayLine.center = point;
        grayLine.image = [UIImage imageNamed:@"arrow.png"];
        [self addSubview:grayLine];

        if (isopened) {
            grayLine.transform = CGAffineTransformMakeRotation(M_PI/2);
        }
    }
    return self;
}

-(IBAction)toggleAction:(id)sender
{
    sectionButton.selected = !sectionButton.selected;
    //旋转图片问题
    UIImageView *tmpImg = (UIImageView *)[self viewWithTag:10];

    if (sectionButton.selected) {
        tmpImg.transform = CGAffineTransformMakeRotation(M_PI/2);

        opened = YES;
        if ([delegate respondsToSelector:@selector(sectionHeaderView:sectionOpened:)]) {
            [delegate sectionHeaderView:self sectionOpened:section];
        }

    }else {
        tmpImg.transform = CGAffineTransformMakeRotation(0);

        opened = NO;
        if ([delegate respondsToSelector:@selector(sectionHeaderView:sectionClosed:)]) {
            [delegate sectionHeaderView:self sectionClosed:section];
        }
    }
}

#pragma mark 隐藏提示框
- (void)hidmpb{
    AppDelegate *appDelegat = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [MBProgressHUD hideHUDForView:appDelegat.window animated:YES];
}



@end
