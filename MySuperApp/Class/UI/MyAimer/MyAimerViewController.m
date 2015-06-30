//
//  MyAimerViewController.m
//  MySuperApp
//
//  Created by LEE on 14-3-29.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "MyAimerViewController.h"
#import "RegisterViewController.h"
#import "SBPublicFormatValidation.h"
#import "MYCommentAlertView.h"
#import "MemberActiveViewController.h"
#import "MyAimerloginViewController.h"
#import "FindPasswordViewController.h"
#import "ForgetPasswordViewController.h"

#import "MyAimerViewController.h"
#import "ModelManager.h"
#import "WeiboUser.h"

#import <AlipaySDK/AlipaySDK.h>
#import <AlipaySDK/APayAuthInfo.h>
#import "DataSigner.h"
#import "WXApiObject.h"

@interface MyAimerViewController () {

    int ailPayCount;
    
}

@end

@implementation MyAimerViewController

@synthesize isPushBack;  //登录成功之后自动返回上一级界面

- (id)init{
    self = [super init];
    if (self)
        self.title = @"我的爱慕";
    return self;
}

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
    
    self.title = @"我的爱慕";

//    //lee新增判断，如果需要返回的话，登陆界面返回到上一界面
        [self createBackBtnWithType:998];

    
    mainSer = [[MainpageServ alloc] init];
    mainSer.delegate = self;
    
    
    //lee999 修改位置
    if (![WXApi isWXAppInstalled]) {
        
        //移动支付宝的位置
        CGRect wechatbtnF = wechatloginBtn.frame;
        CGRect wechatLabF = wechatloginLab.frame;
        wechatLabF.origin.x += 5;
        [alipayloginBtn setFrame:wechatbtnF];
        [alipyaloginLab setFrame:wechatLabF];
        
        CGRect weibobtnF = weibologinBtn.frame;
        weibobtnF.origin.x += 40;
        CGRect weiboLabF = weibologinLab.frame;
        weiboLabF.origin.x += 40;
        [weibologinBtn setFrame:weibobtnF];
        [weibologinLab setFrame:weiboLabF];
        
        wechatloginBtn.hidden = YES;
        wechatloginLab.hidden = YES;
    }
    //end
    
    
    //lee999
    if (![TencentOAuth iphoneQQSupportSSOLogin]) {
        qqloginBtn.hidden = YES;
        
        CGRect oldF = weibologinBtn.frame;
        oldF.origin.x = 21.0;
        [weibologinBtn setFrame:oldF];
    }
    
    if (isIOS7up) {
        [myallView setFrame:CGRectMake(0, 0, 320, self.view.frame.size.height-0)];
    }
    
    textFieldAccount.clearButtonMode = UITextFieldViewModeWhileEditing;
    textFieldPassword.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    textFieldAccount.keyboardType = UIKeyboardTypeDefault;

    //创建右边按钮
    [self createRightBtn];
    [self.navbtnRight setTitle:@"找回密码" forState:UIControlStateNormal];
    [self.navbtnRight setTitle:@"找回密码" forState:UIControlStateHighlighted];
    [self.navbtnRight setFrame:CGRectMake(242, 7, 66, 32)];
    
    
    

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //lee999 判断微信登录是否成功，调去小纪接口
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(callUpWechatGetlogoindata)
                                                 name:@"weChatLoginOKCallBack" object:nil];
    
    //lee999 通知放在了这个位置
    //接收通知，是否支付宝登录成功
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(alipayloginOK:)
                                                 name:@"AlipayLogin" object:nil];
    
    
    //lee999  150628 新浪微博的回调
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(tranferUserInfo2:)
                                                 name:@"weiboLoginOKNotification" object:nil];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    textFieldAccount.text = @"";
    textFieldPassword.text= @"";
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"weChatLoginOKCallBack" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"AlipayLogin" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"weiboLoginOKNotification" object:nil];
    
    
    [self ShowFooterwithAnimated:YES];
}



-(void)viewDidUnload{
}


