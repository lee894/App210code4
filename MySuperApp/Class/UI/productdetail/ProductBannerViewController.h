//
//  ProductBannerViewController.h
//  MySuperApp
//
//  Created by bonan on 14-4-16.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBaseViewController.h"
#import "BluePageControl.h"
@interface ProductBannerViewController : LBaseViewController<UIScrollViewDelegate> {

    IBOutlet UIScrollView *ImageScrollVIew;
    NSArray *bannerArr;
    BluePageControl *_pageControl;

}

@property (nonatomic, assign) NSInteger indexPage;
@property (nonatomic,retain)YKBannerList *arrayForImg;

@end
