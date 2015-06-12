//
//  MyClosetMade3ViewController.m
//  MyAimerApp
//
//  Created by yanglee on 15/6/8.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "MyClosetMade3ViewController.h"

@interface MyClosetMade3ViewController ()

@end

@implementation MyClosetMade3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setTitle:@"爱慕定制"];
    [self createBackBtnWithType:0];
    [self NewHiddenTableBarwithAnimated:YES];
    
    UIScrollView* scv = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth,self.view.frame.size.height - 60)];
    [scv setShowsHorizontalScrollIndicator:NO];
    [scv setShowsVerticalScrollIndicator:NO];
    [scv setDelegate:self];
    scv.pagingEnabled = YES;
    scv.tag = 10098;
    [scv setMaximumZoomScale:3.0];
    [scv setContentSize:CGSizeMake(ScreenWidth*4,0)];
    [self.view addSubview:scv];
    
    NSArray *urlArr = @[@"http://www.aimer.com.cn/wap/201532401.shtml",
                        @"http://www.aimer.com.cn/wap/201532402.shtml",
                        @"http://www.aimer.com.cn/wap/201532403.shtml",
                        @"http://www.aimer.com.cn/wap/201532404.shtml"];
    for (int i = 0; i< 4; i++) {
        UIWebView *webv = [[UIWebView alloc] initWithFrame:CGRectMake(i*ScreenWidth, 0, ScreenWidth, scv.frame.size.height)];
        [webv loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[urlArr objectAtIndex:i]]]];
        [scv addSubview:webv];
    }
    
    // Do any additional setup after loading the view.
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
