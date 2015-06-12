//
//  BluePageController.m
//  ReadNovelProject
//
//  Created by eastedge on 12-7-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BluePageControl.h"
#import "MYMacro.h"

@implementation BluePageControl
@synthesize activeImage,inactiveImage;

-(id)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        
        self.activeImage = [UIImage imageNamed:@"guide_dot_red.png"];
        self.inactiveImage = [UIImage imageNamed:@"guide_dot_white.png"];

        self.imgSize = CGSizeMake(6, 6);
        
        
        //这个是设置 pagecontrol 的颜色的！！！
        if (isIOS7up) {//是ios7
            self.currentPageIndicatorTintColor = [UIColor colorWithHexString:@"F11A4A"];//[UIColor colorWithRed:1 green:0 blue:0 alpha:1];
            self.pageIndicatorTintColor = [UIColor colorWithHexString:@"BBBBBB"];//[UIColor colorWithRed:1 green:1 blue:1 alpha:0.4];
        }
    }
    return self;
}
-(void)updateDots{
    for (int i=0; i<[self.subviews count]; i++) {
        UIImageView *dot=[self.subviews objectAtIndex:i];
        CGRect rect = dot.frame;
        if ([dot isKindOfClass:[UIImageView class]]) {

        rect.size = self.imgSize;
        dot.frame = rect;
        if (i==self.currentPage) {
            dot.image=self.activeImage;
        }else{
            dot.image=self.inactiveImage;
        }
        }
    }
}


-(void)setCurrentPage:(NSInteger)currentPage{
    [super setCurrentPage:currentPage];
    [self updateDots];
}



@end
