//
//  UIView+LayoutFrame.h
//  Lottery
//
//  Created by lee on 14-4-8.
//  Copyright (c) 2014年 houpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LayoutFrame)

- (CGFloat)x;
- (CGFloat)y;

- (CGFloat)height;

- (CGFloat)width;

- (void)setX:(CGFloat)x;
- (void)setY:(CGFloat)y;

- (void)setWidth:(CGFloat)width;

- (void)setHeight:(CGFloat)height;

@end
