//
//  MyClosetMade2ViewController.m
//  MyAimerApp
//
//  Created by yanglee on 15/6/8.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "MyClosetMade2ViewController.h"
#import "YKCanReuse_webViewController.h"
#import "MyClosetMade3ViewController.h"

@interface MyClosetMade2ViewController ()
{
    __weak IBOutlet UIButton *liuchengBtn;

    __weak IBOutlet UIButton *perReadbtn;

    __weak IBOutlet UIButton *yuyueBtn;
}
@end

@implementation MyClosetMade2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"爱慕定制"];
    [self createBackBtnWithType:0];
    [self NewHiddenTableBarwithAnimated:YES];
    
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)liuchengAction:(id)sender {
    
    YKCanReuse_webViewController *webView = [[YKCanReuse_webViewController alloc] init];
    webView.strURL = @"http://www.aimer.com.cn/wap/2015324dz.shtml";
    webView.strTitle = @"定制流程";
    [self.navigationController pushViewController:webView animated:YES];
}


- (IBAction)perReadAction:(id)sender {
    MyClosetMade3ViewController *clmVC = [[MyClosetMade3ViewController alloc] init];
    [self.navigationController pushViewController:clmVC animated:YES];
}


- (IBAction)yuyueAction:(id)sender {
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
