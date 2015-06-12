//
//  YKSplashView.h
//  LafasoGroupBuy
//
//  Created by HQS on 12-10-30.
//
//

#import <UIKit/UIKit.h>
#import "BluePageControl.h"

@interface YKSplashView : UIScrollView<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    BluePageControl *_pageControl;
}

+ (BOOL)getIsOpenGuideView;

@end
