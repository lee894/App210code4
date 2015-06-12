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
}


//lee999 修改bug   点我为什么要入会——进去页面点返回，后应该记住上一步弹框，不然顾客怎么入会呢
-(void)viewDidDisappear:(BOOL)animated{

    //如果显示尊享卡会员的话，继续弹出alertview
//    if (isshowZunxiangKaAlert) {
//        BlockAlertView *alert = [[BlockAlertView alloc]initWithTitle:@"爱慕提示" message:@"此次购物完成后可以成为爱慕集团尊享卡会员，请问您是否愿意加入？"];
//        alert.isTag = YES;
//        [alert setDestructiveButtonWithTitle:@"我为什么要入会？>" block:^(void) {
//            
//            YKCanReuse_webViewController *webView = [[YKCanReuse_webViewController alloc] init];
//            webView.strURL = @"http://m.aimer.com.cn/method/v6codeinfo";
//            webView.strTitle = @"尊享卡会员";
//            webView.webViewFrame = self.view.frame;
//            [self.navigationController pushViewController:webView animated:YES];
//        }];
//        
//        [alert addButtonWithTitle:@"是" block:^(void)
//         {
//             ImproveInformationViewController *iminfo = [[ImproveInformationViewController alloc] initWithNibName:@"ImproveInformationViewController" bundle:nil];
//             iminfo.key = self.sendStrng;//submitOrderModel.key;
//             [self.navigationController pushViewController:iminfo animated:YES];
//         }];
//        [alert setCancelButtonWithTitle:@"否" block:nil];
//        
//        [alert show];
//    }

}
//end



//-(void)cangoback
//{
//    if (isgotoDetail) {
//
//        NSString *fontSize = @"16";
//        [self.webSizeChart loadHTMLString:[NSString stringWithFormat:@"%@%@%@%@", @"<style type=\"text/css\">img{width:300px;}.newtext{text-indent:2em;font-size:", fontSize, @"px;}</style>", strURL] baseURL:nil];
//        webSizeChart.scalesPageToFit =NO;
//        isgotoDetail = NO;
//        btndown.hidden = YES;
//        downimageV.hidden = YES;
//        
//        
//    }else{
//        [self.navigationController popViewControllerAnimated:YES];
//    }
//}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];

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