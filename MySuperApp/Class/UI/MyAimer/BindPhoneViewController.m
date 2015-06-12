//
//  BindPhoneViewController.m
//  MySuperApp
//
//  Created by malan on 14-4-27.
//  Copyright (c) 2014年 aimer. All rights reserved.
//

#import "BindPhoneViewController.h"
#import "SBPublicFormatValidation.h"

@interface BindPhoneViewController ()

@end

@implementation BindPhoneViewController


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

    self.title = @"绑定手机";
    [self createBackBtnWithType:0];
    
    [self NewHiddenTableBarwithAnimated:YES];

    
    mainSer = [[MainpageServ alloc] init];
    mainSer.delegate = self;
    
    
    if (isIOS7up) {
        [myallView setFrame:CGRectMake(0, new20ViewY, 320, self.view.frame.size.height-new20ViewY)];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -- 键盘消失
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark -- uitextfield delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
   [self.view endEditing:YES];
   return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == textFieldPhone) {
        if (string.length > 0 ||textField.text.length >1) {
            buttonCode.enabled = YES;
        }else{
            buttonCode.enabled = NO;
        }
    }else {
        if (string.length > 0 ||textField.text.length >1) {
            buttonBind.enabled = YES;
        }else{
            buttonBind.enabled = NO;
        }
    }
    return YES;
}
#pragma mark -- 按钮事件
- (IBAction)getCode:(id)sender//获取验证码
{
    
    [textFieldPhone resignFirstResponder];
    
    if (![NSString isValidTelephoneNum2:textFieldPhone.text]) {
        [SBPublicAlert showAlertTitle:@"" Message:@"手机号码错误，请重新输入"];
        return;
    }
    
    [mainSer getSendcodes:textFieldPhone.text];
    [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
    
    count = 60;
    NSTimer *timers = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFiredMethod:) userInfo:nil repeats:YES];
    bindTimer = timers;

}
- (IBAction)bindPhone:(id)sender//绑定手机
{
    if ([NSString isValidTelephoneNum2:textFieldPhone.text]) {
        [mainSer getBindmobile:textFieldPhone.text andSendcodeno:textFieldCode.text];
        [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
    }else {
        [SBPublicAlert showAlertTitle:@"爱慕提示" Message:@"请输入电话号码"];
    }
}

#pragma mark -- 定时器
- (void)timerFiredMethod:(NSTimer *)timer
{
    
    buttonCode.enabled = NO;
    count--;
    [buttonCode setTitle:[NSString stringWithFormat:@"发送验证码（%d）", count] forState:UIControlStateNormal];
    [buttonCode setTitle:[NSString stringWithFormat:@"发送验证码（%d）", count] forState:UIControlStateDisabled];

    if (count == 0) {
        [bindTimer invalidate];
        buttonCode.enabled = YES;
        [buttonCode setTitle:@"发送验证码" forState:UIControlStateNormal];
    }
}

#pragma mark -- netrequest delegate
-(void)serviceStarted:(ServiceType)aHandle{
}

-(void)serviceFailed:(ServiceType)aHandle{
    [SBPublicAlert hideMBprogressHUD:self.view];
}

-(void)serviceFinished:(ServiceType)aHandle withmodel:(id)amodel{
    
    [SBPublicAlert hideMBprogressHUD:self.view];
    LBaseModel *model = (LBaseModel *)amodel;
    
    switch (model.requestTag) {
        case Http_Sendcodes_Tag:
            if (!model.errorMessage) {
                [SBPublicAlert showMBProgressHUD:[(CodeBindBindCodeModel  *)model content] andWhereView:self.view hiddenTime:1.];
            }else{
                [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:1.];
            }
            break;
        case Http_Bindmobile_Tag:
            if (!model.errorMessage) {
                [SBPublicAlert hideMBprogressHUD:self.view];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:1.];
            }
            break;
        case 10086:
            [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:1.];
            break;
        default:
            [SBPublicAlert hideMBprogressHUD:self.view];
            break;
    }
    
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
