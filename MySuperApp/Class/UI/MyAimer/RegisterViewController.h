//
//  RegisterViewController.h
//  MySuperApp
//
//  Created by LEE on 14-7-29.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlertView.h"
#import "MainpageServ.h"
#import "LBaseViewController.h"
#import "APService.h"

@protocol RegisterViewControllerDelegate <NSObject>

@optional
- (void)registerSucces;

@end

@interface RegisterViewController : LBaseViewController <UITextFieldDelegate,ServiceDelegate,AlertViewDelegate>
{
    
    IBOutlet UIButton *buttonRegister;
    IBOutlet UITextField *textFieldUser;
    IBOutlet UITextField *textFieldPassword;
    IBOutlet UITextField *textFieldConfirm;
    __weak IBOutlet UIView *myallView;
    
    __weak IBOutlet UITextField *verifyCodeField;
    __weak IBOutlet UIButton *getVerifyBtn;
    
    
    
    AlertView *alert;
    AlertView *alertAlloc;
    
}

@property (nonatomic, assign) id<RegisterViewControllerDelegate> delegate;
@property(nonatomic,assign) BOOL isPushBack; //登录完成之后，是否返回上一级界面


- (IBAction)registration:(id)sender;//注册


- (IBAction)GetVerifyCodeAction:(id)sender;


@end
