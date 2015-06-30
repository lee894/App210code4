//
//  GiftCheckOutFinishViewController.m
//  MyAimerApp
//
//  Created by 蒋博男 on 15/6/30.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "GiftCheckOutFinishViewController.h"

@interface GiftCheckOutFinishViewController ()

@end

@implementation GiftCheckOutFinishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UILabel* lblTitle = [[UILabel alloc] init];
    [lblTitle setText:@"订单已提交！"];
    
    UILabel* lblOrderTitle = [[UILabel alloc] init];
    [lblOrderTitle setText:@"订单号"];
    
    UILabel* lblOrderId = [[UILabel alloc] init];
    [lblOrderId setText:_orderId];
    
    UIButton* btnToHome = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnToHome setTitle:@"去逛逛" forState:UIControlStateNormal];
    [btnToHome setFrame:CGRectMake(0, 0, 0, 0)];
    
    UIButton* btnToDetail = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnToDetail setTitle:@"查看订单" forState:UIControlStateNormal];
    [btnToDetail setFrame:CGRectMake(0, 0, 0, 0)];
}

#pragma mark ===逛一逛 事件
-(void)gotoShopping{
    [self changetableBarto:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
