//
//  MyCloset6ViewController.m
//  MyAimerApp
//
//  Created by yanglee on 15/5/28.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "MyCloset6ViewController.h"
#import "MyCloset7ViewController.h"
#import "YKCanReuse_webViewController.h"
#import "ProductlistViewController.h"


@interface MyCloset6ViewController ()
{
    IBOutlet UIScrollView *myScrollV;
}
@end

@implementation MyCloset6ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"私人衣橱"];
    [self createBackBtnWithType:0];
    
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)gotoBackAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}


//约约测体
-(IBAction)testMybobyAction:(id)sender{

    MyCloset7ViewController *clv2 = [[MyCloset7ViewController alloc] initWithNibName:@"MyCloset7ViewController" bundle:nil];
    [self.navigationController pushViewController:clv2 animated:YES];
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
#pragma mark--- 我有软尺
- (IBAction)HasRuanchiAction:(id)sender {
    
    YKCanReuse_webViewController *webView = [[YKCanReuse_webViewController alloc] init];
    webView.strURL = HasRuanchiUrl;
    webView.strTitle = @"我有软尺";
    [self.navigationController pushViewController:webView animated:YES];
}

#pragma mark--- 换购软尺
- (IBAction)buyTapeAction:(id)sender {
 
    ProductlistViewController *jumpVC = [[ProductlistViewController alloc] init];
    [SingletonState sharedStateInstance].productlistType = 1;
    jumpVC.params = @":3564";
    jumpVC.titleName = @"换购软尺";
    jumpVC.isHiddenFilerbtn = YES;  //隐藏筛选按钮。  轮播不需要增加筛选按钮
    [self.navigationController pushViewController:jumpVC animated:YES];
    
}



@end
