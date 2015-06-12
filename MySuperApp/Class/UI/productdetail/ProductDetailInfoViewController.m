//
//  ProductDetailInfoViewController.m
//  MySuperApp
//
//  Created by lee on 14-4-8.
//  Copyright (c) 2014年 aimer. All rights reserved.
//

#import "ProductDetailInfoViewController.h"

@interface ProductDetailInfoViewController ()

@end

@implementation ProductDetailInfoViewController
@synthesize isHiddenBar;


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
    self.title = @"商品信息";
    
    [self createBackBtnWithType:0];
    
    //lee894设置首页的高度~~
    //适配屏幕及系统版本
    CGRect frame = CGRectZero;
    if (isIOS7up) {
        if (isHiddenBar) {
            frame = CGRectMake(0, 0, 320, self.view.frame.size.height);
        }else{
            frame = CGRectMake(0, 0, 320, self.view.frame.size.height-40);
        }
    }else{
        if (isHiddenBar) {
            frame = CGRectMake(0, 0, 320, self.view.frame.size.height-40);
        }else{
            frame = CGRectMake(0, 0, 320, self.view.frame.size.height-40-40);
        }
    }
    
    UIWebView *webV = [[UIWebView alloc] initWithFrame:frame];
    webV.scalesPageToFit = YES;
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.url]];
    
    [webV loadRequest:request];
    [self.view addSubview:webV];
    
}


- (void)popBackAnimate:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//iOS 5
- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}
//iOS 6
- (BOOL)shouldAutorotate
{
	return NO;
}
- (NSUInteger)supportedInterfaceOrientations
{
	return UIInterfaceOrientationMaskPortrait;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
	return UIInterfaceOrientationPortrait;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
