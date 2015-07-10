//
//  FindPasswordViewController.m
//  MySuperApp
//
//  Created by lee on 14-3-27.
//  Copyright (c) 2014年 aimer. All rights reserved.
//

#import "FindPasswordViewController.h"
#import "LoginViewController.h"
#import "SBPublicFormatValidation.h"

@interface FindPasswordViewController ()
{
    NSInteger count;
}
@end

@implementation FindPasswordViewController
@synthesize isFind;
@synthesize topic;
@synthesize phoneNum;
@synthesize userID;

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
    
    self.title = @"找回密码";
    [self createBackBtnWithType:0];

    mainSer = [[MainpageServ alloc] init];
    mainSer.delegate = self;
    
    
    textFieldCode.clearButtonMode = UITextFieldViewModeWhileEditing;
    textFieldNew.clearButtonMode = UITextFieldViewModeWhileEditing;
    textFieldComfirmNew.clearButtonMode = UITextFieldViewModeWhileEditing;

    
    //创建右边按钮  lee999小莹让去掉关闭按钮
//    [self createRightBtn];
//    [self.navbtnRight setTitle:@"关闭" forState:UIControlStateNormal];
//    [self.navbtnRight setTitle:@"关闭" forState:UIControlStateHighlighted];
//    [self.navbtnRight setFrame:CGRectMake(242, 7, 66, 32)];
    
    labelTitle.text = topic;
    labelPhone.text = phoneNum;
    
    count = 120;
    timerCode = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown:) userInfo:nil repeats:YES];
    
    if (isIOS7up) {
        [myallView setFrame:CGRectMake(0, new20ViewY, 320, self.view.frame.size.height-new20ViewY)];
    }
}

-(void)rightButAction{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -- 按钮事件

- (IBAction)submit:(id)sender//提交
{
    
    if ([textFieldNew.text isEqualToString:@""]||[textFieldComfirmNew.text isEqualToString:@""]) {
        [MYCommentAlertView showMessage:@"您输入的密码不符合规则" target:nil];
        return;
    }else if (![textFieldNew.text isEqualToString:textFieldComfirmNew.text]) {
        [MYCommentAlertView showMessage:@"您两次输入的密码不一样" target:nil];
        return;
        
    }else if (![NSString isUserPwdValid:textFieldNew.text] || ![NSString isUserPwdValid:textFieldComfirmNew.text]) {
        [MYCommentAlertView showMessage:@"您输入的密码长度错误" target:nil];
        return;
    }
    
    //lee999recode
//    if (![NSString isValidTelephoneNum2:textFieldNew.text] || ![NSString isValidateEmail:textFieldComfirmNew.text]) {
//        [MYCommentAlertView showMessage:@"您输入的用户名不正确，请重新输入" target:nil];
//        return;
//    }
    
    
    [self.view endEditing:YES];
    if (isFind) {
        if ([textFieldNew.text isEqualToString:textFieldComfirmNew.text]) {
        [mainSer getResetpassup:userID andCheckcode:textFieldCode.text andPassword:textFieldNew.text];
            [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];

        }else {
            [SBPublicAlert showAlertTitle:@"爱慕提示" Message:@"两次输入密码不一致"];
        }
    }else{
    
    }
}

#pragma mark -- neetrequestdelegate
-(void)serviceStarted:(ServiceType)aHandle{
}
-(void)serviceFailed:(ServiceType)aHandle{
    [SBPublicAlert hideMBprogressHUD:self.view];
}
-(void)serviceFinished:(ServiceType)aHandle withmodel:(id)amodel{
    
    [SBPublicAlert hideMBprogressHUD:self.view];
    LBaseModel *model = (LBaseModel *)amodel;
    switch (model.requestTag) {
        case Http_Resetpassup_Tag:
        {
            if (!model.errorMessage) {
                [SBPublicAlert hideMBprogressHUD:self.view];
                LoginViewController *tempLogin = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
                [self.navigationController pushViewController:tempLogin animated:YES];
            }else{
                [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:1.0];
            }
        }
            break;
        case 10086:
            [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:1.0];
            break;
        default:
            [SBPublicAlert hideMBprogressHUD:self.view];
            break;
    }
    
}

#pragma mark -- 倒计时
- (void)countDown:(NSTimer *)timer
{
    count -- ;
    labelCount.text = [NSString stringWithFormat:@"%ld",(long)count];
    if (count == 0) {
        [timerCode invalidate];
    }
}

#pragma mark -- 屏幕上任意一点 键盘消失
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark -- uitextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == textFieldNew || textField == textFieldComfirmNew) {
        [UIView animateWithDuration:0.3 animations:^{
            [self.view setFrame:CGRectMake(0, -110, ScreenWidth, NowViewsHight)];
        }];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.3 animations:^{
        [self.view setFrame:CGRectMake(0, 0, ScreenWidth, NowViewsHight)];
    }];
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
