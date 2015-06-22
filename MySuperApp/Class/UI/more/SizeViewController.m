//
//  SizeViewController.m
//  MySuperApp
//
//  Created by lee on 14-3-27.
//  Copyright (c) 2014年 aimer. All rights reserved.
//

#import "SizeViewController.h"
#import "YKCanReuse_webViewController.h"


@interface SizeViewController ()

@end

@implementation SizeViewController

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

    self.title = @"尺码对照";
    
    [self createBackBtnWithType:0];
    

//    [myscrollingV setFrame:CGRectMake(0, 60, ScreenWidth, self.view.frame.size.height-60)];
//
    [myscrollingV setContentSize:CGSizeMake(ScreenWidth, 600)];
//
//    if (!isIOS8up) {
//        [myallView setFrame:CGRectMake(0, 80, 320, self.view.frame.size.height-80)];
//    }else{
//        
//    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{

//    [myscrollingV setFrame:self.view.frame];
}

#pragma mark -- 按钮事件
- (IBAction)changeType:(UIButton *)sender
{
    
    switch (sender.tag) {
        case 201:
        {
            YKCanReuse_webViewController *webView = [[YKCanReuse_webViewController alloc] init];
            webView.strURL = @"http://m.aimer.com.cn/method/1/size";
            webView.strTitle = @"文胸";
//            webView.webViewFrame = self.view.frame;
            [self.navigationController pushViewController:webView animated:YES];
        }
            break;
            
        case 202:
        {
            YKCanReuse_webViewController *webView = [[YKCanReuse_webViewController alloc] init];
            webView.strURL = @"http://m.aimer.com.cn/method/2/size";
            webView.strTitle = @"内裤";
//            webView.webViewFrame = self.view.frame;
            [self.navigationController pushViewController:webView animated:YES];
        }
            break;
            
        case 203:
        {
            YKCanReuse_webViewController *webView = [[YKCanReuse_webViewController alloc] init];
            webView.strURL = @"http://m.aimer.com.cn/method/3/size";
            webView.strTitle = @"睡衣";
//            webView.webViewFrame = self.view.frame;
            [self.navigationController pushViewController:webView animated:YES];
        }
            break;
            
        case 204:
        {
            YKCanReuse_webViewController *webView = [[YKCanReuse_webViewController alloc] init];
            webView.strURL = @"http://m.aimer.com.cn/method/8/size";
            webView.strTitle = @"塑身衣";
//            webView.webViewFrame = self.view.frame;
            [self.navigationController pushViewController:webView animated:YES];
        }
            break;
            
            
        case 205:
        {
            YKCanReuse_webViewController *webView = [[YKCanReuse_webViewController alloc] init];
            webView.strURL = @"http://m.aimer.com.cn/method/4/size";
            webView.strTitle = @"泳衣";
//            webView.webViewFrame = self.view.frame;
            [self.navigationController pushViewController:webView animated:YES];
        }
            break;
            
        case 206:
        {
            YKCanReuse_webViewController *webView = [[YKCanReuse_webViewController alloc] init];
            webView.strURL = @"http://m.aimer.com.cn/method/5/size";
            webView.strTitle = @"保暖衣";
//            webView.webViewFrame = self.view.frame;
            [self.navigationController pushViewController:webView animated:YES];
        }
            break;
            
        case 207:
        {
            YKCanReuse_webViewController *webView = [[YKCanReuse_webViewController alloc] init];
            webView.strURL = @"http://m.aimer.com.cn/method/6/size";
            webView.strTitle = @"运动";
//            webView.webViewFrame = self.view.frame;
            [self.navigationController pushViewController:webView animated:YES];
        }
            break;
            
        case 208:
        {
            YKCanReuse_webViewController *webView = [[YKCanReuse_webViewController alloc] init];
            webView.strURL = @"http://m.aimer.com.cn/method/7/size";
            webView.strTitle = @"基础内衣";
//            webView.webViewFrame = self.view.frame;
            [self.navigationController pushViewController:webView animated:YES];
        }
            break;
            
        case 209:
        {
            YKCanReuse_webViewController *webView = [[YKCanReuse_webViewController alloc] init];
            webView.strURL = @"http://m.aimer.com.cn/method/24/size";
            webView.strTitle = @"配饰";
//            webView.webViewFrame = self.view.frame;
            [self.navigationController pushViewController:webView animated:YES];
        }
            break;
            
        default:
            break;
    }
}


@end