#pragma mark-- 登录成功的回调，隐藏界面
-(void)LoginOKhiddenMyVIew{
    
    [SingletonState sharedStateInstance].userHasLogin = YES;
    
    if ([self.delegate respondsToSelector:@selector(loginOKCallBack:)]) {
        [self.delegate loginOKCallBack:nil];
    }
    
    [self dismissViewControllerAnimated:NO completion:^{}];

    
    if ([self respondsToSelector:@selector(dismissViewControllerAnimated:completion:)]) {
        [self dismissViewControllerAnimated:NO completion:^{
        }];
    }else if([self respondsToSelector:@selector(dismissModalViewControllerAnimated:)]){
        [self dismissViewControllerAnimated:NO completion:^{}];
    }
}


-(void)rightButAction{
    ForgetPasswordViewController *tempForget = [[ForgetPasswordViewController alloc] initWithNibName:@"ForgetPasswordViewController" bundle:nil];
    [self.navigationController pushViewController:tempForget animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- UITextField 键盘消失
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [textFieldAccount resignFirstResponder];
    [textFieldPassword resignFirstResponder];
}

#pragma mark -- UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textFieldAccount resignFirstResponder];
    [textFieldPassword resignFirstResponder];
    if ([textFieldAccount.text isEqualToString:@""] || [textFieldPassword.text isEqualToString:@""]) {
        [MYCommentAlertView showMessage:@"请输入用户名或密码" target:nil];
        return YES;
    }
    [self login:nil];
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == textFieldAccount) {
        if (textFieldAccount.text.length != 0) {
            //lee999 这个要求注释掉了....
//            if (![SBPublicFormatValidation boolEmailCheckNumInput:textFieldAccount.text]) {//不是邮箱
//                if ([SBPublicFormatValidation boolCheckPhoneNumInput:textFieldAccount.text]) {//是正确的手机号
//                    [mainSer getCheckOfflineMobile:textFieldAccount.text andType:@"login"];
//                    ((UIButton *)[self.view viewWithTag:209]).enabled = NO;
//                } else {
//                    [MYCommentAlertView showMessage:@"手机号格式不正确" target:nil];
//                }
//            }
            
            //lee999recode
//            if (!([NSString isValidTelephoneNum2:textFieldAccount.text] || [NSString isValidateEmail:textFieldAccount.text]) ) {
//                [MYCommentAlertView showMessage:@"您输入的用户名不正确，请重新输入" target:nil];
//                return;
//            }
            
            //end
            [mainSer getCheckOfflineMobile:textFieldAccount.text andType:@"login"];
            ((UIButton *)[self.view viewWithTag:209]).enabled = NO;
        }
    }
}

#pragma mark -- 按钮事件

