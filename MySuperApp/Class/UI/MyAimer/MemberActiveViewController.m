//
//  MemberActiveViewController.m
//  MySuperApp
//
//  Created by 1 on 14-9-9.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "MemberActiveViewController.h"
#import "MyAimerloginViewController.h"
#import "SBPublicFormatValidation.h"

@interface MemberActiveViewController ()
{
//    UIButton *doneButton;
}
@end

@implementation MemberActiveViewController
@synthesize username,pwd;


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
    
    self.title = @"门店会员激活";
    
    
    mainSer = [[MainpageServ alloc] init];
    mainSer.delegate = self;
    
    //创建返回按钮
    [self createBackBtnWithType:0];
    
    
    if (isIOS7up) {
        [myallView setFrame:CGRectMake(0, new20ViewY, 320, self.view.frame.size.height-new20ViewY)];
        [myallView2 setFrame:CGRectMake(0, 0, 320, self.view.frame.size.height-0)];
    }
    
    [myallView setContentSize:CGSizeMake(320, 700)];
    [myallView2 setContentSize:CGSizeMake(320, 700)];

    if (self.type == 1) {//线下 用户名填写完毕  出弹框
        
        fieldPhone.text = self.username;
        [fieldPhone setEnabled:NO];
//        fieldUser.text = self.username;
//        [fieldUser setEnabled:NO];
    } else if (self.type == 2) {//
//        fieldMobile.text = self.username;
//        [fieldMobile setEnabled:NO];
    }
    
//    doneButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 163, 106, 53)];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
//    [[NSNotificationCenter defaultCenter]addObserver:self
//                                            selector:@selector(keyboardWillShowOnDelay22:)
//                                                name:UIKeyboardWillShowNotification
//                                              object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
//    doneButton.hidden = YES;
//    [[NSNotificationCenter defaultCenter]removeObserver:self
//                                                   name:UIKeyboardWillShowNotification
//                                                 object:nil];
}


#pragma mark 增加键盘上的完成按钮
//- (void)keyboardWillShowOnDelay22:(NSNotification *)notification
//{
//    [self performSelector:@selector(keyboardWillShow22:) withObject:nil afterDelay:0];
//}
//
//- (void)keyboardWillShow22:(NSNotification *)notification
//{
//    [doneButton setTitle:@"完成" forState:(UIControlStateNormal)];
//    [doneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [doneButton addTarget:self action:@selector(doneButton:) forControlEvents:UIControlEventTouchUpInside];
//    UIWindow * tempWindow = [[[UIApplication sharedApplication]windows]objectAtIndex:1];
//    UIView * keyBoard = nil;
//    NSLog(@"%@",tempWindow);
//    for (int i = 0; i < tempWindow.subviews.count; i ++) {
//        keyBoard = [tempWindow.subviews objectAtIndex:i];
//        
//        [keyBoard addSubview:doneButton];
//    }
//}
//
//- (void)doneButton:(UIButton *)btn{
//    
//    [fieldPhone resignFirstResponder];
//    [fieldTextPhone resignFirstResponder];
//    [fieldUser resignFirstResponder];
//}



