//
//  AMServerCenterViewController.m
//  MySuperApp
//
//  Created by lee on 14-3-27.
//  Copyright (c) 2014年 aimer. All rights reserved.
//

#import "AMServerCenterViewController.h"
#import "FeedBackViewController.h"
#import "SizeViewController.h"

#import "YKCanReuse_webViewController.h"

@interface AMServerCenterViewController ()

@end

@implementation AMServerCenterViewController

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
    self.title = @"服务中心";
    [super viewDidLoad];
    
    //创建返回按钮
    [self createBackBtnWithType:0];
    
    [self NewHiddenTableBarwithAnimated:YES];
    
    if (isIOS7up) {
        [myallView setFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
    }
}

- (IBAction)selectbtnType:(UIButton *)sender//进入各个子页面
{
    switch (sender.tag) {
        case 101://意见反馈
        {
            FeedBackViewController *tempFeed = [[FeedBackViewController alloc] initWithNibName:@"FeedBackViewController" bundle:nil];
            [self.navigationController pushViewController:tempFeed animated:YES];
        }
            break;
        case 102://尺码对照
        {
            SizeViewController *tempSize = [[SizeViewController alloc] initWithNibName:@"SizeViewController" bundle:nil];
            [self.navigationController pushViewController:tempSize animated:YES];
        }
            break;
        case 103://支付方式
        {
            YKCanReuse_webViewController *webView = [[YKCanReuse_webViewController alloc] init];
            webView.strURL = @"http://m.aimer.com.cn/method/pay_method";
            webView.strTitle = @"支付方式";
//            webView.webViewFrame = self.view.frame;
            [self.navigationController pushViewController:webView animated:YES];
//            PayViewController *tempPay = [[PayViewController alloc] initWithNibName:@"PayViewController" bundle:nil];
//            [self.navigationController pushViewController:tempPay animated:YES];
        }
            
            break;
        case 104://更改取消订单
        {
            YKCanReuse_webViewController *webView = [[YKCanReuse_webViewController alloc] init];
            webView.strURL = @"http://m.aimer.com.cn/method/orders_edit";
            webView.strTitle = @"更改取消订单";
//            webView.webViewFrame = self.view.frame;
            [self.navigationController pushViewController:webView animated:YES];
            
//            ChangeOrderViewController *tempOrder = [[ChangeOrderViewController alloc] initWithNibName:@"ChangeOrderViewController" bundle:nil];
//            [self.navigationController pushViewController:tempOrder animated:YES];
        }
            break;
        case 105://签收注意事项
        {
            YKCanReuse_webViewController *webView = [[YKCanReuse_webViewController alloc] init];
            webView.strURL = @"http://m.aimer.com.cn/method/attention";
            webView.strTitle = @"签收注意事项";
//            webView.webViewFrame = self.view.frame;
            [self.navigationController pushViewController:webView animated:YES];
            
//            NoteViewController *tempNote = [[NoteViewController alloc] initWithNibName:@"NoteViewController" bundle:nil];
//            [self.navigationController pushViewController:tempNote animated:YES];
        }
            break;
        case 106://运费政策
        {
            YKCanReuse_webViewController *webView = [[YKCanReuse_webViewController alloc] init];
            webView.strURL = @"http://m.aimer.com.cn/method/fees";
            webView.strTitle = @"运费政策";
//            webView.webViewFrame = self.view.frame;
            [self.navigationController pushViewController:webView animated:YES];
            
//            FareViewController *tempFare = [[FareViewController alloc] initWithNibName:@"FareViewController" bundle:nil];
//            [self.navigationController pushViewController:tempFare animated:YES];
        }
            break;
        default:
            break;
    }
    
}

#pragma mark -- 打电话
- (IBAction)makeCall:(id)sender//拨打电话
{
    NSURL *phoneNumberURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", @"4000602008"]];
    [[UIApplication sharedApplication] openURL:phoneNumberURL];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
