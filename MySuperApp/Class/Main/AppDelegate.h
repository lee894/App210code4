//
//  AppDelegate.h
//  aimerOnline
//
//  Created by lee on 14-2-28.
//  Copyright (c) 2014年 aimer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

#import "YKSplashView.h"
#import "SinaClass.h"
#import "SingletonState.h"
#import "WeixinManager.h"
#import <ShareSDK/ShareSDK.h>
#import "RDVTabBarController.h"
#import <BaiduMapAPI/BMapKit.h>//引入所有的头文件
#import "WeiboSDK.h"

#define AimerChannelId @"1001"


@class BCTabBarController;
@class ViewController;
@class MainpageViewController;
@class SingletonState;
@class MyAimerViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate,UIScrollViewDelegate,WXApiDelegate,WeiboSDKDelegate,SinaWeiboRequestDelegate>
{
    BMKMapManager* _mapManager;
    
    MainpageViewController *mainpageVC;
}

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic, strong) SingletonState* mySingle;
@property(nonatomic, strong) YKSplashView    *splashView;

@property(nonatomic, strong) UINavigationController *navMyaimerVC;
@property (nonatomic, assign) int tablebarType;//  1是横屏  2是竖屏

@property (strong, nonatomic) UIViewController *viewController;
@property (strong, nonatomic)RDVTabBarController *mytabBarController;


-(void)createAKtableBar;

//-(void)createShopMallView;
//-(void)createMyAimer;

-(void)createbaiduMap;
-(void)loadMainView;


+ (BOOL) isFileExist:(NSString *)fileName;


@end


/*
//lee修改边框
textView.layer.borderColor = [UIColor grayColor].CGColor;
textView.layer.borderWidth =1.0;
textView.layer.cornerRadius =5.0;
需要添加头文件：
#import <QuartzCore/QuartzCore.h>
 
 
 //    NSString *path = [[NSBundle mainBundle] pathForResource:@"sourceid" ofType:@"dat"];
 //    NSString* fileContents = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
 //    fileContents = [self GetSourceID:fileContents]
 
 
 */

