//
//  MyPageControl.h
//  letao
//
//  Created by shiwh on 11-7-25.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MyPageControl : UIPageControl {
	UIImage *imagePageStateNormal;
	UIImage *imagePageStateHighlighted;

}

- (id)initWithFrame:(CGRect)frame;

@property (nonatomic, retain) UIImage *imagePageStateNormal;
@property (nonatomic, retain) UIImage *imagePageStateHighlighted;

- (void)updateDots;
- (void)setImagePageStateHighlighted:(UIImage *)image; 
- (void)setImagePageStateNormal:(UIImage *)image;

@end
