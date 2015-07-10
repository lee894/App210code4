//
//  QQLogin.m
//  Ceshi
//
//  Created by 昝驹 on 13-12-25.
//  Copyright (c) 2014年 xie xianhui. All rights reserved.
//

#import "QQLogin.h"

#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/TencentOAuthObject.h>
#import <TencentOpenAPI/TencentApiInterface.h>
#import <TencentOpenAPI/TencentMessageObject.h>

@interface QQLogin () {
    time_t                  loginTime;
}

@end

@implementation QQLogin




- (id)init:(GetQQuserInfoDic)getInfoDic {
    
    
    
    if (self = [super init]) {
        
        [self login];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccessed:) name:kLoginSuccessed object:[sdkCall getinstance]];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginFailed) name:kLoginFailed object:[sdkCall getinstance]];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onResp:) name:kTencentApiResp object:[sdkCall getinstance]];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(analysisResponse:) name:kGetUserInfoResponse object:[sdkCall getinstance]];
        
        self.getQQinfo = getInfoDic;
    }
    
    return self;
}

- (void)login
{
    time_t currentTime;
    time(&currentTime);
    
    if ((currentTime - loginTime) > 2)
    {
        NSArray *permissions = [NSArray arrayWithObjects:@"all", nil];
        [[[sdkCall getinstance] oauth] authorize:permissions inSafari:YES];
        
        loginTime = currentTime;
    }
}


#pragma mark message
- (void)loginSuccessed:(NSNotification *)notify
{
    if (NO == [[[sdkCall getinstance] oauth] getUserInfo])
    {
        [sdkCall showInvalidTokenOrOpenIDMessage];
    };
}

- (void)loginFailed
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"结果" message:@"登录失败" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
    [alertView show];
}

-(void)onResp:(id)sender{
}



- (void)analysisResponse:(NSNotification *)notify
{
    if (notify)
    {
        APIResponse *response = [[notify userInfo] objectForKey:kResponse];
        if (URLREQUEST_SUCCEED == response.retCode && kOpenSDKErrorSuccess == response.detailRetCode)
        {
            
            if (self.getQQinfo) {
                self.getQQinfo (response.jsonResponse);
            }
        }
        else
        {
            NSString *errMsg = [NSString stringWithFormat:@"errorMsg:%@\n%@", response.errorMsg, [response.jsonResponse objectForKey:@"msg"]];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"操作失败" message:errMsg delegate:self cancelButtonTitle:@"我知道啦" otherButtonTitles: nil];
            [alert show];
        }
    }
}


@end
