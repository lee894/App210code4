//
//  NewTrendViewController.h
//  MySuperApp
//
//  Created by LEE on 14-7-24.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBaseViewController.h"
#import "WaterFlowView.h"
#import "MainpageServ.h"
#import "ChaoliuChaoliuxinpinModel.h"
#import "UrlImageView.h"

//潮流新品
@interface NewTrendViewController : LBaseViewController <WaterFlowViewDelegate,WaterFlowViewDataSource,UIScrollViewDelegate,ServiceDelegate>
{
    float _firstHeight;
    float _secondHeight;
    
    WaterFlowView *waterFlow;
    NSArray *arrIcon;
    
    NSMutableArray *arrayFirst;
    NSMutableArray *arraySecond;
    
    ChaoliuChaoliuxinpinModel *chaoliuModel;
    
}



@property (nonatomic, retain) IBOutlet UIImageView *imgBackground;
@property (nonatomic, retain) NSString *brandName;
@property (nonatomic, assign) NSInteger index;//当前显示那个背景图片
@property (nonatomic, retain) NSArray *arrayImg;

@end
