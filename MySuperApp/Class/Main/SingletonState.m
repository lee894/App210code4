//
//  SingletonState.m
//  teaShop
//
//  Created by lee on 14-3-11.
//  Copyright (c) 2014年 com.youzhong.iphone. All rights reserved.
//

#import "SingletonState.h"
#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@implementation SingletonState
{
    
    
}

@synthesize userHasLogin;
@synthesize myaimerIsFrom;

@synthesize isShareSDK;

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}


+ (SingletonState*)sharedStateInstance {
	
	static SingletonState *sharedStateInstance;
	
	@synchronized(self) {
		if(!sharedStateInstance) {
			sharedStateInstance = [[SingletonState alloc] init];
		}
	}
	return sharedStateInstance;
}


//lee给view设置为圆角，不再使用图片了。
+(id)setViewRadioSider:(UIView*)sender{
    
    sender.layer.borderColor = [UIColor colorWithHexString:@"#dddddd"].CGColor;
    sender.layer.borderWidth =1.0;
    sender.layer.cornerRadius =10.0;
    
    return sender;
}

/*  设置 某个角为圆角
 view2.layer.borderColor = [UIColor colorWithHexString:@"#dddddd"].CGColor;
 view2.layer.borderWidth =1.0;
UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view2.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
maskLayer.frame = view2.bounds;
maskLayer.path = maskPath.CGPath;
view2.layer.mask = maskLayer;
其中，
byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight
指定了需要成为圆角的角。该参数是UIRectCorner类型的，可选的值有：
* UIRectCornerTopLeft
* UIRectCornerTopRight
* UIRectCornerBottomLeft
* UIRectCornerBottomRight
* UIRectCornerAllCorners
*/

/*
 [UIView animateWithDuration:0.3 animations:^{
 [self.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
 }];
 
 [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionRepeat animations:^{
 dackBtn.hidden = YES;
 dackBtn.alpha = 0.0;
 } completion:^(BOOL finished) {
 }];
 
 */


@end
