//
//  YKPageControl.h
//  YKTemplateIOS5
//
//  Created by jiang bonan on 12-1-12.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YKPageControlDataSource <NSObject>
//页数
-(NSInteger)numberOfPageInPageControl;
//点之间的间隔
-(float)spacingOfRowInPageControl;
//选中点的图片 一般为7x7大小
- (NSString *)nameOfCurNodePic;
//其他未选中点的图片 大小同选中点
- (NSString *)nameOfOtherNodePic;
//pagecontrol 起始位置 size是自动算好 不用你传
-(CGPoint)originOfPageControl;
//当前页编号
-(NSInteger)currentPageIndex;
@end

@interface YKPageControl : UIView
{
    id<YKPageControlDataSource> dataSource_PageControl;
    float spacing;
    NSInteger itemCount;
    NSString* curNodePic;
    NSString* otherNodePic;
    CGPoint origin;
}
- (id)initWithDataSource:(id<YKPageControlDataSource>)_dataSource_PageControl;
@end
