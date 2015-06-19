//
//  AppDelegate.m
//  aimerOnline
//
//  Created by lee on 14-2-28.
//  Copyright (c) 2014年 aimer. All rights reserved.
//

#import "AppDelegate.h"
#import "MYMacro.h"
#import "AlixPay.h"
#import <AlipaySDK/AlipaySDK.h>
#import "TalkingData.h"
#import "AlipayHelper.h"
#import "RDVTabBarController.h"
#import "RDVTabBarItem.h"

#import "LNewHomePageViewController.h"

#import "MainpageViewController.h"
#import "NewPageViewController.h"
#import "HotpageViewController.h"
#import "SearchpageViewController.h"
#import "CarpageViewController.h"
#import "LNavigationRightViewController.h"

#import "MainpageViewController.h"
#import "UIDevice-Hardware.h"

//#import "HomepageViewController.h"
#import "MainpageViewController.h"
//#import "GotoMallViewController.h"
#import "BrandlistViewController.h"
//#import "MagazineViewController.h"
#import "AMMapViewController.h"
//#import "GotoAimerViewController.h"
#import "MyAimerViewController.h"
#import "MyAimerloginViewController.h"
#import "NewMaginzeListViewController.h"
#import "NewSortViewController.h"

#import "APService.h"
#import "ShareMsgView.h"
#import "MYCommentAlertView.h"

//以下是腾讯QQ和QQ空间
#import <TencentOpenAPI/QQApi.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <ShareSDK/ShareSDK.h>
#import "WeiboSDK.h"
#import <RennSDK/RennSDK.h>


@implementation AppDelegate
//@synthesize aktabBarVerticalController;
@synthesize mySingle;
@synthesize splashView;
@synthesize navMyaimerVC;
//@synthesize aktabBarRightController;
@synthesize tablebarType;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    mySingle = [SingletonState sharedStateInstance];

    
    //注册微信
    [WXApi registerApp:kWeiXinKey];
    
    [TalkingData sessionStarted:@"D64AA344396F8BB6E1BCB7FD57473163" withChannelId:AimerChannelId];
    
    //判断用户是否登录
    NSLog(@"用户的usersession是：%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"usersession"]);
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"usersession"]) {
        mySingle.userHasLogin = YES;
    }else{
        mySingle.userHasLogin = NO;
    }
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    
    [self createbaiduMap];
    //加载视图
    [self loadMainView];
    
    
    //lee999 设置气泡
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"totalNUM"]intValue] > 0) {
        [[[[app.mytabBarController tabBar] items] objectAtIndex:3] setBadgeValue:[[NSUserDefaults standardUserDefaults]objectForKey:@"totalNUM"]];
    }else{
        [[[[app.mytabBarController tabBar] items] objectAtIndex:3] setBadgeValue:@""];
    }
    
    
    //shareSDK
    [ShareSDK registerApp:@"249d8a8daee6"];     //参数为ShareSDK官网中添加应用后得到的AppKey
    //添加新浪微博应用 注册网址 http://open.weibo.com
    [ShareSDK connectSinaWeiboWithAppKey:kAppKey
                               appSecret:kAppSecret
                             redirectUri:kAppRedirectURI];
    //当使用新浪微博客户端分享的时候需要按照下面的方法来初始化新浪的平台
    [ShareSDK  connectSinaWeiboWithAppKey:kAppKey
                                appSecret:kAppSecret
                              redirectUri:kAppRedirectURI
                              weiboSDKCls:[WeiboSDK class]];
    
    //OK添加QQ空间应用  注册网址  http://connect.qq.com/intro/login/
    [ShareSDK connectQZoneWithAppKey:@"100371282"//kQQAppID
                           appSecret:@"aed9b0303e3ed1e27bae87c33761161d"//@"6b3963146c5732afd23652e3082fc6f7"
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];
    
    //添加QQ应用  注册网址  http://mobile.qq.com/api/
    [ShareSDK connectQQWithQZoneAppKey:@"100371282"//kQQAppID
                     qqApiInterfaceCls:[QQApiInterface class]
                       tencentOAuthCls:[TencentOAuth class]];
    
    
    
    [ShareSDK connectQZoneWithAppKey:@"100371282"
                           appSecret:@"aed9b0303e3ed1e27bae87c33761161d"
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];
    
    //添加微信应用 注册网址 http://open.weixin.qq.com
    [ShareSDK connectWeChatWithAppId:kWeiXinKey
                           wechatCls:[WXApi class]];
    
    //添加豆瓣应用  注册网址 http://developers.douban.com
    [ShareSDK connectDoubanWithAppKey:@"04bad064a19130130e30712de4b39039"//@"07d08fbfc1210e931771af3f43632bb9"//@
                            appSecret:@"b88ce182a1e7a4c9"//@"e32896161e72be91"//@
                          redirectUri:@"http://www.aimer.com.cn/app/index.shtml"];//@"http://www.aimer.com.cn/app/index.shtml"
    
    //OK添加人人网应用 注册网址  http://dev.renren.com
    [ShareSDK connectRenRenWithAppId:@"271087"
                              appKey:@"4f46064734d94084904aafb590fc29a8"
                           appSecret:@"b0aea644d8664792b7bb110a4358730c"
                   renrenClientClass:[RennClient class]];
    //end
    
    
    //lee999先不显示icon上数字
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;

    
    
    [self initJpushData];
    // Required
    [APService setupWithOption:launchOptions];
    
    return YES;
}




