    //
//  MyPageControl.m
//  letao
//
//  Created by shiwh on 11-7-25.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MyPageControl.h"
#import "MYMacro.h"

@interface MyPageControl(private)  // 声明一个私有方法, 该方法不允许对象直接使用
- (void)updateDots;
@end

@implementation MyPageControl  

@synthesize imagePageStateNormal;
@synthesize imagePageStateHighlighted;


- (id)initWithFrame:(CGRect)frame { 
	self = [super initWithFrame:frame];
    
    if (isIOS7up) {//是ios7
        self.currentPageIndicatorTintColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:1];
        self.pageIndicatorTintColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];//[UIColor colorWithHexString:@"BDBBBE"];
    }
    
	return self;
}

// 设置正常状态点按钮的图片
- (void)setImagePageStateNormal:(UIImage *)image {  
	imagePageStateHighlighted = image;
	[self updateDots];
}

// 设置高亮状态点按钮图片
- (void)setImagePageStateHighlighted:(UIImage *)image { 
	imagePageStateNormal = image;
	[self updateDots];
}

// 点击事件
- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event { 
	[super endTrackingWithTouch:touch withEvent:event];
	[self updateDots];
}

// 更新显示所有的点按钮
- (void)updateDots { 
		
	if (imagePageStateNormal || imagePageStateHighlighted)
	{
		NSArray *subview = self.subviews;  // 获取所有子视图
		for (NSInteger i = 0; i < [subview count]; i++)
		{
			UIImageView *dot = [subview objectAtIndex:i];
            if ([dot isKindOfClass:[UIImageView class]]) {
                dot.image = self.currentPage == i ? imagePageStateNormal : imagePageStateHighlighted;
            }
		}
	}
}

@end