#pragma mark -- 按钮事件
- (IBAction)getCodeAndSubmit:(UIButton *)sender
{
    
    if (![SBPublicFormatValidation boolCheckPhoneNumInput:fieldPhone.text]) {
        [MYCommentAlertView showMessage:@"手机号格式不正确" target:nil];
        return;
    }
    switch (sender.tag) {
        case 301://获取验证码
        {
            switch (self.type) {
                case 1:
                    
                    break;
                case 2:
                    
                    break;
                case 3:
                    fieldUser.text = fieldPhone.text;
                    break;
                case 4:
                    fieldTextAccount.text = fieldTextPhone.text;
                    break;
                default:
                    break;
            }
            [self.view endEditing:YES];
            [mainSer getProveMobile:fieldPhone.text andType:@""];
            [SBPublicAlert showMBProgressHUD:@"正在发送···" andWhereView:self.view states:NO];
         
          
        }break;
        case 102:{//提交
            
            NSString *strPass = fieldPwd.text;
            NSString *strNewPass = fieldPwdC.text;
            if (fieldCode.text.length == 0) {
                [MYCommentAlertView showMessage:@"验证码不能为空" target:nil];
                return;
            } else if (fieldUser.text.length == 0) {
                [MYCommentAlertView showMessage:@"账号不能为空" target:nil];
                return;
            } else if (strPass.length == 0 || strNewPass.length == 0) {
                [MYCommentAlertView showMessage:@"密码不能为空" target:nil];
                return;
            } else if (strPass.length < 6 || strPass.length > 16 || strNewPass.length < 6 || strNewPass.length > 16) {
                [MYCommentAlertView showMessage:@"密码字数必须在6~16位之间" target:nil];
                return;
            } else if (![strPass isEqualToString:strNewPass]) {
                [MYCommentAlertView showMessage:@"密码不一致" target:nil];
                return;
            }
           [mainSer getSetv6user:fieldPhone.text andCode:fieldCode.text andLoginName:fieldUser.text andPwd:fieldPwd.text];
            [SBPublicAlert showMBProgressHUD:@"正在提交···" andWhereView:self.view states:NO];
            
        }break;
        default:
            break;
    }
}

- (IBAction)submitOrCode:(UIButton *)sender
{
    switch (sender.tag) {
        case 201://获取验证码
       
            [self.view endEditing:YES];
            [mainSer getProveMobile:fieldMobile.text andType:@""];
            [SBPublicAlert showMBProgressHUD:@"正在发送···" andWhereView:self.view states:NO];
            break;
        case 202://提交
        {
            [mainSer getV6userlogin:fieldMobile.text andV6checkcode:fieldUseCode.text andLoginName:username andLoginPwd:self.pwd];
            [SBPublicAlert showMBProgressHUD:@"正在提交···" andWhereView:self.view states:NO];
        }
            break;
        default:
            break;
    }

}
//门店会员激活 点击 YES弹出
- (IBAction)submit:(UIButton *)sender
{
    
    if (![SBPublicFormatValidation boolCheckPhoneNumInput:fieldTextPhone.text]) {
        [MYCommentAlertView showMessage:@"手机号格式不正确" target:nil];
        return;
    }
    switch (sender.tag) {
        case 401://获取验证码
        {
            switch (self.type) {
                case 1:
                    
                    break;
                case 2:
                    
                    break;
                case 3:
                    fieldUser.text = fieldPhone.text;
                    break;
                case 4:
                    break;
                default:
                    break;
            }
            
            [self.view endEditing:YES];
            [mainSer getProveMobile:fieldTextPhone.text andType:@""];
            
            NSDictionary *dic1  = [NSDictionary dictionaryWithObjectsAndKeys:fieldTextPhone.text, @"UserName",nil];
            [TalkingData trackEvent:@"5009" label:@"门店激活" parameters:dic1];
        }
//            [SBPublicAlert showMBProgressHUD:@"正在发送···" andWhereView:self.view states:NO];
            break;
        case 402:{//提交
            NSString *strPass = fieldTextPwd.text;
            if (fieldTextCode.text.length == 0) {
                [MYCommentAlertView showMessage:@"验证码不能为空" target:nil];
                return;
            } else if (fieldTextAccount.text.length == 0) {
                [MYCommentAlertView showMessage:@"账号不能为空" target:nil];
                return;
            } else if (strPass.length == 0) {
                [MYCommentAlertView showMessage:@"密码不能为空" target:nil];
                return;
            } else if (strPass.length < 6 || strPass.length > 16) {
                [MYCommentAlertView showMessage:@"密码字数必须在6~16位之间" target:nil];
                return;
            }
            [mainSer getV6userlogin:fieldTextPhone.text andV6checkcode:fieldTextCode.text andLoginName:fieldTextAccount.text andLoginPwd:fieldTextPwd.text];
            [SBPublicAlert showMBProgressHUD:@"正在提交···" andWhereView:self.view states:NO];
        }break;
        default:
            break;
    }

}