#pragma mark Jpush
    
-(void)initJpushData{

    // Required
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                       UIUserNotificationTypeSound |
                                                       UIUserNotificationTypeAlert)
                                           categories:nil];
    } else {
        //categories 必须为nil
        [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                       UIRemoteNotificationTypeSound |
                                                       UIRemoteNotificationTypeAlert)
                                           categories:nil];
    }
#else
    //categories 必须为nil
    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                   UIRemoteNotificationTypeSound |
                                                   UIRemoteNotificationTypeAlert)
                                       categories:nil];
#endif
}
    
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Required
    [APService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    // Required
    
    //lee999埋点
    [TalkingData trackEvent:@"3" label:@"收到push" parameters:userInfo];

    [APService handleRemoteNotification:userInfo];
}



-(void)createbaiduMap{
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"DTKinMxgjMn8VZfXdrlSOMPF"  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
}

-(void)loadMainView
{
    
    YKSplashView *gudeView = [[YKSplashView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth,ScreenHeight)];
    self.splashView = gudeView;
    [self.window addSubview:self.splashView];
    [self.window makeKeyAndVisible];
    
    
//    //先判断是否是第一次使用
//    if (![YKSplashView getIsOpenGuideView]) {
//        [self loadSplashView]; //加载引导图
//    }else{
//        [self createAKtableBar];
//    }
}

//加载引导图
-(void)loadSplashView
{
    NSLog(@"ScreenWidth:%f--ScreenHeight:%f",ScreenWidth,ScreenHeight);
    
    mainpageVC = [[MainpageViewController alloc] init];
    [self.window addSubview:mainpageVC.view];
    
    [self.window makeKeyAndVisible];
}

-(void)createAKtableBar{
    
    //创建首页
    //[self createShopMallView];
    //[self createHomepageView];
    [self createNewHomepageView];
    
    [self.window makeKeyAndVisible];
}

//创建新首页视图
-(void)createNewHomepageView{
    
    UIViewController *firstViewController = [[LNewHomePageViewController alloc] init];
    UIViewController *firstNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:firstViewController];
    
    UIViewController *secondViewController = [[NewSortViewController alloc] init];
    UIViewController *secondNavigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:secondViewController];
    
    UIViewController *thirdViewController = [[NewMaginzeListViewController alloc] init];
    UIViewController *thirdNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:thirdViewController];
    
    UIViewController *fourViewController = [[CarpageViewController alloc] init];
    UIViewController *fourNavigationController = [[UINavigationController alloc]
                                                  initWithRootViewController:fourViewController];
    
    UIViewController *fiveViewController = [[MyAimerloginViewController alloc] init];
    UIViewController *fiveNavigationController = [[UINavigationController alloc]
                                                  initWithRootViewController:fiveViewController];
    
    
    self.mytabBarController = [[RDVTabBarController alloc] init];
    [self.mytabBarController setViewControllers:@[firstNavigationController, secondNavigationController,
                                           thirdNavigationController,fourNavigationController,fiveNavigationController]];
    self.viewController = self.mytabBarController;
    
    [self customizeTabBarForController:self.mytabBarController];
 
    [self customizeInterface];

}

- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController {
    UIImage *finishedImage = [UIImage imageNamed:@"tabbar_selected_background"];
    UIImage *unfinishedImage = [UIImage imageNamed:@"tabbar_normal_background"];
    NSArray *tabBarItemImages = @[@"1", @"2", @"3",@"4",@"5"];
    
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"tb_%@_hover",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"tb_%@_normal",
                                                        [tabBarItemImages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        
        index++;
    }
}

- (void)customizeInterface {
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    
    UIImage *backgroundImage = nil;
    NSDictionary *textAttributes = nil;
    
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        backgroundImage = [UIImage imageNamed:@"navigationbar_background_tall"];
        
        textAttributes = @{
                           NSFontAttributeName: [UIFont boldSystemFontOfSize:18],
                           NSForegroundColorAttributeName: [UIColor blackColor],
                           };
    } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        backgroundImage = [UIImage imageNamed:@"navigationbar_background"];
        
        textAttributes = @{
                           UITextAttributeFont: [UIFont boldSystemFontOfSize:18],
                           UITextAttributeTextColor: [UIColor blackColor],
                           UITextAttributeTextShadowColor: [UIColor clearColor],
                           UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero],
                           };
#endif
    }
    
    [navigationBarAppearance setBackgroundImage:backgroundImage
                                  forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
    
    [self.window setRootViewController:self.viewController];
    
}


#pragma mark 回调函数
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    
    NSLog(@"---微信支付的返回：%@-----%@",[url absoluteString],url.host);

    
    //lee999
    if (mySingle.isShareSDK) {
        return [ShareSDK handleOpenURL:url
                            wxDelegate:self];
    }
    //end
    
    if ([[url absoluteString] hasPrefix:@"AmierProduct:"]) {
        [self parseURL:url application:application];
        return YES;
    }else if ([[url absoluteString] hasPrefix:@"tencent"]){
        if (YES == [TencentOAuth CanHandleOpenURL:url]){
            return [TencentOAuth HandleOpenURL:url];
        }
        return YES;
    }else {
        if ([WXApi handleOpenURL:url delegate:self]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"shareSuccess" object:nil];
        }
        return  [WXApi handleOpenURL:url delegate:self];
    }
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    
    NSLog(@"---微信支付的返回：%@-----%@",[url absoluteString],url.host);

    
    //lee999
    if (mySingle.isShareSDK) {
        return [ShareSDK handleOpenURL:url
                     sourceApplication:sourceApplication
                            annotation:annotation
                            wxDelegate:self];
    }
    //end
    
    
    //支付宝联合登陆的回调
    if ([url.host isEqualToString:@"platformapi"]){//支付宝钱包快登授权返回authCode
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"AlipayLogin" object:resultDic];
        }];
        return YES;
    }
    
    
    //lee999 151020 修改新版本支付宝 如果极简SDK不可用，会跳转支付宝钱包进行支付，需要将支付宝钱包的支付结果回传给SDK
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            [AlipayHelper dealPayResult:resultDic];
        }
         ];
        return YES;
    }
    if ([url.host isEqualToString:@"platformapi"]){//支付宝钱包快登授权返回authCode
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
        return YES;
    }
    //end
    
    
    //微信支付的回调
    NSString *jap = @"//pay";
    NSRange foundObj=[[url absoluteString] rangeOfString:jap options:NSCaseInsensitiveSearch];

    if ([[url absoluteString] hasPrefix:@"wx"]) {
        if(foundObj.length>0) {
            NSLog(@"Yes ! 微信支付 found");
            
            if ([[url absoluteString] hasSuffix:@"-2"]) {
                
                [MYCommentAlertView showMessage:@"用户中途取消" target:nil];
            }else if ([[url absoluteString] hasSuffix:@"0"])
            //支付成功
                [[NSNotificationCenter defaultCenter] postNotificationName:@"alipayOKanjumptoOrderDetail" object:nil];
            return YES;
            
        }else if([url.host isEqualToString:@"oauth"]){
        //lee999 20新增微信登录
            
//            [SingletonState sharedStateInstance].isWeChatLoginCallBackOK = NO;
            [WXApi handleOpenURL:url delegate:self];
            
            return YES;
            
        }else {
            NSLog(@"Oops ! no 微信支付 or 用户取消微信登录登录");
        }
    }
    
    if ([[url absoluteString] hasPrefix:@"AmierProduct:"]) {
        [self parseURL:url application:application];

        //lee999 改为新版本了  这里应该废弃了。  lee999 150120
//        //如果极简SDK不可用，会跳转支付宝钱包进行支付，需要将支付宝钱包的支付结果回传给SDK
//        if ([url.host isEqualToString:@"safepay"]) {
////            [[AlipaySDK defaultService] processPayResultFromAlipayclientWithOrder:url];
//        }
        return YES;
        
    }else if ([[url absoluteString] hasPrefix:@"tencent"])  {
        if (YES == [TencentOAuth CanHandleOpenURL:url])
        {
            return [TencentOAuth HandleOpenURL:url];
        }
    }else {
        //lee999 150503 注释掉这个地方，因为会引起崩溃
        
//        if ([WXApi handleOpenURL:url delegate:self]) {
//        }
//        return  [WXApi handleOpenURL:url delegate:self];
    }
    return NO;
}



