//
//  YKCanReuse_webViewController.h
//  YKTemplateIOS5
//
//  Created by 铁柱 007 on 12-1-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
//尺码对照表

#import <UIKit/UIKit.h>
#import "LBaseViewController.h"
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"

@interface YKCanReuse_webViewController : LBaseViewController<UIWebViewDelegate,NJKWebViewProgressDelegate> {
    
    UIWebView* webSizeChart;
    
    BOOL isshowZunxiangKaAlert;  //是否显示会员卡激活的alertview
    
    
    NJKWebViewProgress *_progressProxy;
    NJKWebViewProgressView *_progressView;
}


@property(nonatomic,strong)NSString* strTitle;
@property(nonatomic,strong)NSString* strURL;

@property(nonatomic,strong)NSString* webType;
@property(nonatomic,assign)CGRect webViewFrame;

@property(nonatomic,strong)NSString* sendStrng;


@property(nonatomic,assign)BOOL isHiddenBar;


- (id)initWithURL:(NSString *)_strURL andTitle:(NSString *)_strTitle;


@end
