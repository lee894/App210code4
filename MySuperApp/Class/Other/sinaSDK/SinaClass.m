//
//  SinaClass.m
//  透明爱
//
//  Created by 郝 建军 on 13-5-25.
//  Copyright (c) 2014年 hao. All rights reserved.
//

#import "SinaClass.h"
#import "MYMacro.h"

@implementation SinaClass
static SinaClass *sinaClass;
@synthesize openID,actionToken,expiraDate;
@synthesize sinaWB;
@synthesize loginDelegate;
@synthesize status;
@synthesize shareText;
@synthesize shareImage;

- (void)encodeWithCoder:(NSCoder *)aCoder{
 
    [aCoder encodeObject:openID forKey:@"openid"];
    [aCoder encodeObject:actionToken forKey:@"token"];
    [aCoder encodeObject:expiraDate forKey:@"data"];
}
- (id)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super init]){
        openID = [aDecoder decodeObjectForKey:@"openid"];
        actionToken = [aDecoder decodeObjectForKey:@"token"];
        expiraDate = [aDecoder decodeObjectForKey:@"data"];
    }
    return self;
}

+(SinaClass *)setWB:(SinaClass *)sina{
    if(sinaClass)
    sinaClass = nil;
    sinaClass = sina;
    
    if(![SinaClass shareWBInfo].sinaWB){
        [SinaClass shareWBInfo].sinaWB = [[SinaWeibo alloc] initWithAppKey:kAppKey appSecret:kAppSecret appRedirectURI:kAppRedirectURI andDelegate:nil];
        [SinaClass shareWBInfo].sinaWB.delegate = [SinaClass shareWBInfo];
    
    }
    [SinaClass shareWBInfo].sinaWB.userID = [SinaClass shareWBInfo].openID;
    [SinaClass shareWBInfo].sinaWB.accessToken = [SinaClass shareWBInfo].actionToken;
    [SinaClass shareWBInfo].sinaWB.expirationDate = [SinaClass shareWBInfo].expiraDate;
  
    return sinaClass;
}

+(void)initialize{
    if (sinaClass==nil) {
        sinaClass=[[SinaClass alloc] init];
    }
}
+(SinaClass *)shareWBInfo{
    return sinaClass;
}

-(id)init{
    if (self=[super init]) {
        openID = @"";
        actionToken = @"";
        expiraDate = nil;
        sinaWB = [[SinaWeibo alloc] initWithAppKey:kAppKey appSecret:kAppSecret appRedirectURI:kAppRedirectURI andDelegate:nil];
       sinaWB.delegate = self;
    }
    return self;
}


#pragma mark- 一键绑定
+(void)sinaLogin{
    [self loginOut];
    [[SinaClass shareWBInfo].sinaWB logIn];
}
#pragma mark- 注销
+(void)loginOut{
    [[SinaClass shareWBInfo].sinaWB logOut];
    [SinaClass shareWBInfo].openID = @"";
    [SinaClass shareWBInfo].actionToken = @"";
    [SinaClass shareWBInfo].expiraDate = nil;
    sinaSave
}
#pragma mark- 一键分享
+(void)sendShare:(NSString *)text andImage:(UIImage *)weiboImg{
    
    [SinaClass shareWBInfo].shareText = text;
    [SinaClass shareWBInfo].shareImage = weiboImg;
    if([[SinaClass shareWBInfo].openID isEqualToString:@""]){
        [SinaClass sinaLogin];
        [SinaClass shareWBInfo].status = @"分享";
    }

    if(![SinaClass shareWBInfo].shareImage){
        [SinaClass shareWBInfo].shareImage = [UIImage imageNamed:@""];
    }
    [[SinaClass shareWBInfo].sinaWB requestWithURL:@"statuses/upload.json"
                                            params:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                                    [SinaClass shareWBInfo].shareText, @"status",
                                                    [SinaClass shareWBInfo].shareImage, @"pic", nil]
                                        httpMethod:@"POST"
                                          delegate:[SinaClass shareWBInfo]];
}

#pragma mark - SinaWeibo Delegate
- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboDidLogIn userID = %@ accesstoken = %@ expirationDate = %@ refresh_token = %@", sinaweibo.userID, sinaweibo.accessToken, sinaweibo.expirationDate,sinaweibo.refreshToken);
    [SinaClass shareWBInfo].openID = sinaweibo.userID;
    [SinaClass shareWBInfo].actionToken = sinaweibo.accessToken;
    [SinaClass shareWBInfo].expiraDate = sinaweibo.expirationDate;

    
    //保存信息
    sinaSave
    [self getUserInfo];
    
}
- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboDidLogOut");
   
}
- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo
{
    
    if([loginDelegate respondsToSelector:@selector(cancelShare)]) {
        [loginDelegate cancelShare];
        
    }
//    [SBPublicAlert hideMBprogressHUD:self.view];
}
- (void)sinaweibo:(SinaWeibo *)sinaweibo logInDidFailWithError:(NSError *)error
{
    NSLog(@"sinaweibo logInDidFailWithError %@", error);
}
- (void)sinaweibo:(SinaWeibo *)sinaweibo accessTokenInvalidOrExpired:(NSError *)error
{
    NSLog(@"sinaweiboAccessTokenInvalidOrExpired %@", error);
   
}
#pragma mark- 获取用户信息
-(void)getUserInfo{
    [[SinaClass shareWBInfo].sinaWB requestWithURL:@"users/show.json"
                   params:[NSMutableDictionary dictionaryWithObject:sinaWB.userID forKey:@"uid"]
               httpMethod:@"GET"
                 delegate:self];
}
#pragma mark- SinaWeiboRequestDelegate
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    NSMutableDictionary * userDic = nil;
    if ([request.url hasSuffix:@"users/show.json"])//用户信息
    {
        NSLog(@"**********%@",request.url);
        userDic = result;
        //获取用户信息详情
        if(loginDelegate&&[loginDelegate respondsToSelector:@selector(tranferUserInfo:)])
//        [loginDelegate getuserInfo:[userDic objectForKey:@"name"]];
        [loginDelegate tranferUserInfo:userDic];
        if ([[SinaClass shareWBInfo].status isEqualToString:@"分享"]) {
            if(![SinaClass shareWBInfo].shareImage){
                [SinaClass shareWBInfo].shareImage = [UIImage imageNamed:@""];
            }
            
            [[SinaClass shareWBInfo].sinaWB requestWithURL:@"statuses/upload.json"
                                                    params:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                                            [SinaClass shareWBInfo].shareText, @"status",
                                                            [SinaClass shareWBInfo].shareImage, @"pic", nil]
                                                httpMethod:@"POST"
                                                  delegate:[SinaClass shareWBInfo]];
        }
        
        
    }
    else if ([request.url hasSuffix:@"statuses/user_timeline.json"])//获取微博信息
    {
        userDic = [result objectForKey:@"statuses"];
    }
    else if ([request.url hasSuffix:@"statuses/update.json"])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:[NSString stringWithFormat:@"Post status \"%@\" succeed!", [result objectForKey:@"text"]]
                                                           delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
    }
    else if ([request.url hasSuffix:@"statuses/upload.json"])
    {    
        if(loginDelegate)
            [loginDelegate shareSuccess];
    }
    
}
- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error{
    if([loginDelegate respondsToSelector:@selector(failed)])
        [loginDelegate failed];
}

@end