#pragma maek-- 微信登录回调   wxDelegateMethods
#pragma -mark
-(void) onResp:(BaseResp*)resp
{
    //lee999 增加容错
    if (resp.errCode != 0) {
        return;
    }
    
    SendAuthResp *respTemp = (SendAuthResp *)resp;
    NSString *state = respTemp.state;
    if ([state isEqualToString:@"23987123"]){
        if (resp.errCode != 0) {
        }
    }
    
    if ([resp isKindOfClass:[SendAuthResp class]]) {
        if (resp.errCode == 0) {
            SendAuthResp *respTemp = (SendAuthResp *)resp;
            NSString *code = respTemp.code;
            NSString *state = respTemp.state;
            
            if ([state isEqualToString:@"23987123"]) {
                [self getWeChatLoginDatawithCode:code];
            }
        }
    }
}


-(void)getWeChatLoginDatawithCode:(NSString *)acode
{
    
    NSString *urlStr = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",kWeiXinKey,WXAppSecret,acode];
    
    NSStringEncoding chineseEnc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    dispatch_queue_t network_queue;
    network_queue = dispatch_queue_create("wechatlogin", nil);
    dispatch_async(network_queue, ^{
        
        NSString* str = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:urlStr] encoding:chineseEnc error:nil];
        
        NSDictionary *dict = [str JSONValue];
        
        if (dict && [dict respondsToSelector:@selector(objectForKey:)]) {
         
            [self getUserInfoWith:[dict objectForKey:@"access_token" isDictionary:nil]
                        andopenid:[dict objectForKey:@"openid" isDictionary:nil]];
        }
    });
}

-(void)getUserInfoWith:(NSString*)access_token andopenid:(NSString *)aopenid{
    
    NSString *urlStr = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",access_token,aopenid];
    
    dispatch_queue_t network_queue;
    network_queue = dispatch_queue_create("wechatlogin2", nil);
    dispatch_async(network_queue, ^{
        
        NSString* str = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:urlStr] encoding:NSUTF8StringEncoding error:nil];
        
        NSDictionary *dict = [str JSONValue];
        
        if (dict && [dict respondsToSelector:@selector(objectForKey:)]) {
            
            
            /*  微信登录成功返回数据
             {
             "openid":"oKV7zsu1-HQmjZVbe-c5tknzAxTI",
             "nickname":"小沫",
             "sex":0,
             "language":"zh_CN",
             "city":"",
             "province":"Beijing",
             "country":"CN",
             "headimgurl":"http://wx.qlogo.cn/mmopen/jh3m8hrZOnuUm14BurK2m22YmU117eRPZkAWBCfjlp0fz573peicPz7ibvicIdzhoRV362eT1A8icNib09JN0ibMsJ8Q/0",
             "privilege":[
             ],
             "unionid":"oiKLXt3GIuEeMOCSHuSw9-QTPTAM"
             }
             */
            
            
            NSString *str = [NSString stringWithFormat:@"%@,%@",
                             [dict objectForKey:@"openid" isDictionary:nil],
                             [dict objectForKey:@"nickname" isDictionary:nil]];
            
            [SingletonState sharedStateInstance].weChatLoginCallBackstring = str;
            [SingletonState sharedStateInstance].myHeadViewImageV = [dict objectForKey:@"headimgurl" isDictionary:nil];
            [SingletonState sharedStateInstance].isWeChatLoginCallBackOK = YES;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"weChatLoginOKCallBack" object:nil];

            
        }
    });
}



