//
//  ForgetPasswordViewController.m
//  MySuperApp
//
//  Created by LEE on 14-7-29.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "SBPublicFormatValidation.h"

#import "EmailTestViewController.h"
#import "FindPasswordViewController.h"

@interface ForgetPasswordViewController ()

@end
@implementation ForgetPasswordViewController

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
//    self.navbtnback.hidden = YES;
    
    mainSer = [[MainpageServ alloc] init];
    mainSer.delegate = self;
    
    
    textFieldAccount.clearButtonMode = UITextFieldViewModeWhileEditing;

    
    //创建右边按钮  lee999小莹要去掉关闭按钮
//    [self createRightBtn];
//    [self.navbtnRight setTitle:@"关闭" forState:UIControlStateNormal];
//    [self.navbtnRight setTitle:@"关闭" forState:UIControlStateHighlighted];
//    [self.navbtnRight setFrame:CGRectMake(242, 7, 66, 32)];
 
    
    if (isIOS7up) {
        [myallView setFrame:CGRectMake(0, new20ViewY, 320, self.view.frame.size.height-new20ViewY)];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- 按钮事件
-(void)rightButAction//返回
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)verification:(id)sender//验证
{
    [self.view endEditing:YES];
    if ([NSString isValidTelephoneNum2:textFieldAccount.text]) {
  
        [mainSer getFindPasswordup:textFieldAccount.text];
        [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
        
    }else if([NSString isValidateEmail:textFieldAccount.text]){
        
        [mainSer getFindPasswordup:textFieldAccount.text];
        [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
    }else {
        [SBPublicAlert showAlertTitle:@"爱慕提示" Message:@"请输入正确的信息"];
    }
}

- (void)findPassword:(NSString *)userId {
    FindPasswordViewController *tempFind = [[FindPasswordViewController alloc] initWithNibName:@"FindPasswordViewController" bundle:nil];
    tempFind.phoneNum = textFieldAccount.text;
    tempFind.userID = userId;
    tempFind.topic = @"找回密码";
    tempFind.isFind = YES;
    [self.navigationController pushViewController:tempFind animated:YES];
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
        case Http_Findpasswordup_Tag:
        {
            
            if ([NSString isValidTelephoneNum2:textFieldAccount.text]) {
                if (!model.errorMessage) {
                    
                    FindPasswordFindPasswordModel *findModel = (FindPasswordFindPasswordModel *)model;

                    [SBPublicAlert showMBProgressHUD:findModel.content andWhereView:self.view hiddenTime:1.0];
                    [self performSelector:@selector(findPassword:) withObject:findModel.userId afterDelay:1.];
                    
             
                }else{
                    [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:1.0];
                }
                
            }else if([NSString isValidateEmail:textFieldAccount.text]){
                
                if (!model.errorMessage) {
                    [SBPublicAlert hideMBprogressHUD:self.view];
                    EmailTestViewController *tempEmail = [[EmailTestViewController alloc] initWithNibName:@"EmailTestViewController" bundle:nil];
                    [self.navigationController pushViewController:tempEmail animated:YES];
                }else{
                    [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:1];
                }
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

#pragma mark -- 点击屏幕任何地方键盘消失
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark -- uitextfielddelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
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
