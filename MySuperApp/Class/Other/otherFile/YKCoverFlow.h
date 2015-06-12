////
////  YKCoverFlow.h
////  YKTemplateIOS5
////
////  Created by jiang bonan on 12-2-2.
////  Copyright 2012年 __MyCompanyName__. All rights reserved.
////
//
//#import <UIKit/UIKit.h>
//#import "iCarousel.h"
//#import "YKPageControl.h"
//
//@interface UIImage (AFUIImageReflection)
//
//- (UIImage *)addImageReflection:(CGFloat)reflectionFraction;
//
//@end
//
//typedef enum
//{
//    YKCoverFlowTypeBanner = 0,
//    YKCoverFlowTypeCoverFlow,
//    YKCoverFlowTypeDetailProductList,
//    YKCoverFlowTypeBannerOne,    //只显示一个
//    YKCoverFlowTypeBannerScrolling,  //这个是不按照分页进行切换了，而是一点点的进行滚动了，注意
//}
//YKCoverFlowType;
//
//@class YKCoverFlow;
//@protocol YKCoverFlowDataSource <NSObject>
//@required
//-(NSInteger)numberOfItemsInCoverFlow:(YKCoverFlow*)aCoverFlow;
////if is a banner
//@optional
//-(NSInteger)timeIntervalOfBanner:(YKCoverFlow*)aCoverFlow;
//-(CGPoint)originOfPageControlInBanner:(YKCoverFlow*)aCoverFlow;
//@end
//
//@protocol YKCoverFlowDelegate <NSObject>
//@required
//- (UIView *)coverFlow:(YKCoverFlow *)aCoverFlow viewForItemAtIndex:(NSUInteger)index;
//- (void)coverFlow:(YKCoverFlow *)aCoverFlow didSelectItemAtIndex:(NSInteger)index;
//@end
//
//@interface YKCoverFlow : UIView <iCarouselDelegate, iCarouselDataSource, YKPageControlDataSource>
//{
//    NSTimer* timer;
//    iCarousel *carousel;
//    YKCoverFlowType type;
//    BOOL wrap;
//    YKPageControl* pc;
//    id<YKCoverFlowDataSource> dataSource_cf;
//    id<YKCoverFlowDelegate> delegate_cf;
//}
//@property (retain, nonatomic) id<YKCoverFlowDataSource> dataSource_cf;
//@property (retain, nonatomic) id<YKCoverFlowDelegate> delegate_cf;
//@property (nonatomic, readonly) YKCoverFlowType type;
//@property (nonatomic, readonly) iCarousel *carousel;
//- (id)initWithFrame:(CGRect)frame andCoverFlowType:(YKCoverFlowType)_type andWrap:(BOOL)_wrap andDelegate:(id<YKCoverFlowDelegate>)_delegate_cf andDataSource:(id<YKCoverFlowDataSource>)_dataSource_cf andCurIndex:(NSInteger)_curIndex;
//@end
