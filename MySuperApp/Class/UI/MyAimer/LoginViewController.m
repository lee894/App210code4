//
//  LoginViewController.m
//  MySuperApp
//
//  Created by LEE on 14-4-12.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "LoginViewController.h"
#import "MyAimerViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize titleLabelstr;

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
    
    self.title = titleLabelstr;
    
    [self createBackBtnWithType:0];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- 按钮事件
- (IBAction)login:(id)sender//登录
{
    MyAimerViewController *Amier = [[MyAimerViewController alloc] initWithNibName:@"MyAimerViewController" bundle:nil];
    [self.navigationController pushViewController:Amier animated:NO];
}

#pragma mark -- textField键盘消失

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
