//  Created by Rafael Kayumov (RealPoc).
//  Copyright (c) 2014 Rafael Kayumov. License: MIT.

#import <UIKit/UIKit.h>
#import "RKTabItem.h"

typedef struct HorizontalEdgeInsets {
    CGFloat left, right;
} HorizontalEdgeInsets;

static inline HorizontalEdgeInsets HorizontalEdgeInsetsMake (CGFloat left, CGFloat right) {
    HorizontalEdgeInsets insets = {left, right};
    return insets;
}

@class RKTabItem;
@class RKTabView;

@protocol RKTabViewDelegate <NSObject>

//Called for all types except TabTypeButton
- (void)tabView:(RKTabView *)tabView tabBecameEnabledAtIndex:(NSInteger)index tab:(RKTabItem *)tabItem;
//Called Only for unexcludable items. (TabTypeUnexcludable)
- (void)tabView:(RKTabView *)tabView tabBecameDisabledAtIndex:(NSInteger)index tab:(RKTabItem *)tabItem;

@end

@interface RKTabView : UIView

@property (nonatomic, assign) IBOutlet id<RKTabViewDelegate> delegate;
@property (readwrite) BOOL darkensBackgroundForEnabledTabs;
@property (readwrite) BOOL drawSeparators;
@property (nonatomic, strong) UIColor *enabledTabBackgrondColor;
@property (nonatomic, strong) UIFont *titlesFont;
@property (nonatomic, strong) UIColor *titlesFontColor;
@property (nonatomic, strong) UIColor *titlesEnableFontColor;//按钮可用时候的颜色
@property (nonatomic, strong) NSArray *tabItems;
@property (nonatomic, strong) UIImage *backgroundImg;
@property (nonatomic, readwrite) HorizontalEdgeInsets horizontalInsets;

- (id)initWithFrame:(CGRect)frame andTabItems:(NSArray *)tabItems;

@end
