//
//  LBaseViewController.m
//  teaShop
//
//  Created by lee on 14-3-11.
//  Copyright (c) 2014年 com.youzhong.iphone. All rights reserved.
//

#import "LBaseViewController.h"
#import "UIColorAdditions.h"
#import "AppDelegate.h"
#import "MYCommentAlertView.h"
#import "YKCanReuse_webViewController.h"
#import "MYMacro.h"
#import "SingletonState.h"
#import "ProductlistViewController.h"
#import "ProductDetailViewController.h"
#import "YKChannelViewController.h"
#import "NoticeinfoViewController.h"
#import "GetCouponTableViewController.h"
#import "YKCanReuse_webViewController.h"
#import "MyAimerloginViewController.h"
#import "MyAimerViewController.h"
#import "PackageInfoViewController.h"


@interface LBaseViewController ()

@end

@implementation LBaseViewController
@synthesize isFromRight;
@synthesize isBackBtnClick;
@synthesize navbtnback;
@synthesize navbtnRight;


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
    
    
    
    //重要，防止IOS7下手势冲突。iOS7上leftBarButtonItem无法实现滑动返回的完美解决方案，lee注释掉，防止出现界面偏移。
//    if (isIOS7up) {
//        [self.navigationItem setHidesBackButton:YES];
//        self.navigationController.interactivePopGestureRecognizer.delegate = self;
//    }
    //添加细纹的背景图片
//    UIImageView *imgvbg = [[UIImageView alloc] initWithFrame:self.view.frame];
//    [imgvbg setImage:[UIImage imageNamed:@"page_bg_1136.png"]];
//    [self.view addSubview:imgvbg];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.navigationController.navigationBar.translucent = NO;

    
    [self.view setBackgroundColor:[UIColor colorWithHexString:tableViewBGC]];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];

    
//    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithHexString:@"#C60931"]];

    
    if (isIOS7up) {
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"#C60931"];
    }else{
      [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg22.png"] forBarMetrics:UIBarMetricsDefault];
    }
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0],
      UITextAttributeTextColor,
      [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8],
      UITextAttributeTextShadowColor,
      [NSValue valueWithUIOffset:UIOffsetMake(0, -1)],
      UITextAttributeTextShadowOffset,
      [UIFont fontWithName:@"Arial-Bold" size:26.0],
      UITextAttributeFont
      ,nil]];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
}

