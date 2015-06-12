//
//  NewMaginzeBViewControllerV2.h
//  MyAimerApp
//
//  Created by yanglee on 15/5/2.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "LBaseViewController.h"
#import "OTPageView.h"


@interface NewMaginzeBViewControllerV2 : LBaseViewController<UIScrollViewDelegate,ServiceDelegate>
{
//    UIScrollView *scrollView;
    OTPageView *PScrollView;
}

@property(nonatomic,retain)NSString *strMaginzeId;

@property(nonatomic,assign)BOOL isFromHomePageAndShowSepBtn;  //是否来自首页，如果首页，就显示切换按钮。 如果不是就不显示

@end