#pragma mark-- 极简支付 回调

- (void)parseURL:(NSURL *)url application:(UIApplication *)application {
	AlixPay *alixpay = [AlixPay shared];
	AlixPayResult *resultAlixPay = [alixpay handleOpenURL:url];
	if (resultAlixPay) {
		//是否支付成功
		if (9000 == resultAlixPay.statusCode) {
			/*
			 *用公钥验证签名
			 */
            //            如果AlixPayLogin 是 就是支付包快捷登录 不是就是支付的
            if ( [[NSUserDefaults standardUserDefaults] boolForKey:@"AlixPayLogin"])
            {
                NSRange range=  [resultAlixPay.userid rangeOfString:@"userid=\""];
                if((range.location>0)&&(range.length>0))
                {
                    //发送通知，是否支付宝登录成功
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"AlipayLogin" object:resultAlixPay.userid];
                }else{
                    
                    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                         message:resultAlixPay.userid
                                                                        delegate:nil
                                                               cancelButtonTitle:@"确定"
                                                               otherButtonTitles:nil];
                    [alertView show];
                }
            }else{
                
            }
        }
		//如果支付失败,可以通过result.statusCode查询错误码
		else {
			UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"爱慕提示"
																 message:resultAlixPay.statusMessage
																delegate:nil
													   cancelButtonTitle:@"确定"
													   otherButtonTitles:nil];
			[alertView show];
		}
	}
}


+ (BOOL) isFileExist:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:filePath];
    return result;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
    //lee999埋点
    [TalkingData trackEvent:@"2" label:@"退出程序到后台" parameters:nil];
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end







//创建首页视图
//-(void)createHomepageView{
//
//    aktabBarRightController = [[AKTabBarController alloc] initWithTabBarHeight:(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 70 : 50];
//    [aktabBarRightController setMinimumHeightToDisplayTitle:40.0];
//    aktabBarRightController.tag = 1;
//
//    [aktabBarRightController setTabColors:@[[UIColor colorWithRed:200.0/255.0 green:0 blue:48.0/255.0 alpha:1.0],
//                                            [UIColor colorWithRed:200.0/255.0 green:0 blue:48.0/255.0 alpha:1.0]]];
//    [aktabBarRightController setSelectedTabColors:@[[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0],
//                                                    [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0]]];
//
//    LNavigationRightViewController* navigationController = nil;
//    NSMutableArray *viewControllers = [[NSMutableArray alloc] initWithCapacity:6];
//
//    for (int i = 0; i < 6; ++i) {
//        LBaseRightViewController* rootVC = nil;
//        switch (i) {
//            case 0: {
//                rootVC = [[HomepageViewController alloc] init];
//            }
//                break;
//            case 1: {
//                rootVC = [[GotoMallViewController alloc] init];
//            }
//                break;
//            case 2: {
//                rootVC = [[BrandListViewController alloc] init];
//            }
//                break;
//			case 3: {
//                rootVC = [[AMMapViewController alloc] init];
//            }
//                break;
//            case 4: {
//                rootVC = [[MagazineViewController alloc] init];
//            }
//                break;
//            case 5: {
//                rootVC = [[GotoAimerViewController alloc] init];
//            }
//                break;
//            default:
//                break;
//        }
//        rootVC.wantsFullScreenLayout = YES;
//
//        navigationController = [[LNavigationRightViewController alloc] initWithRootViewController:rootVC];
//        [navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
//        navigationController.navigationBar.tintColor = [UIColor whiteColor];
//        [viewControllers addObject:navigationController];
//    }
//    [aktabBarRightController setViewControllers:viewControllers];
//    [self.window setRootViewController:aktabBarRightController];
//
//    mySingle.isSrceenRight = YES;
//    self.tablebarType = 1;
//
//}


