//
//  GiftCheckOutFinishViewController.m
//  MyAimerApp
//
//  Created by 蒋博男 on 15/6/30.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "GiftCheckOutFinishViewController.h"
#import "OrderDetailViewController.h"


@interface GiftCheckOutFinishViewController ()

@end

@implementation GiftCheckOutFinishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"提交成功";
    [self createBackBtnWithType:0];
    
    NSInteger spH = 60;
    
    UILabel* labelok = [[UILabel alloc] initWithFrame:CGRectMake(10, spH, 300, 30)];
    labelok.textAlignment = UITextAlignmentCenter;
    labelok.backgroundColor = [UIColor clearColor];
    labelok.font = [UIFont systemFontOfSize:20];
    labelok.textColor =  [UIColor colorWithHexString:@"000000"];
    labelok.text = @"礼品卡兑换成功!";
    [self.view addSubview:labelok];
    
    spH += 40;
    
    
    UILabel* lblOrderTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, spH, ScreenWidth-20, 20)];
    lblOrderTitle.textAlignment = UITextAlignmentCenter;
    [lblOrderTitle setText:[NSString stringWithFormat:@"订单号：%@",self.orderId]];
    lblOrderTitle.font = [UIFont systemFontOfSize:LabMidSize];
    lblOrderTitle.textColor =  [UIColor colorWithHexString:@"000000"];
    [self.view addSubview:lblOrderTitle];
    
    spH += 100;

    
    UIButton *nextbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextbtn setFrame:CGRectMake(30,spH,ScreenWidth-60,40)];
    [nextbtn addTarget:self action:@selector(gotoShopping) forControlEvents:UIControlEventTouchUpInside];
    [nextbtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    [nextbtn setBackgroundImage:[UIImage imageNamed:@"big_btn_r_normal.png"] forState:UIControlStateNormal];
    [nextbtn setBackgroundImage:[UIImage imageNamed:@"big_btn_r_hover.png"] forState:UIControlStateHighlighted];
    
    [nextbtn setBackgroundColor:[UIColor clearColor]];
    [nextbtn setTitle:@"去逛逛" forState:UIControlStateNormal];
    [self.view addSubview:nextbtn];
    
    spH += 60;
    
    
    UIButton *seebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [seebtn setFrame:CGRectMake(30,spH,ScreenWidth-60,40)];
    [seebtn addTarget:self action:@selector(gotoSeeOrder) forControlEvents:UIControlEventTouchUpInside];
    [seebtn setTitleColor:[UIColor colorWithHexString:@"#777777"] forState:UIControlStateNormal];
    [seebtn setBackgroundImage:[UIImage imageNamed:@"sryc_btn_big_normal.png"] forState:UIControlStateNormal];
    [seebtn setBackgroundImage:[UIImage imageNamed:@"sryc_btn_big_hover.png"] forState:UIControlStateHighlighted];
    
    [seebtn setBackgroundColor:[UIColor clearColor]];
    [seebtn setTitle:@"查看订单" forState:UIControlStateNormal];
    [self.view addSubview:seebtn];
}


-(void)clickBackButton:(UIButton*)sender{
    
    NSInteger index=[[self.navigationController viewControllers]indexOfObject:self];
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:index-2 isArray:nil]animated:YES];
}


#pragma mark ===逛一逛 事件
-(void)gotoShopping{
    [self.navigationController popToRootViewControllerAnimated:YES];
    [self changetableBarto:0];
}


-(void)gotoSeeOrder{

    
    OrderDetailViewController *tempOrderDetail = [[OrderDetailViewController alloc] init];
    tempOrderDetail.isUnAccess = NO;
    tempOrderDetail.isFromCar = YES;  //是否来自结算中心
    tempOrderDetail.isHiddenBar = YES; //是否隐藏bar
    tempOrderDetail.orderID = self.orderId;
    tempOrderDetail.isOrderPayOK = YES;
    [self.navigationController pushViewController:tempOrderDetail animated:YES];    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