-(void)createBackBtnWithType:(int)type{
    
    if (isFromRight) {
        type = 888;
    }
    self.navbtnback = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
    [self.navbtnback setBackgroundImage:[UIImage imageNamed:@"t_ico_back_normal.png"] forState:UIControlStateNormal];
    [self.navbtnback setBackgroundImage:[UIImage imageNamed:@"t_ico_back_hover.png"] forState:UIControlStateHighlighted];
    if (type == 999) {
        
    }else if(type == 998){
    //我的爱慕 返回   返回到横屏或者竖屏
        [self.navbtnback addTarget:self action:@selector(gotoHomePageAciton) forControlEvents:UIControlEventTouchUpInside];
    }else if(type == 997){
        //我的爱慕   返回到根目录
        [self.navbtnback addTarget:self action:@selector(backToRoot) forControlEvents:UIControlEventTouchUpInside];
    }else if(type == 888){
        //返回横屏状态 （详情在返回横屏）

    }else if(type == 996){
        //新品，热卖，  返回到商城界面！！！

    }else if(type == 789){
        //购物车的返回按钮

    }else if(type == 799){
        //结算完成之后，返回
        [self.navbtnback addTarget:self action:@selector(mycheckfinchback) forControlEvents:UIControlEventTouchUpInside];
    }else{
        //普通返回  返回到上一级界面
        [self.navbtnback addTarget:self action:@selector(clickBackButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithCustomView:self.navbtnback];
    self.navigationItem.leftBarButtonItem = backBtn;
    self.navigationItem.hidesBackButton = YES;
}

-(void)createRightBtn{

    self.navbtnRight = [UIButton buttonWithType:UIButtonTypeCustom];
	[self.navbtnRight setTitle:@"保存" forState:UIControlStateNormal];
	self.navbtnRight.titleLabel.font = [UIFont systemFontOfSize:LabSmallSize];
	[self.navbtnRight setFrame:CGRectMake(254, 7, 66, 32)];
	//[self.navbtnRight setBackgroundImage:[UIImage imageNamed:@"nav_btn.png"] forState:UIControlStateNormal];
    //[self.navbtnRight setBackgroundImage:[UIImage imageNamed:@"nav_btn_press.png"] forState:UIControlStateHighlighted];
	[self.navbtnRight addTarget:self action:@selector(rightButAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithCustomView:navbtnRight];
    self.navigationItem.rightBarButtonItem = backBtn;
}

-(void)rightButAction{

}


#pragma mark--- 返回购物车首页
-(void)gotoHomePageAciton{
    
    if([self respondsToSelector:@selector(dismissModalViewControllerAnimated:)]){
        [self dismissViewControllerAnimated:YES completion:^{}];
    }
    AppDelegate* app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    if ([app.mytabBarController selectedIndex]==4) {
        [self changetableBarto:0];
    }
    [self ShowFooterwithAnimated:NO];
}

#pragma mark---订单返回商城首页
-(void)mycheckfinchback{
    
    isBackBtnClick = YES;

    [self.navigationController popToRootViewControllerAnimated:NO];
    [self ShowFooterwithAnimated:YES];
    
    
    [self changetableBarto:0];
    
    //lee999recode
    //end
}

//返回根目录
-(void)backToRoot{
    isBackBtnClick = YES;
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark----   显示我的爱慕
-(void)changeToMyaimer{
    
    MyAimerViewController *loginvc = [[MyAimerViewController alloc] initWithNibName:@"MyAimerViewController" bundle:nil];
    UINavigationController *navCtl = [[UINavigationController alloc] initWithRootViewController:loginvc];
    [self presentViewController:navCtl animated:YES completion:^{}];
}



//显示商城
-(void)changeToShop{
    AppDelegate* app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [app.mytabBarController setSelectedIndex:0];
}


//我的爱慕返回 商城 或者首页
-(void)myAimerBack{
    
    isBackBtnClick = YES;
    [self changeToShop];
}

-(void)clickBackButton:(UIButton*)sender{
    isBackBtnClick = YES;

    [self.navigationController popViewControllerAnimated:YES];
}

//切换tablebar的位置
-(void)changetableBarto:(int)index{
    AppDelegate* app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    [app.mytabBarController setSelectedIndex:index];
}

-(void)showTitleAndFootwithAnimated:(BOOL)animated{
//    AppDelegate* app = (AppDelegate*)[UIApplication sharedApplication].delegate;
//    [self.navigationController setNavigationBarHidden:NO animated:animated];
//    [app.mytabBarController setTabBarHidden:NO animated:YES];
}

-(void)hiddenTitleAndFootwithAnimated:(BOOL)animated{
//    AppDelegate* app = (AppDelegate*)[UIApplication sharedApplication].delegate;
//    [self.navigationController setNavigationBarHidden:YES animated:animated];
//    [app.aktabBarVerticalController hideTabBar:AKShowHideFromLeft animated:animated];
}

-(void)ShowFooterwithAnimated:(BOOL)animated{
//    AppDelegate* app = (AppDelegate*)[UIApplication sharedApplication].delegate;
//    [app.mytabBarController setTabBarHidden:NO animated:animated];
}

-(void)hiddenFooterwithAnimated:(BOOL)animated{
//    AppDelegate* app = (AppDelegate*)[UIApplication sharedApplication].delegate;
//    [app.mytabBarController setTabBarHidden:YES animated:animated];
}


//显示按钮
-(void)NewHiddenTableBarwithAnimated:(BOOL)animated{
    AppDelegate* app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [app.mytabBarController setTabBarHidden:YES animated:animated];
}

//隐藏按钮
-(void)NewSHowTableBarwithAnimated:(BOOL)animated{
    
    AppDelegate* app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [app.mytabBarController setTabBarHidden:NO animated:animated];
}





#pragma mark - View lifecycle
-(NSMutableString*)ImageSize:(NSString*)url Size:(NSString*)size{
    NSString *filename = [[NSString alloc] init];
    NSArray *filenames=[[NSArray alloc]init];
    NSArray *SeparatedArray = [[NSArray alloc]init];
    
    SeparatedArray =[url componentsSeparatedByString:@"/"];
    
    filename = [SeparatedArray lastObject];
    filenames=[filename componentsSeparatedByString:@"?"];
    NSString *selectedName =[NSString stringWithFormat:@"%@_%@.%@",
                             [[filenames objectAtIndex:0] stringByDeletingPathExtension],
                             size,
                             [[filenames objectAtIndex:0] pathExtension]];
    NSMutableString *string=[[NSMutableString alloc]init];
    for (int i=0; i<[SeparatedArray count]-1; i++) {
        [string appendFormat:@"%@",[SeparatedArray objectAtIndex:i]];
        [string appendFormat:@"/"];
    }
    [string appendFormat:@"%@",selectedName];
    return string;
}

//banner图片点击跳转
+(LBaseViewController*)bannerJumpTo:(int)type withtypeArgu:(NSString*)argu withTitle:(NSString*)atitle andIsRight:(BOOL)right{
    
    NSLog(@"banner跳转类型是：-----%d",type);
    switch (type) {
        case 1:{
            //商品列表
            
            NSString *str = argu;  //"type_argu":"order:desc|category:1335" 这是接口返回的数据 下级界面要用
            ProductlistViewController *jumpVC = [[ProductlistViewController alloc] init];
            [SingletonState sharedStateInstance].productlistType = 1;
            
            //判断字符串是否含有| 没有的话就直接跳出了
            NSRange range = [str rangeOfString:@"|"];
            if (range.location!=NSNotFound) {
                NSLog(@"Yes");
                NSArray *arr = [str componentsSeparatedByString:@"|"]; //order:desc|category:1335
                jumpVC.params = [[[arr objectAtIndex:1]componentsSeparatedByString:@":"] objectAtIndex:1];
                NSArray *array=[[arr objectAtIndex:0] componentsSeparatedByString:@":"]; //order:desc|category:1335
                jumpVC.orderStr = [array objectAtIndex:1];
            }else {
                NSLog(@"NO");
                jumpVC.orderStr = @"desc";
                jumpVC.params = str;
            }
            jumpVC.isShop = YES;
            jumpVC.titleName = atitle;
            jumpVC.isFromRight = right;
            
            jumpVC.isHiddenFilerbtn = YES;  //隐藏筛选按钮。  轮播不需要增加筛选按钮
            
            return jumpVC;
            }
            break;
        case 2:
        {
            //商品详情
            NSString *str = argu;
            NSRange range = [str rangeOfString:@":"];
            if (range.location!=NSNotFound) {
                
                NSArray *array=[str componentsSeparatedByString:@":"];
                ProductDetailViewController *jumpVC=[[ProductDetailViewController alloc]init];
                jumpVC.isPush = YES;
                jumpVC.thisProductId=[array objectAtIndex:1];
                jumpVC.ThisPorductName=atitle;
                jumpVC.source_id=@"1002";
                jumpVC.isFromRight = right;

                return jumpVC;
            }
        }
            break;
        case 3:
        {
            //频道专题
            NSRange range = [argu rangeOfString:@":"];
            if (range.location!=NSNotFound) {
                
                NSArray *array=[argu componentsSeparatedByString:@":"];
                YKChannelViewController *jumpVC=[[YKChannelViewController alloc]init];
                jumpVC.title_Name=atitle;
                jumpVC.ThisChannelID=[array objectAtIndex:1];
                jumpVC.isFromRight = right;

                return jumpVC;
            }
        }
            break;
        case 4:
        {
            //活动公告
            NoticeinfoViewController *jumpVC = [[NoticeinfoViewController alloc] init];
            jumpVC.isFromRight = right;

            return jumpVC;
        }
            break;
        case 5:
        {
            //领取优惠券
            NSString *str = argu;//[bannerModel typeArgu];
            NSString *couStr = [str stringByReplacingOccurrencesOfString:@"couponid:" withString:@""];

            GetCouponTableViewController *jumpVC = [[GetCouponTableViewController alloc] init];
            jumpVC.couponed = couStr;
            jumpVC.isFromRight = right;
            return jumpVC;
        }
            break;
        case 6:
        {
            //对应套装列表
            NSArray *array=[argu componentsSeparatedByString:@":"];

            ProductlistViewController *jumpVC=[[ProductlistViewController alloc]init];
            [SingletonState sharedStateInstance].productlistType = 1;
            //            [[NSUserDefaults standardUserDefaults]setObject:@"home" forKey:@"From"];
            jumpVC.isSuitlist = YES;
            jumpVC.isSearch = YES;
            jumpVC.suitname = [array objectAtIndex:1];
            jumpVC.titleName = atitle;
            jumpVC.isFromRight = right;

            return jumpVC;
        }
            break;
            
        case 9:
        {
            //新增webView
            NSRange range = [argu rangeOfString:@":"];
            if (range.location!=NSNotFound) {
                NSString *strurl = [argu substringFromIndex:8];
                YKCanReuse_webViewController *jumpVC=[[YKCanReuse_webViewController alloc]init];
                jumpVC.strTitle = atitle;
                jumpVC.strURL =strurl;
                jumpVC.isFromRight = right;
                
                return jumpVC;
            }
        }
            break;
        case 10:
        {
            NSArray* param = [argu componentsSeparatedByString:@":"];
            if (param.count > 1) {
                NSString* strPackageId = [param objectAtIndex:1 isArray:nil];
                PackageInfoViewController* pivc = [[PackageInfoViewController alloc] init];
                pivc.pid = strPackageId;
                return pivc;
            }
        }
            break;
        default:
            break;
    }
    return nil;
}

//-(float)lee1fitAllScreen:(float)inF{
//
//    float f;
//    f = (inF/320)*ScreenWidth;
//    
//    return f;
//
//}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
