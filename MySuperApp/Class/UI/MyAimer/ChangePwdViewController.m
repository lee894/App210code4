//
//  ChangePwdViewController.m
//  MySuperApp
//
//  Created by malan on 14-3-26.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "ChangePwdViewController.h"
#import "LoginViewController.h"

@interface ChangePwdViewController ()

@end

@implementation ChangePwdViewController


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
    
    self.title = @"修改密码";
    [self createBackBtnWithType:0];
    
    mainSer = [[MainpageServ alloc] init];
    mainSer.delegate = self;
    
    if (isIOS7up) {
        [myallView setFrame:CGRectMake(0, new20ViewY, 320, self.view.frame.size.height-new20ViewY)];
    }
    
    [self NewHiddenTableBarwithAnimated:YES];
}

- (void)rightButAction {
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (IBAction)tijiaoUpdatePwd:(id)sender {
    
    if (newPwdField.text.length < 1||oldPwdField.text.length < 1||surePwdField.text.length <1) {
        [SBPublicAlert showAlertTitle:@"爱慕提示" Message:@"信息不全，请补全信息！"];
        return;

    }
    
    if (newPwdField.text.length >=6&&oldPwdField.text.length >= 6&&surePwdField.text.length >=6&&newPwdField.text.length <= 16&&oldPwdField.text.length <= 16&&surePwdField.text.length <=16) {
        if ([newPwdField.text isEqualToString:surePwdField.text]) {
            [mainSer getUpdatePwd:oldPwdField.text andNewPad:newPwdField.text];
            [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
        }else {
            [SBPublicAlert showAlertTitle:@"爱慕提示" Message:@"两次输入密码不一样！"];

        }
      
    }else {
      [SBPublicAlert showAlertTitle:@"爱慕提示" Message:@"密码仅限在6-16位位长度！"];
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
        case Http_UpdatePwd_Tag:
            if (!model.errorMessage) {
                [SBPublicAlert hideMBprogressHUD:self.view];

                LoginViewController *updateSuccessVC = [[LoginViewController alloc] init];
                updateSuccessVC.titleLabelstr = @"修改密码";
                updateSuccessVC.successLabel.text = @"恭喜您密码修改成功！";
                [self.navigationController pushViewController:updateSuccessVC animated:YES];


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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == surePwdField) {
        [self tijiaoUpdatePwd:nil];
    }
    [textField resignFirstResponder];
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
