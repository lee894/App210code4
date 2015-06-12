//
//  YKPageControl.m
//  YKTemplateIOS5
//
//  Created by jiang bonan on 12-1-12.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "YKPageControl.h"

@implementation YKPageControl

-(id)initWithDataSource:(id<YKPageControlDataSource>)_dataSource_PageControl;
{
    self = [super init];
    if (self) {
        dataSource_PageControl = _dataSource_PageControl;
        
        spacing = [dataSource_PageControl spacingOfRowInPageControl];
        itemCount = [dataSource_PageControl numberOfPageInPageControl];
        curNodePic = [dataSource_PageControl nameOfCurNodePic];
        otherNodePic = [dataSource_PageControl nameOfOtherNodePic];
        origin = [dataSource_PageControl originOfPageControl];
        // Initialization code
        [self setFrame:CGRectMake(origin.x, origin.y, itemCount * (spacing + [UIImage imageNamed:curNodePic].size.width) - spacing, [UIImage imageNamed:curNodePic].size.height)];
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    UIImage* imgCurNode = [UIImage imageNamed:curNodePic];
//    NSLog(@"%f, %f", imgCurNode.size.width, imgCurNode.size.height);
    UIImage* imgOtherNode = [UIImage imageNamed:otherNodePic];
//    NSLog(@"%f, %f", imgOtherNode.size.width, imgOtherNode.size.height);
    for (int i = 0; i < itemCount; ++i) {
        if (i == [dataSource_PageControl currentPageIndex]) {
            [imgCurNode drawInRect:CGRectMake(i * (spacing + imgCurNode.size.width), 0, imgCurNode.size.width, imgCurNode.size.height)];
        }else
        {
            [imgOtherNode drawInRect:CGRectMake(i * (spacing + imgOtherNode.size.width), 0, imgOtherNode.size.width, imgOtherNode.size.height)];
        }
    }
}


@end
