//
//  SingletonState.h
//  teaShop
//
//  Created by lee on 14-3-11.
//  Copyright (c) 2014年 com.youzhong.iphone. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "AKTabBarController.h"
#import "MYMacro.h"

#define REFRESH_HEADER_HEIGHT 30.0f


@interface SingletonState : NSObject
{
    BOOL userHasLogin;
    
}

@property(nonatomic, assign) BOOL userHasLogin;
//屏幕是否横向
//@property(nonatomic, assign) BOOL isSrceenRight;

@property(nonatomic, assign) BOOL isProductDetailGotoLogin;
//商品列表的类型
@property(nonatomic, assign) int productlistType;//0 其他    1首页 需要追加参数  2 品牌馆商品列表  3 MillHome   4，废弃   5,为我推荐的更多推荐

@property(nonatomic, assign) int myaimerIsFrom;//1 来源于横屏的首页    2，来源于竖屏的商城。

@property(nonatomic, assign) int mycarfrom;//1 购物车来源  商城   2，我的爱慕。


@property(nonatomic, assign) BOOL isShareSDK;//是否调用了SHareSDK


@property(nonatomic, assign) BOOL alipayisShowAlert;  // 0 不显示   1显示
@property (nonatomic, assign) BOOL isFromCheckOKView;//是否从支付完成界面进来的，如果是，就隐藏tablebar


@property (nonatomic, assign) BOOL isInCheckOKView;//是否在结算完成界面


@property (nonatomic, assign) BOOL isWeChatLoginCallBackOK;//是否微信登录唤起成功

@property (nonatomic, retain) NSString* weChatLoginCallBackstring;//微信登录唤起成功返回的openid和name

@property (nonatomic, retain) NSString* myHeadViewImageV;//我的登录头像


@property (nonatomic, assign) BOOL isNewHomePageScrollToTop;//是否滚动到最顶部



+ (SingletonState*)sharedStateInstance;


//lee给view设置为圆角，不再使用图片了。 -140512
+(id)setViewRadioSider:(UIView*)sender;

@end
