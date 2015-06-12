//
//  WeiBoViewController.m
//  MySuperApp
//
//  Created by LEE on 14-4-14.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "WeiBoViewController.h"

@interface WeiBoViewController ()

@end

@implementation WeiBoViewController
@synthesize webWeibo,activityIndicator,opaqueView;
@synthesize weiboUrl;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self createBackBtnWithType:0];
    [self setTitle:@"新浪微博"];
    
    NSURL *url = [NSURL URLWithString:self.weiboUrl];
    [self.webWeibo loadRequest:[NSURLRequest requestWithURL:url]];
    
    UIView *tempView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,  ScreenHeight, ScreenWidth-foottableHeight)];
    self.opaqueView = tempView;
    
    UIActivityIndicatorView *tempActivity = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 32, 32)];
    self.activityIndicator = tempActivity;
    
    [self.activityIndicator setCenter:self.opaqueView.center];
    [self.activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    [self.opaqueView setBackgroundColor:[UIColor blackColor]];
    self.opaqueView.alpha = 0.6;
    
    [self.view addSubview:self.opaqueView];
    [self.opaqueView addSubview:self.activityIndicator];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -- 按钮事件
- (IBAction)quit:(id)sender//返回
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void )webViewDidFinishLoad:(UIWebView *)webView {
    
    [activityIndicator stopAnimating];
    
    self.opaqueView.hidden  = YES ;
}

- (void )webViewDidStartLoad:(UIWebView *)webView {
    
    [ activityIndicator startAnimating ];
    
    self.opaqueView.hidden  = NO ;
    
}

@end
