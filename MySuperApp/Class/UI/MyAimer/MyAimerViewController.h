//
//  MyAimerViewController.h
//  MySuperApp
//
//  Created by LEE on 14-3-29.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginLoginModel.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import "LBaseViewController.h"
#import "SinaClass.h"
#import "RegisterViewController.h"
#import "QQLogin.h"
#import "APService.h"
#import "WBHttpRequest.h"
#import "WeiboSDK.h"


@protocol LoginCallbackDelegate <NSObject>

@required
- (void)loginOKCallBack:(NSString*)prama;

@end


@interface MyAimerViewController : LBaseViewController <UITextFieldDelegate,ServiceDelegate,sinaLoginDelegate,RegisterViewControllerDelegate,TencentLoginDelegate,WXApiDelegate,WBHttpRequestDelegate> {

    BOOL userStates;//是否是输入用户后显示提示框
    BOOL loginStates;//是否是登录后显示提示框
    
    IBOutlet UITextField *textFieldAccount;
    IBOutlet UITextField *textFieldPassword;
        
    NSString *partner;
	NSString *seller;
    
    MainpageServ *mainSer;

    QQLogin *getQQinfo;
    TencentOAuth *tencentOAuth;

    
    NSString *userId;
    IBOutlet UIView *myallView;
    
    
    IBOutlet UIButton *qqloginBtn;
    IBOutlet UIButton *weibologinBtn;
    
    
    IBOutlet UIButton *alipayloginBtn;
    IBOutlet UIButton *wechatloginBtn;
    
    
    IBOutlet UILabel *qqloginLab;
    IBOutlet UILabel *weibologinLab;
    IBOutlet UILabel *alipyaloginLab;
    IBOutlet UILabel *wechatloginLab;

    
    LoginLoginModel *loginModel;
    NSMutableArray *permissions;
    UIView *offineView;
    
    UIView *memberView;//门店会员激活
    
    BOOL isPushBack;
}
@property(nonatomic,assign)id<LoginCallbackDelegate> delegate;

@property(nonatomic,assign) BOOL isPushBack; //登录完成之后，是否返回上一级界面

- (IBAction)registration:(id)sender;//注册
- (IBAction)login:(id)sender;//登录

- (IBAction)memberActive:(id)sender;//门店会员激活
- (IBAction)thirdLogin:(UIButton *)sender;//第三方登录

- (IBAction)yesOrNo:(UIButton *)sender;//判断是否是线下会员弹出view

@end
