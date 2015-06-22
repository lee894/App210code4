//
//  YKCanReuse_webViewController.m
//  YKTemplateIOS5
//
//  Created by 铁柱 007 on 12-1-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "YKCanReuse_webViewController.h"
#import "MYMacro.h"
#import "AppDelegate.h"
#import "SingletonState.h"
#import "UrlImageView.h"
#import "MYCommentAlertView.h"
#import "UrlImageView.h"
#import "BlockAlertView.h"
#import "ImproveInformationViewController.h"


@implementation YKCanReuse_webViewController
@synthesize strTitle;
@synthesize strURL,webType;
@synthesize webViewFrame;
@synthesize sendStrng;
@synthesize isHiddenBar;

- (id)initWithURL:(NSString *)_strURL andTitle:(NSString *)_strTitle {
    if (self = [super init]) {
        
        self.strURL   = _strURL;
        self.strTitle = _strTitle;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.strTitle;
    
    [self createBackBtnWithType:0];
    [self addLeftBtnItems];
    
    webSizeChart = [[UIWebView alloc] init];
    //如果没有传递过来frame的话
    if (self.webViewFrame.size.height < 10) {
        [webSizeChart setFrame:CGRectMake(0, 0, ScreenWidth, self.view.frame.size.height-60)];
    }else{
    //传递过来frame了
        [webSizeChart setFrame:webViewFrame];
    }
    
    [self NewHiddenTableBarwithAnimated:YES];
    
    [webSizeChart setDelegate:self];
    if ([webType isEqualToString:@"text"]) {
        NSString *fontSize = @"16";
        
        [webSizeChart loadHTMLString:[NSString stringWithFormat:@"%@%@%@%@", @"<style type=\"text/css\">img{width:300px;}.newtext{text-indent:2em;font-size:", fontSize, @"px;}</style>", strURL] baseURL:nil];
    }else{
        [webSizeChart loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.strURL]]];
    }
    webSizeChart.scalesPageToFit = YES;
    [self.view addSubview:webSizeChart];
    
    
    //lee999 修改bug   点我为什么要入会——进去页面点返回，后应该记住上一步弹框，不然顾客怎么入会呢
    if ([strTitle isEqualToString:@"尊享卡会员"]) {
        isshowZunxiangKaAlert = YES;
    }else{
        isshowZunxiangKaAlert = NO;
    }
    
    [self initWebViewProgress:webSizeChart];
}

-(void)viewWillAppear:(BOOL)animated{
    
    CGRect barFrame = CGRectMake(0, 0, ScreenWidth, 4);
    _progressView.frame = barFrame;

}


- (void)addLeftBtnItems{
    
    UIView *leftbtnView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    [leftbtnView setBackgroundColor:[UIColor clearColor]];
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"t_ico_back_normal.png"] forState:UIControlStateNormal];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"t_ico_back_hover.png"] forState:UIControlStateHighlighted];
    [backBtn addTarget:self action:@selector(gotoback:) forControlEvents:UIControlEventTouchUpInside];
    backBtn.tag = 1;
    [leftbtnView addSubview:backBtn];
    
    UIButton* navbtnclose = [[UIButton alloc] initWithFrame:CGRectMake(40, 0, 40 , 35)];
    [navbtnclose setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [navbtnclose setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    [navbtnclose.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [navbtnclose addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    [navbtnclose setTitle:@"关闭" forState:UIControlStateNormal];
//    [navbtnclose setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 15)];
    [navbtnclose setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftbtnView addSubview:navbtnclose];
    
    self.navigationItem.hidesBackButton = YES;
    
    UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceButtonItem.width = 1;
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:leftbtnView]];
}

- (void)initWebViewProgress:(UIWebView *)webView{
    
    _progressProxy = [[NJKWebViewProgress alloc] init];
    webView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    
    CGRect barFrame = CGRectMake(0, 0, ScreenWidth, 20);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [self.view addSubview:_progressView];
}
#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:YES];
    
}


-(void)gotoback:(id)sender
{
    if(webSizeChart.canGoBack)
    {
        [webSizeChart goBack];
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)close:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}




-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
//    [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];

    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [SBPublicAlert hideMBprogressHUD:self.view];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{

    [SBPublicAlert hideMBprogressHUD:self.view];

}

- (void)viewDidUnload {
    [super viewDidUnload];
}


@end