- (IBAction)registration:(id)sender//注册
{
    RegisterViewController *tempRegister = [[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
    tempRegister.delegate = self;
    tempRegister.isPushBack = self.isPushBack;
    [self.navigationController pushViewController:tempRegister animated:YES];
}

#pragma mark RegisterViewControllerDelegate
- (void)registerSucces
{
    MyAimerViewController *tempAimer = [[MyAimerViewController alloc] initWithNibName:@"MyAimerViewController" bundle:nil];
    [self.navigationController pushViewController:tempAimer animated:YES];
}


- (IBAction)login:(id)sender//登录
{
    if ([textFieldAccount.text isEqualToString:@""] || [textFieldPassword.text isEqualToString:@""]) {
        [MYCommentAlertView showMessage:@"请输入用户名或密码" target:nil];
    }else{
        [self.view endEditing:YES];
        
        NSDictionary *dic1  = [NSDictionary dictionaryWithObjectsAndKeys:textFieldAccount.text, @"UserName",nil];
        [TalkingData trackEvent:@"5009" label:@"登录" parameters:dic1];
        
        [mainSer initWithusername:textFieldAccount.text email:@"" andMobilephone:@"" andPassword:textFieldPassword.text];
    }
    [self.view endEditing:YES];
}

#pragma mark 门店会员激活
- (IBAction)memberActive:(id)sender//
{
    
    UIAlertView *alertv = [[UIAlertView alloc] initWithTitle:@"爱慕提示" message:@"您是否已经拥有爱慕官方商城账号？" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
    alertv.tag = 10030;
    [alertv show];
    
//    UIView *viewMember = [[[NSBundle mainBundle] loadNibNamed:@"MemberView" owner:self options:nil] lastObject];
//    memberView = viewMember;
//    [memberView setFrame:CGRectMake(lee1fitAllScreen(20), 100, 285, 161)];
//    [self.view addSubview:viewMember];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (alertView.tag == 10030) {
        if (buttonIndex == 0) {
            //NO
            
            MemberActiveViewController *memberViewC = [[MemberActiveViewController alloc] initWithNibName:@"MemberActiveViewController" bundle:nil];
            memberViewC.type = 3;
            [self.navigationController pushViewController:memberViewC animated:YES];
        }else{
        //YES
            
            MemberActiveViewController *memberViewC = [[MemberActiveViewController alloc] initWithNibName:@"ActiveLoginViewController" bundle:nil];
            memberViewC.type = 4;
            [self.navigationController pushViewController:memberViewC animated:YES];
        }
    }else if(alertView.tag == 10031){
        //线下会员激活
        
        if (buttonIndex == 1) {
            //是
            
            if (userStates) {
                MemberActiveViewController *memberViewC = [[MemberActiveViewController alloc] initWithNibName:@"MemberActiveViewController" bundle:nil];
                memberViewC.username= textFieldAccount.text;
                memberViewC.type = 1;
                [self.navigationController pushViewController:memberViewC animated:YES];
            } else if (loginStates) {
                MemberActiveViewController *loginViewC = [[MemberActiveViewController alloc] initWithNibName:@"ActiveLoginViewController" bundle:nil];
                loginViewC.type = 2;
                loginViewC.username= textFieldAccount.text;
                loginViewC.pwd = textFieldPassword.text;
                [self.navigationController pushViewController:loginViewC animated:YES];
            }
        }
        loginStates = NO;
        userStates = NO;
    }
}



//- (IBAction)memberActiveNoOrYes:(UIButton *)sender//门店会员激活
//{
//    [memberView removeFromSuperview];
//    switch (sender.tag) {
//        case 91://NO
//        {
//            MemberActiveViewController *memberViewC = [[MemberActiveViewController alloc] initWithNibName:@"MemberActiveViewController" bundle:nil];
//            memberViewC.type = 3;
//            [self.navigationController pushViewController:memberViewC animated:YES];
//        }
//            break;
//        case 90://yes
//        {
//            MemberActiveViewController *memberViewC = [[MemberActiveViewController alloc] initWithNibName:@"ActiveLoginViewController" bundle:nil];
//            memberViewC.type = 4;
//            [self.navigationController pushViewController:memberViewC animated:YES];
//        }
//        default:
//            break;
//    }
//}


#pragma mark 第三方登录
- (IBAction)thirdLogin:(UIButton *)sender
{
    switch (sender.tag) {
        case 51://qq
        {
        
            [TalkingData trackEvent:@"5009" label:@"QQ快捷登录" parameters:nil];
            //qq联合登录
            if (!tencentOAuth) {
                tencentOAuth = [[TencentOAuth alloc] initWithAppId:kQQAppID andDelegate:self];
            }
            NSArray *permissionsss = [NSArray arrayWithObjects:@"all", nil];
            [tencentOAuth authorize:permissionsss inSafari:NO];
        }
            break;
        case 52://sina
            
            if ([WeiboSDK isWeiboAppInstalled]) {
                [self ssoButtonPressed];
            }else{
                
                [SinaClass sinaLogin];
                [SinaClass shareWBInfo].loginDelegate = self;
            }
            
            
            break;
        case 53://支付宝
        {
            [self trustload];
        }
            break;
            
        case 54://微信登录
        {
            
            if (![WXApi isWXAppInstalled]) {
                [LCommentAlertView showMessage:@"您还未安装微信，请换其他登录方式" target:nil];
                return;
            }
            
            [self WXsendAuthRequest];
        }
            break;
        default:
            break;
    }
}



- (void)ssoButtonPressed
{
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = kAppRedirectURI;
    request.scope = @"all";
    request.userInfo = @{@"SSO_From": @"SendMessageToWeiboViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    [WeiboSDK sendRequest:request];
}



-(void)WXsendAuthRequest
{
    //构造SendAuthReq结构体
    SendAuthReq* req =[[SendAuthReq alloc] init];
    req.scope = @"snsapi_userinfo" ;
    req.state = @"23987123" ;
    //第三方向微信终端发送一个SendAuthReq消息结构
    [WXApi sendReq:req];
}

-(void)callUpWechatGetlogoindata{
    
    if ([SingletonState sharedStateInstance].isWeChatLoginCallBackOK) {
    
        NSString *str = [SingletonState sharedStateInstance].weChatLoginCallBackstring;
        
        if ([str description].length > 0) {
            
            [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
            
            NSArray *arr = [str componentsSeparatedByString:@","];
            
            [mainSer getWechatCallBack:[arr objectAtIndex:0 isArray:nil]
                               andName:[arr objectAtIndex:1 isArray:nil]];
        }
    }
}


#pragma mark -- qq登录回调
- (void)tencentDidLogin{
    [tencentOAuth getUserInfo];
}

- (void)getUserInfoResponse:(APIResponse*) response{
    
    NSLog(@"qq联合登陆返回数据----%@",response.jsonResponse);
    
    NSString *nikename = [response.jsonResponse objectForKey:@"nickname"];
    NSString *figureurl = [response.jsonResponse objectForKey:@"figureurl"];
    NSString *gender = [response.jsonResponse objectForKey:@"gender"];
        
    [mainSer getqqCallBack:[tencentOAuth openId] andNickName:nikename andFigureurl:figureurl andGender:gender];
    [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
}

- (void)tencentDidNotLogin:(BOOL)cancelled
{
    if (cancelled) {
        [SBPublicAlert showAlertTitle:@"用户取消登录" Message:nil];
    }else{
        [SBPublicAlert showAlertTitle:@"登录失败" Message:nil];
    }
}

- (void)tencentDidNotNetWork{
    [MYCommentAlertView showMessage:@"您的网络异常" target:nil];
}



#pragma mark -- 新浪微博登录代理
//web
- (void)tranferUserInfo:(NSMutableDictionary *)userInfo
{
    NSDictionary *dic1  = [NSDictionary dictionaryWithObjectsAndKeys:[userInfo objectForKey:@"name"], @"UserName",nil];
    [TalkingData trackEvent:@"5009" label:@"sina快捷登录" parameters:dic1];
    
    [mainSer getSinaCallBack:[userInfo objectForKey:@"id"] andName:[userInfo objectForKey:@"name"] andGender:[userInfo objectForKey:@"gender"] andImageUrl:[userInfo objectForKey:@"profile_image_url"]];
    [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
}

//sso
- (void)tranferUserInfo2:(NSNotification *)auserInfo
{
    WeiboUser *userInfo = [auserInfo object];
    
    NSDictionary *dic1  = [NSDictionary dictionaryWithObjectsAndKeys:userInfo.name, @"UserName",nil];
   [TalkingData trackEvent:@"5009" label:@"sina快捷登录" parameters:dic1];
    
    [mainSer getSinaCallBack:userInfo.userID
                     andName:userInfo.name
                   andGender:userInfo.gender
                 andImageUrl:userInfo.profileImageUrl];
    [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
}





#pragma mark -- net request delegate
-(void)serviceStarted:(ServiceType)aHandle{
}

-(void)serviceFailed:(ServiceType)aHandle{
    [SBPublicAlert hideMBprogressHUD:self.view];
}

-(void)serviceFinished:(ServiceType)aHandle withmodel:(id)amodel{
    
    LBaseModel *model = (LBaseModel *)amodel;
    
    switch (model.requestTag) {
        case Http_Qqcallback_Tag:
        case Http_Sinaweibo_Tag:
        case Http_whchatLogin_Tag:
        case Http_Login_Tag:
        {
            if (!model.errorMessage) {
                [SBPublicAlert hideMBprogressHUD:self.view];
                loginModel = (LoginLoginModel *)model;
                
                
                [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%.f",[loginModel shopcartcount]] forKey:@"totalNUM"];
                
                [UIApplication sharedApplication].applicationIconBadgeNumber=[[[NSUserDefaults standardUserDefaults]objectForKey:@"totalNUM"]intValue];

                [[NSNotificationCenter defaultCenter] postNotificationName:@"TotleNumber" object:nil];
                
                [[NSUserDefaults standardUserDefaults] setObject:loginModel.userssion forKey:@"usersession"];
                //登录成功
                [SingletonState sharedStateInstance].userHasLogin = YES;
                [[NSUserDefaults standardUserDefaults] synchronize];

                //lee999 150513 设置设备别名
                [APService setAlias:loginModel.userid callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:nil];
                
                //lee999 150513 设置设备tag
                NSSet * set = [[NSSet alloc] initWithObjects:@"登录", nil];
                [APService setTags:set callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:nil];
                
//                [[APService setTags:[NSSet set] alias:[NSString stringWithFormat:@"%@",loginModel.userid] callbackSelector:@selector(nullAction) object:nil];
//                userid
                
                //lee999 new
                [SingletonState sharedStateInstance].userHasLogin = YES;

                [self performSelector:@selector(LoginOKhiddenMyVIew) withObject:nil afterDelay:0.2];
                
//                [self dismissModalViewControllerAnimated:NO];
//                [self.navigationController dismissViewControllerAnimated:NO completion:^{}];
//                [self.presentingViewController dismissViewControllerAnimated:NO completion:^{}];
//                [self dismissViewControllerAnimated:NO completion:^{}];

//                [self LoginOKhiddenMyVIew];
                
//                //lee999新增  141117
//                if ([SingletonState sharedStateInstance].isProductDetailGotoLogin) {
//                    
//                    [self changeToLastShopView];
//                    [SingletonState sharedStateInstance].isProductDetailGotoLogin = NO;
//                    return;
//                }
//                //end
//                
//                
//                //lee新增判断，如果登录成功就，直接返回上一界面
//                if (isPushBack) {
//                    [self.navigationController popViewControllerAnimated:NO];
//                    return;
//                }
//                
//                if ([loginModel.vip isEqualToString:@"y"]) {
//                    [self.view endEditing:YES];
//                    UIView *offine = [[[NSBundle mainBundle] loadNibNamed:@"PromptView" owner:self options:nil] lastObject];
//                    offineView = offine;
//                    [self.view addSubview:offineView];
//                    loginStates = YES;
//                    
//                }else{
//                    MyAimerloginViewController *tempAimer = [[MyAimerloginViewController alloc] initWithNibName:@"MyAimerloginViewController" bundle:nil];
//                    [self.navigationController pushViewController:tempAimer animated:YES];
//                }
            }else {
                [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:1.0];
            }
        }
            break;
        case Http_CheckOfflineMobile_Tag:
            ((UIButton *)[self.view viewWithTag:209]).enabled = YES;
            if (!model.errorMessage) {
                CheckCheckOffineMobile *offineModel = (CheckCheckOffineMobile *)model;
                if ([offineModel.offline isEqualToString:@"y"]) {
                    [self.view endEditing:YES];

                    
                    UIAlertView *alertv = [[UIAlertView alloc] initWithTitle:@"爱慕提示" message:@"您已经是爱慕集团实体店会员，立即激活账号!" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
                    alertv.tag = 10031;
                    [alertv show];
                    
//                    UIView *offine = [[[NSBundle mainBundle] loadNibNamed:@"PromptView" owner:self options:nil] lastObject];
//                    offineView = offine;
//                    [self.view addSubview:offineView];
//                    userStates = YES;
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
    
    [SBPublicAlert hideMBprogressHUD:self.view];
}


//#pragma mark 判断是否是线下会员弹出view
//- (IBAction)yesOrNo:(UIButton *)sender
//{
//    switch (sender.tag) {
//        case 80://yes
//        {
//            if (userStates) {
//                MemberActiveViewController *memberViewC = [[MemberActiveViewController alloc] initWithNibName:@"MemberActiveViewController" bundle:nil];
//                memberViewC.username= textFieldAccount.text;
//                memberViewC.type = 1;
//                [self.navigationController pushViewController:memberViewC animated:YES];
//            } else if (loginStates) {
//                MemberActiveViewController *loginViewC = [[MemberActiveViewController alloc] initWithNibName:@"ActiveLoginViewController" bundle:nil];
//                loginViewC.type = 2;
//                loginViewC.username= textFieldAccount.text;
//                loginViewC.pwd = textFieldPassword.text;
//                [self.navigationController pushViewController:loginViewC animated:YES];
//            }
//        }
//            break;
//        default:
//            break;
//    }
//    loginStates = NO;
//    userStates = NO;
//    [offineView removeFromSuperview];
//}



- (void)tagsAliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias {
    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
}


#pragma mark === 支付宝的快捷登录方法===支付宝被要求换回老的参数了===
- (void)trustload
{
    //lee999  支付宝被要求换回老的参数了
    
    NSString *partner22 = @"2015010600023628";//@"2088801027555881";
    
    NSString* temp= [self trustLogin:partner22 setuserID:@""];
    [self lanchstring:temp];
}

- (NSString *)trustLogin:(NSString*) partnerId setuserID:(NSString*) appUserID
{
    NSMutableString* sb = nil;
    sb = [[NSMutableString alloc] init];
    [sb appendString:@"app_name=\"mc\"&biz_type=\"trust_login\"&partner=\""];
    [sb appendString:partnerId];
    
    if (appUserID != nil&& appUserID.length > 0)//!appUserID.equalsIgnoreCase("null")
    {
        [sb appendString:@"\"&app_userid=\""];
        [sb appendString:appUserID];
    }
    [sb appendString:@"\"&notify_url=\"" ];
    [sb appendString:@"http%3A%2F%2Fnotify.msp.hk%2Fnotify.htm"];
    [sb appendString:@"\""];
	
    return sb;
}

- (void)lanchstring:(NSString*) sb
{
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"AlixPayLogin"];

    
	NSString *appScheme = @"com.aimer.iphone://";
    //[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"]; //应用注册scheme用于安全支付成功后重新唤起商户应用
    
    NSString *pid = @"2088511921246102";
    NSString *appid = @"2015010600023628";
    NSString *returnUri = appScheme;//@"alisdkdemo://";
    
    APayAuthInfo *info = [[APayAuthInfo alloc] initWithAppID:appid
                                                     pid:pid
                                             redirectUri:returnUri];
    //H5页面授权返回结果在*resultDic中获取
    [[AlipaySDK defaultService] authWithInfo:info callback:^(NSDictionary *resultDic)
     {
         NSLog(@"resultDic111----%@",resultDic);
         if (resultDic[@"authCode"]!=nil)
         {
             NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:resultDic[@"authCode"],@"authCode", nil];
             [[NSNotificationCenter defaultCenter] postNotificationName:@"AlipayLogin" object:dic];
         }
     }];
//    [[AlipaySDK defaultService] authWithInfo:info callback:^(NSDictionary *resultDic) {
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:resultDic[@"authCode"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
//        [alertView show];
//    }];
    
    
    /*
    
    NSString *bankCode = [[NSUserDefaults standardUserDefaults] objectForKey:@"bank_code"];
    if (bankCode)
    {
        NSMutableString *orderSpecTemp = [[NSMutableString alloc] initWithString:sb];
        [orderSpecTemp appendFormat:@"&appname=\"mc\"&biz_type=\"quickpaypre\"&mspfid=\"creditquickpay:%@\"", bankCode];
        
        sb = [NSString stringWithString:orderSpecTemp];
    }
    
	id<DataSigner> signer = nil;
	
//	signer = CreateRSADataSigner([[NSBundle mainBundle] objectForInfoDictionaryKey:@"RSA private key"]);

 //lee999  支付宝被要求换回老的参数了
    signer = CreateRSADataSigner(@"MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBAOp1l/rTHLBuQrLmv8A9KvCwwlM6xp+EGOv2fdXFot98SknElsVn+kiCItOulBGhyZ5VJXKlccUUTP4dRZ0FSccELlW49kDToltcQ014lw8fF1t+d22I/RdOtOTpkP+GnxH1RW0nnBFwomemUWF/HoKEUnwbViMHi+vTfPW4iB2tAgMBAAECgYEAtoy2t4m2Nbyz2/2D4Rb/HwZRV2JVEhBVIyv5j/9gsCdi5ArX5X3uxpPkr/KmwQ+6Hrhm/tvIOE11IQoDkJ10ca2fpJhV3Dse+C9UkEWYBMkmUQ+Kf7EoIK3h4wpSdXlJzDH+C2Zs/XiYaZuucAPYKuuWfsbDHIuQ7OtuZ69PLhUCQQD9CTJhb/M//jn/pFEcqJ4HTpCzxsXQYqs6kb80araH0Q6NgQk42Q3Wt1CeKbD7rh2DEbYuaA3xJO0y5qh+B6SDAkEA7TSwg5YS0DHaR7YuX0+2qsphqEA6p4BXAeXYdedCGSmV1g8BaZRuo9ZhBDEAo0QCwQ8dEEuJXz23vbGfl99+DwJBAKGdtSsc+Q4/j8XjqtcWL9FU8gGRjRlbXCiNnMWa/zjiY1woNb60jC0/auOKl3s5K6pirq0XUwhZ4JLpVmcg9IcCQQDOqzWPsFW753OTP3uvtzgkHihv+2YfQoaMNMIgF9lTKxRNaM2GO7kaLlJg4ID5vuvXYV+lLusFfDR2pieynxqpAkAr7ZvC9Nn1YKs9sG4Vgr3+HstrlRe9es7OkjVswKHT5/N9zU4xl0Fdt+6UFP5WzqGNiWSMp4YdUcTpyMPf2+L/");

	
	NSString *signedString = [signer signString:sb];
	NSString *orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                             sb, signedString, @"RSA"];
	
	AlixPay * alixpay = [AlixPay shared];
	int ret = [alixpay pay:orderString applicationScheme:appScheme];
	
	if (ret == kSPErrorAlipayClientNotInstalled) {
		UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示"
															 message:@"您还没有安装支付宝的客户端，请先装。"
															delegate:self
												   cancelButtonTitle:@"取消"
												   otherButtonTitles:@"确定",nil];
		[alertView setTag:123];
		[alertView show];
	}
	else if (ret == kSPErrorSignError) {
		NSLog(@"签名错误！");
	}
     
     */
}

-(void)alipayloginOK:(NSNotification*)notification
{
    NSDictionary *dic = notification.object ;//[(NSString *)notification.object componentsSeparatedByString:@"&"];
    NSString *token = [dic objectForKey:@"authCode"];
    
    if ([token description].length > 1) {
        
//        NSRange range2 =  [[arr objectAtIndex:0] rangeOfString:@"token="];
//        NSString* temp1 = [[arr objectAtIndex:0] substringFromIndex:(range2.location+7)];
//        temp1 = [temp1 stringByReplacingOccurrencesOfString:@"\"" withString:@""];
//        NSRange range=  [[arr objectAtIndex:1] rangeOfString:@"userid="];
//        NSString* temp = [[arr objectAtIndex:1] substringFromIndex:(range.location+8)];
//        NSRange temprange = [temp rangeOfString:@"\""];
//        NSString* userid = [temp substringToIndex:temprange.location];
        
//        NSDictionary *dic1  = [NSDictionary dictionaryWithObjectsAndKeys:userid, @"UserName",nil];
//        [TalkingData trackEvent:@"5009" label:@"支付宝快捷登录" parameters:dic1];

        [mainSer getAlipayloginWithauthcode:token];
        [SBPublicAlert showMBProgressHUD:@"正在登录···" andWhereView:self.view states:NO];

    }else{
        [SBPublicAlert showMBProgressHUD:@"登录失败" andWhereView:self.view hiddenTime:0.6];
    }
}



//#pragma mark -- 屏幕旋转
////iOS 5
//- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
//{
//	return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
//}
////iOS 6
//- (BOOL)shouldAutorotate
//{
//	return NO;
//}
//- (NSUInteger)supportedInterfaceOrientations
//{
//	return UIInterfaceOrientationMaskPortrait;
//}
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
//{
//	return UIInterfaceOrientationPortrait;
//}


@end
