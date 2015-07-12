//
//  LBaseViewController.h
//  teaShop
//
//  Created by lee on 14-3-11.
//  Copyright (c) 2014年 com.youzhong.iphone. All rights reserved.
//

#define isiPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)


#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "ActivityIndicatorView.h"
#import "MainpageServ.h"
#import "MYCommentAlertView.h"
#import "SBPublicAlert.h"
#import "AppDelegate.h"
#import "SingletonState.h"
#import "MYMacro.h"
#import "UrlImageView.h"
#import "UrlImageButton.h"
#import "UIScrollView+MJRefresh.h"
#import "LCommentAlertView.h"
#import "MyClosetParser.h"

//#import "AKTabBar.h"
#import "TalkingData.h"
#import "ShareUnit.h"
#import "ESToast.h"

#import "DplusMobClick.h"


@interface LBaseViewController : UIViewController<UIGestureRecognizerDelegate,UIAlertViewDelegate>//<AKTabBarDelegate>

@property(nonatomic,strong) UIButton *navbtnback;
@property(nonatomic,strong) UIButton *navbtnRight;

@property(nonatomic,assign) BOOL isBackBtnClick;//是否点击了返回按钮

//是否来自于右侧
@property(nonatomic,assign) BOOL isFromRight;


-(void)createBackBtnWithType:(int)type;

-(void)createRightBtn;
-(void)rightButAction;

//头和尾的显示和隐藏
-(void)showTitleAndFootwithAnimated:(BOOL)animated;
-(void)hiddenTitleAndFootwithAnimated:(BOOL)animated;

//仅仅隐藏尾部
-(void)ShowFooterwithAnimated:(BOOL)animated;
-(void)hiddenFooterwithAnimated:(BOOL)animated;


-(void)NewHiddenTableBarwithAnimated:(BOOL)animated;
-(void)NewSHowTableBarwithAnimated:(BOOL)animated;


//显示我的爱慕
-(void)changeToMyaimer;

//显示上一个的商场界面
//-(void)changeToLastShopView;
//显示商城
-(void)changeToShop;
//显示首页
//-(void)changeUIRight;
//我的爱慕返回 商城或者首页
-(void)myAimerBack;
//切换tablebar的位置
-(void)changetableBarto:(int)index;
//跳转到 商城的界面
//-(void)jumpLeftView:(id)object;

//-(float)lee1fitAllScreen:(float)inF;

//返回
-(void)clickBackButton:(UIButton*)sender;

-(NSMutableString*)ImageSize:(NSString*)url Size:(NSString*)size;

//banner图片点击跳转
+(LBaseViewController*)bannerJumpTo:(int)type withtypeArgu:(NSString*)argu withTitle:(NSString*)atitle andIsRight:(BOOL)right;


-(void)mycheckfinchback;

@end