#pragma mark -- UITextField 键盘消失
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark -- UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
//    if (textField == fieldPhone || textField == fieldTextPhone || textField == fieldUser) {
//        doneButton.hidden = NO;
//    }else{
//        doneButton.hidden = YES;
//    }
    
    
    
    if (textField == fieldUser || textField == fieldPwd ||textField == fieldPwdC || textField == fieldTextPwd) {
        
        [myallView setContentOffset:CGPointMake(0, 120)];
        [myallView2 setContentOffset:CGPointMake(0, 120)];
        
//        if (self.view.frame.origin.y == -120) {
//            [UIView animateWithDuration:0.3 animations:^{
//
//                [myallView setContentOffset:CGPointMake(0, 120)];
//                [myallView2 setContentOffset:CGPointMake(0, 120)];
//
////            self.view.frame = CGRectMake(0, -120, self.view.frame.size.width, self.view.frame.size.height);
//            }];
//
//        }else{
//            [UIView animateWithDuration:0.3 animations:^{
//               self.view.frame = CGRectMake(0, -120, self.view.frame.size.width, self.view.frame.size.height);
//        }];
//        }
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == fieldPhone) {
        fieldUser.text = fieldPhone.text;
    }
    
    if (textField == fieldTextPhone) {
//        fieldTextAccount.text = fieldTextPhone.text;
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [UIView animateWithDuration:0.3 animations:^{
        [self.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.3 animations:^{
        [self.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    }];
    return YES;
}

#pragma mark -- NetRequestDelegate
-(void)serviceStarted:(ServiceType)aHandle{
}

-(void)serviceFinished:(ServiceType)aHandle withmodel:(id)amodel{
    
    [SBPublicAlert hideMBprogressHUD:self.view];
    LBaseModel *model = (LBaseModel *)amodel;
    switch (model.requestTag) {
        case Http_Sendcodes_Tag:
            if (!model.errorMessage) {
                
                [MYCommentAlertView showMessage:[(CodeBindBindCodeModel *)model content] target:nil];
            }else{
                [MYCommentAlertView showMessage:model.errorMessage target:nil];
            }
            break;
        case Http_setv6user_Tag:
            if (!model.errorMessage) {
                [SBPublicAlert hideMBprogressHUD:self.view];
            
                //lee999  （4.激活成功后给个友好提示如：恭喜你，激活成功
                [MYCommentAlertView showMessage:@"恭喜你，激活成功" target:nil];

               SetSetVUserModel* loginModel = (SetSetVUserModel *)model;
                [[NSUserDefaults standardUserDefaults] setObject:loginModel.userssion forKey:@"usersession"];
                //登录成功
                [SingletonState sharedStateInstance].userHasLogin = YES;
                //end
                
                MyAimerloginViewController *tempAimer = [[MyAimerloginViewController alloc] initWithNibName:@"MyAimerloginViewController" bundle:nil];
                [self.navigationController pushViewController:tempAimer animated:YES];
            }else{
                
               [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:1.0];
            }
            break;
        case Http_v6userlogin_Tag:
            if (!model.errorMessage) {
                [SBPublicAlert hideMBprogressHUD:self.view];
                
                //lee999 新增门店会员激活的登录
                [MYCommentAlertView showMessage:@"恭喜你，登录成功" target:nil];

                VuserLoginVuserLoginModel* loginModel = (VuserLoginVuserLoginModel *)model;
                [[NSUserDefaults standardUserDefaults] setObject:loginModel.userssion forKey:@"usersession"];
                //登录成功
                [SingletonState sharedStateInstance].userHasLogin = YES;
                //end
                
                MyAimerloginViewController *tempAimer = [[MyAimerloginViewController alloc] initWithNibName:@"MyAimerloginViewController" bundle:nil];
                [self.navigationController pushViewController:tempAimer animated:YES];
            }else{
                [MYCommentAlertView showMessage:model.errorMessage target:nil];
            }
            break;
        case 10086:
        {
            [MYCommentAlertView showMessage:model.errorMessage target:nil];            
        }
            break;
        default:
                [SBPublicAlert hideMBprogressHUD:self.view];
            break;
    }
}
-(void)serviceFailed:(ServiceType)aHandle{
    [SBPublicAlert hideMBprogressHUD:self.view];
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