//创建商城视图
//-(void)createShopMallView{
//
//        aktabBarVerticalController = [[AKTabBarController alloc] initWithTabBarHeight:(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 70 : 50];
//
//    [aktabBarVerticalController setMinimumHeightToDisplayTitle:40.0];
//    aktabBarVerticalController.tag = 2; //用于切换不同颜色
//    [aktabBarVerticalController setTabColors:@[[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0],
//                                       [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0]]];
//    [aktabBarVerticalController setSelectedTabColors:@[[UIColor colorWithRed:200.0/255.0 green:0 blue:48.0/255.0 alpha:0.0],
//                                               [UIColor colorWithRed:200.0/255.0 green:0 blue:48.0/255.0 alpha:.0]]];
//
//    UINavigationController* navigationController = nil;
//
//    NSMutableArray *viewControllers = [[NSMutableArray alloc] initWithCapacity:5];
//    for (int i = 0; i < 5; ++i) {
//        LBaseViewController* rootVC = nil;
//        switch (i) {
//            case 0: {
//                rootVC = [[AimerShopViewController alloc] init];
//            }
//                break;
//            case 1: {
//                rootVC = [[NewPageViewController alloc] init];
//            }
//                break;
//            case 2: {
//                rootVC = [[HotpageViewController alloc] init];
//            }
//                break;
//			case 3: {
//                rootVC = [[SearchpageViewController alloc] init];
//            }
//                break;
//            case 4: {
//                rootVC = [[CarpageViewController alloc] init];
//            }
//                break;
//            default:
//                break;
//        }
//        rootVC.wantsFullScreenLayout = YES;
//
//        navigationController = [[UINavigationController alloc] initWithRootViewController:rootVC];
//        [navigationController.navigationBar setBackgroundColor:[UIColor redColor]];
//        navigationController.navigationBar.tintColor = [UIColor redColor];
//        [viewControllers addObject:navigationController];
//    }
//    [aktabBarVerticalController setViewControllers:viewControllers];
//    [self.window setRootViewController:aktabBarVerticalController];
//
//    mySingle.isSrceenRight = NO;
//    self.tablebarType = 2;
//}

//创建我的爱慕界面
//-(void)createMyAimer{
//
//    self.mySingle.isSrceenRight = NO;
//   MyAimerViewController* myaimerVC = [[MyAimerViewController alloc] initWithNibName:@"MyAimerViewController" bundle:nil];
//    navMyaimerVC = [[UINavigationController alloc] initWithRootViewController:myaimerVC];
//}


//- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{
//    //判断屏幕是否横向
////    if (mySingle.isSrceenRight) {
////        [[UIApplication sharedApplication] setStatusBarHidden:YES];
////        return UIInterfaceOrientationMaskLandscapeRight;
////    }else{
//            [[UIApplication sharedApplication] setStatusBarHidden:NO];
//        //lee增加判断，如果小于IOS7才调整frame
//        if (isIOS7up) {
//        }else{
//            UINavigationController *nav = [aktabBarVerticalController.viewControllers objectAtIndex:0];
//            CGRect oldframe = nav.navigationBar.frame;
//            oldframe.size.height = 44;
//            [nav.navigationBar setFrame:oldframe];
//
//            CGRect oldframe2 = self.navMyaimerVC.navigationBar.frame;
//            oldframe2.size.height = 44;
//            [self.navMyaimerVC.navigationBar setFrame:oldframe2];
//        }//end
////        else if (isIOS6Down){
////            UINavigationController *nav = [aktabBarVerticalController.viewControllers objectAtIndex:0];
////            [nav.navigationBar setFrame:CGRectMake(0.0,0.0,320,44)];
////            [self.navMyaimerVC.navigationBar setFrame:CGRectMake(0.0,0.0,320,44)];
////        }else{
////            UINavigationController *nav = [aktabBarVerticalController.viewControllers objectAtIndex:0];
////            [nav.navigationBar setFrame:CGRectMake(0.0,0.0,320,44)];
////            [self.navMyaimerVC.navigationBar setFrame:CGRectMake(0.0,20.0,320,44)];
////        }
//        return UIInterfaceOrientationMaskPortrait;
//    }

//    return UIInterfaceOrientationMaskLandscapeRight;
//}

