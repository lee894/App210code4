//
//  MemberActiveViewController.h
//  MySuperApp
//
//  Created by 1 on 14-9-9.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "LBaseViewController.h"

@interface MemberActiveViewController : LBaseViewController<ServiceDelegate,UITextFieldDelegate>
{
    MainpageServ *mainSer;

    
    IBOutlet UITextField *fieldPhone;
    IBOutlet UITextField *fieldCode;
    IBOutlet UITextField *fieldUser;
    IBOutlet UITextField *fieldPwd;
    IBOutlet UITextField *fieldPwdC;
    
    //线上或线下会员激活
    IBOutlet UITextField *fieldMobile;
    IBOutlet UITextField *fieldUseCode;
    
    
    __weak IBOutlet UIScrollView *myallView;
    __weak IBOutlet UIScrollView *myallView2;

    
    //门店会员激活 点击 YES 填出
    IBOutlet UITextField *fieldTextPhone;
    IBOutlet UITextField *fieldTextCode;
    IBOutlet UITextField *fieldTextAccount;
    IBOutlet UITextField *fieldTextPwd;
}


@property (nonatomic, weak) NSString *pwd;

@property (nonatomic, weak) NSString *username;
/*
 1、判断是否是线下会员弹出view  当输入用户名后
 2、点击登录  判断是否是线下会员弹出view
 3、主动门店激活   注册
 4、主动门店激活   登录
 */
@property (nonatomic, assign) NSInteger type;


- (IBAction)getCodeAndSubmit:(UIButton *)sender;

//线上或线下会员
- (IBAction)submitOrCode:(UIButton *)sender;

//门店会员激活 点击 YES 填出
- (IBAction)submit:(UIButton *)sender;
@end
