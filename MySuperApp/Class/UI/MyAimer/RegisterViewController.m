//
//  RegisterViewController.m
//  MySuperApp
//
//  Created by LEE on 14-7-29.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "RegisterViewController.h"
#import "MyAimerViewController.h"
#import "SBPublicFormatValidation.h"
#import "MyAimerloginViewController.h"
#import "MemberActiveViewController.h"

@interface RegisterViewController ()
{
    MainpageServ *mainSer;

}
@end

@implementation RegisterViewController
@synthesize isPushBack;

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
    
    self.title = @"注册";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textOfTextFieldDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
    
    mainSer = [[MainpageServ alloc] init];
    mainSer.delegate = self;
    
    [self createBackBtnWithType:0];
    
    
    textFieldUser.clearButtonMode = UITextFieldViewModeWhileEditing;
    textFieldPassword.clearButtonMode = UITextFieldViewModeWhileEditing;
    textFieldConfirm.clearButtonMode = UITextFieldViewModeWhileEditing;

    
    if (isIOS7up) {
        [myallView setFrame:CGRectMake(0, new20ViewY, 320, self.view.frame.size.height-new20ViewY)];
    }

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

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == textFieldUser) {
        //判断是否是线下会员
//        [mainSer getCheckOfflineMobile:textFieldUser.text andType:@"login"];
        //lee999recode
        [mainSer getCheckOfflineMobile:textFieldUser.text andType:@"register"];
    }
}

#pragma mark--- Action

- (IBAction)GetVerifyCodeAction:(id)sender{

    if (!([NSString isValidTelephoneNum2:textFieldUser.text] || [NSString isValidateEmail:textFieldUser.text]) ) {
        [MYCommentAlertView showMessage:@"请您输入正确的手机号码" target:nil];
        return;
    }
    
    
    [self.view endEditing:YES];
    
    [mainSer getRegisterVerifycode:textFieldUser.text];
    [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
    
}


- (IBAction)registration:(id)sender//注册
{
    
    if ([textFieldPassword.text isEqualToString:@""]||[textFieldConfirm.text isEqualToString:@""]) {
        [MYCommentAlertView showMessage:@"您输入的密码不符合规则" target:nil];
        return;
        
    }else if ([verifyCodeField.text isEqualToString:@""]) {
        [MYCommentAlertView showMessage:@"请您输入验证码" target:nil];
        return;
        
    }else if ([textFieldPassword.text description].length < 6) {
        [MYCommentAlertView showMessage:@"密码不能小于6位" target:nil];
        return;
        
    }else if (![textFieldPassword.text isEqualToString:textFieldConfirm.text]) {
        [MYCommentAlertView showMessage:@"您两次输入的密码不一样" target:nil];
        return;

    }else if (![NSString isUserPwdValid:textFieldPassword.text] || ![NSString isUserPwdValid:textFieldConfirm.text]) {
        [MYCommentAlertView showMessage:@"您输入的密码长度错误" target:nil];
        
        return;
    }

    //lee999recode注册的时候，不对账号进行限制了
    if (!([NSString isValidTelephoneNum2:textFieldUser.text] || [NSString isValidateEmail:textFieldUser.text]) ) {
        [MYCommentAlertView showMessage:@"您输入的用户名不正确，请重新输入" target:nil];
        return;
    }
    
    [mainSer getRegisterWithusername:textFieldUser.text email:nil andMobilephone:nil andPassword:textFieldPassword.text andConfirmpw:textFieldConfirm.text andIslogin:NO andVerfyCode:verifyCodeField.text];
    [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
    
    NSDictionary *dic1  = [NSDictionary dictionaryWithObjectsAndKeys:textFieldUser.text, @"UserName",nil];
    [TalkingData trackEvent:@"5009" label:@"注册" parameters:dic1];
}

- (void)textOfTextFieldDidChange:(NSNotification *)notification{
    
    if (![textFieldUser.text isEqualToString:@""] ||
        ![textFieldPassword.text isEqualToString:@""] ||
        ![verifyCodeField.text isEqualToString:@""] ||
        ![textFieldConfirm.text isEqualToString:@""]) {
        
        buttonRegister.enabled = YES;
    }else {
       buttonRegister.enabled = NO;
    }
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
    
    switch (model.requestTag) {
        case Http_Register_Tag:
            if (!model.errorMessage) {
                
                [SBPublicAlert showMBProgressHUD:@"注册成功" andWhereView:self.view hiddenTime:1.0];
                
                LoginLoginModel *registerModel = (LoginLoginModel *)model;
                
                [[NSUserDefaults standardUserDefaults] setObject:registerModel.userssion forKey:@"usersession"];
                [[NSUserDefaults standardUserDefaults] synchronize];

//                MyAimerloginViewController *loginaimVC = [[MyAimerloginViewController alloc] initWithNibName:@"MyAimerloginViewController" bundle:nil];
//                [self.navigationController pushViewController:loginaimVC animated:YES];
                
                //lee登录成功之后，修改登录状态
                [SingletonState sharedStateInstance].userHasLogin = YES;
                
                
                //lee999 150513 设置设备tag
                //end

                
                [self dismissModalViewControllerAnimated:YES];
                [self dismissViewControllerAnimated:YES completion:nil];
                [self.navigationController dismissViewControllerAnimated:YES completion:nil];

                
//                //lee999新增  141117  商品详情进入的注册，返回到这个商品
//                if ([SingletonState sharedStateInstance].isProductDetailGotoLogin) {
//                    
//                    [self changeToLastShopView];
//                    [SingletonState sharedStateInstance].isProductDetailGotoLogin = NO;
//                    return;
//                }
//                //end
//                
//                //lee新增判断，如果登录成功就，直接返回上一界面
//                if (isPushBack) {
//                    //lee999 注册成功之后，返回根目录
//                    [self.navigationController popViewControllerAnimated:NO];
//                    return;
//                }

            }else{
            [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:1.0];
            }
            break;
        case Http_CheckOfflineMobile_Tag:{
            if (!model.errorMessage) {
                CheckCheckOffineMobile *offineModel = (CheckCheckOffineMobile *)model;
                if ([offineModel.offline isEqualToString:@"y"]) {
                    [self.view endEditing:YES];
                    AlertView *tmpAlert = [[AlertView alloc] init];
                    tmpAlert.delegate = self;
                    alert = [[[NSBundle mainBundle] loadNibNamed:@"AlertView" owner:tmpAlert options:nil] lastObject];
                    [self.view  addSubview:alert];
                    alertAlloc = tmpAlert;
                }
            }
        }
            break;
            
            //获取登录验证码成功
        case Http_GetRegisterVerifycode_Tag:{
            if (!model.errorMessage) {
                
                [SBPublicAlert showMBProgressHUD:@"验证码已发送，请您注意查收" andWhereView:self.view hiddenTime:2.0];

                
            }else{
                [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:2.0];
            }
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


-(void)nullAction{
    
}

- (void)alertViewWithStates:(BOOL)states
{
    [alert removeFromSuperview];
    if (states) {
        MemberActiveViewController *memberViewC = [[MemberActiveViewController alloc] initWithNibName:@"MemberActiveViewController" bundle:nil];
        memberViewC.username= textFieldUser.text;
        memberViewC.type = 1;
        [self.navigationController pushViewController:memberViewC animated:YES];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
