//
//  BadgeView.h
//  letao
//
//  Created by caiting on 11-7-26.
//  Copyright 2011 yek. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "Definer.h"

/*
 ios badge ,如果数字太长可能会有问题，一两位数字是没问题
 */
@interface BadgeView : UIView {
	NSMutableArray *nums;
	UIImage *bg_img;
	UIImageView *iv_bg;
	int badgeValue;
}
-(void)setBadge:(int)_badgeValue;
@property int badgeValue;
@end



#define YK_TAG_BADGE_VIEW_SUBVIEW 1322

@interface UIView (addbadge)
/*
 如果当前view 没有badge 则在右上角添加一个YKBadgeView tag=YK_TAG_BADGE_VIEW_SUBVIEW，
 
 use:
 #import "YKBadgeView.h"
 
 [v setBadgeNum:12];
 //如果位置不对，使用下边代码调整
 YKBadgeView* badgeView=[v badgeView];
 v.frame=CGRectMake(****);
 
 */
-(void) setBadgeNum:(int) anum;
-(int) badgeNum;
-(BadgeView*) badgeView;
@end


