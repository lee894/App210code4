//
//  WeiBoViewController.h
//  MySuperApp
//
//  Created by LEE on 14-4-14.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "LBaseViewController.h"

@interface WeiBoViewController :LBaseViewController <UIWebViewDelegate>

@property (nonatomic, retain) IBOutlet UIWebView *webWeibo;
@property (nonatomic, retain) UIView *opaqueView;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, retain) NSString *weiboUrl;


@end
