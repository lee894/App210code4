//
//  CancelOrderViewController.m
//  MySuperApp
//
//  Created by LEE on 14-4-5.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "CancelOrderViewController.h"


@interface CancelOrderViewController ()

@end

@implementation CancelOrderViewController
@synthesize orderid;
@synthesize isCar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"取消订单";
    
    if (isCar) {
        //如果是购物车过来的话，返回到购车界面
        [self createBackBtnWithType:997];
    }else{
        [self createBackBtnWithType:0];
    }

    [self createBackBtnWithType:0];
    
    
    mainSev = [[MainpageServ alloc] init];
    mainSev.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -- 按钮事件
-(void)popBackAnimate:(UIButton *)sender//返回
{
    if(self.isCar){
        //直接返回购物车
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else {
        //返回订单列表
//        [self.navigationController popViewControllerAnimated:YES];
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count -3] animated:YES];
    }
}

- (IBAction)cancelReason:(UIButton *)sender//取消订单的原因
{
    if (buttonlast != nil) {
        buttonlast.selected = NO;
    }

    buttonlast = sender;
    sender.selected = YES;
    buttonCancel.enabled = YES;
}

- (IBAction)cancelOrder:(UIButton *)sender//取消订单
{
    
    NSString *str = [(UILabel *)[self.view viewWithTag:sender.tag+100] text];
    NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:self.userName, @"UserName",self.orderid, @"CoId",str,@"Reason",self.payWay,@"Payment",nil];
    [TalkingData trackEvent:@"5011" label:@"取消订单" parameters:dic2];
    
    [mainSev getCancelorder:self.orderid];
    [SBPublicAlert showMBProgressHUD:@"正在取消···" andWhereView:self.view states:NO];
}

#pragma mark -- net request delegate
-(void)serviceStarted:(ServiceType)aHandle{
}

-(void)serviceFailed:(ServiceType)aHandle{
    [SBPublicAlert hideMBprogressHUD:self.view];
}

-(void)serviceFinished:(ServiceType)aHandle withmodel:(id)amodel{
    
    [SBPublicAlert hideMBprogressHUD:self.view];
    LBaseModel *model = (LBaseModel *)amodel;
    switch (model.requestTag) {
        case Http_CancelOrder_Tag:
            if (!model.errorMessage) {
                [SBPublicAlert hideMBprogressHUD:self.view];
                
                UIAlertView *alertv = [[UIAlertView alloc] initWithTitle:@"爱慕提示" message:@"您的订单取消成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertv setDelegate:self];
                alertv.tag = 10099;
                [alertv show];
                
            }else{
                [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:0.6];
            }
            break;
        case 10086:
            [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:0.6];
            break;
        default:
            [SBPublicAlert hideMBprogressHUD:self.view];
            break;
    }
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self popBackAnimate:nil];
}


#pragma mark -- 屏幕旋转
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

@end
