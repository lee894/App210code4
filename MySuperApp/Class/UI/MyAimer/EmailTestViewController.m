//
//  EmailTestViewController.m
//  爱慕商场
//
//  Created by LEE on 14-8-12.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "EmailTestViewController.h"

@interface EmailTestViewController ()

@end

@implementation EmailTestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"找回密码";
    
    
    [self createBackBtnWithType:997];
//    self.navbtnback.hidden = YES;
    
    //创建右边按钮  小莹让去掉关闭按钮
//    [self createRightBtn];
//    [self.navbtnRight setTitle:@"关闭" forState:UIControlStateNormal];
//    [self.navbtnRight setTitle:@"关闭" forState:UIControlStateHighlighted];
//    [self.navbtnRight setFrame:CGRectMake(242, 7, 66, 32)];
}


#pragma mark -- 按钮事件
-(void)rightButAction//返回
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
