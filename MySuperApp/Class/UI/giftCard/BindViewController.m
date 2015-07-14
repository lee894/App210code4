//
//  BindViewController.m
//  爱慕商场
//
//  Created by LEE on 14-7-31.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "BindViewController.h"

@interface BindViewController ()

@end

@implementation BindViewController

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
    
    self.title = @"绑定优惠劵";
    
    [self createBackBtnWithType:0];
    mainSer  = [[MainpageServ alloc] init];
    mainSer.delegate = self;
    
    if (isIOS7up) {
        [myallview setFrame:CGRectMake(0, new20ViewY, 320, self.view.frame.size.height - new20ViewY)];
    }
}


#pragma mark -- 键盘消失
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark -- 返回按钮事件
-(void)popBackAnimate:(UIButton *)sender//返回
{
    [self.navigationController popViewControllerAnimated:YES];
}

//绑定
- (IBAction)btnBindClicked:(UIButton *)btn
{
    [bindtextField resignFirstResponder];
    if([bindtextField.text isEqualToString:@""] || !bindtextField.text)
    {
        [SBPublicAlert showAlertTitle:@"爱慕提示" Message:@"请输入优惠券号码"];
        [bindtextField becomeFirstResponder];
        return;
    }
    [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
    [mainSer addCouponcard:bindtextField.text andtype:@"coupon"];
}

#pragma mark -- NETrequest delegate
-(void)serviceStarted:(ServiceType)aHandle{
}

-(void)serviceFailed:(ServiceType)aHandle{
    [SBPublicAlert hideMBprogressHUD:self.view];
}

-(void)serviceFinished:(ServiceType)aHandle withmodel:(id)amodel
{
    [SBPublicAlert hideMBprogressHUD:self.view];
    LBaseModel *model = (LBaseModel *)amodel;
    
    if (model.requestTag == Http_addCouponcard_Tag) {
        if (!model.errorMessage) {
            bindtextField.text = @"";
            
            ChengeMyInfo *bangModel = (ChengeMyInfo *)model;
            
            [MYCommentAlertView showMessage:bangModel.res target:nil];
            
//            [SBPublicAlert showMBProgressHUD:bangModel.res andWhereView:self.view hiddenTime:1.5];
            
//            [self performSelector:@selector(quit:) withObject:nil afterDelay:1.5];
            [self.navigationController popViewControllerAnimated:NO];
            
        } else {
            [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:0.6];
        }
    } else if (model.requestTag == 10086){
        
        [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:0.6];
    }
    
            
}

#pragma mark -- UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
