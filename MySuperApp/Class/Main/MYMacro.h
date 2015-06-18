//
//  MYMacro.h
//  YKNewPragram
//
//  Created by li yang on 12-9-26.
//  Copyright (c) 2012年 li yang. All rights reserved.
//

#import "UIColorAdditions.h"

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

#define YintaiHotLine @"400-119-1111"


//#define ChangeImageURL  @"186x226"
#define ChangeImageURL  @"242x294"


#define AlertShowTime 1.5


#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height


#define new20ViewY 0  //原来高度是60  现在改为0

#define NowViewsHight self.view.frame.size.height

#define MyAppDelegate (AppDelegate *)[[UIApplication sharedApplication] delegate]


//当前视图界面的宽与高
#define selfViewWidth self.view.bounds.size.width
#define selfViewHeight self.view.bounds.size.height
//满屏界面的宽度
#define viewHeight 275.0
#define foottableHeight 50.0

//分类右移的宽度
#define SortMoveWith  270.


#define tableViewBGC @"#E6E6E6"

//判断是否系统版本ios7以上
#define isIOS7up [[[UIDevice currentDevice] systemVersion]floatValue]>=7
//判断是否为IOS6 以下
#define isIOS6Down [[[UIDevice currentDevice] systemVersion]floatValue]<6
//判断是不是ios8
#define isIOS8up [[[UIDevice currentDevice] systemVersion]floatValue]>=8



//判断是否是高清屏
#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
//判断是不是4寸屏幕
#define IS4InchScreen ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)


#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)


#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#define RGBACOLOR(_r, _g, _b, _a) [UIColor colorWithRed:(_r)/255.0 green:(_g)/255.0 blue:(_b)/255.0 alpha:(_a)]


//适配iphone6  iphone6P
#define lee1sx(x) IS4InchScreen?x:isiPhone5?x:x*ScreenWidth/320.0
#define lee1sy(y) IS4InchScreen?y*ScreenHeight/568.0:isiPhone5?y:y*ScreenHeight/568.0
#define lee1sw(w) IS4InchScreen?w:isiPhone5?w:w*ScreenWidth/320.0
#define lee1sh(h) IS4InchScreen?h*ScreenHeight/568.0:isiPhone5?h:h*ScreenHeight/568.0
#define lee1PPRect(x,y,w,h) CGRectMake(lee1sx(x),lee1sy(y),lee1sw(w),lee1sh(h))

#define lee1fitAllScreen(f) (f/320.0)*ScreenWidth



//字体大小设置:
#define LabBigSize  19.0   // title
#define LabMidSize  16.0
#define LabSmallSize 14.0
#define LablitileSmallSize 12.0

//====================================================
// 用途: 第三方联合登录和分享
//====================================================
//新浪微博
#define kAppKey             @"1884005190"
#define kAppSecret          @"bd1d29e7cfcf7091f20da15cfa6be814"
#define kAppRedirectURI     @"http://www.aimer.com.cn/app/index.shtml"

//#define kAppKey             @"3248031055"
//#define kAppSecret          @"05f8ea51ffc2a3f4b58baeb394a4e596"
//#define kAppRedirectURI     @"http://"


//网易
#define KEY_NETEASE @"eQtzoCEeDWPNt0Td"
#define SECRETKEY_NETEASE  @"lvw24SvJKct1oE4MB1OC03oWTcc0f2lb"


//----------------------
//微信
/**
 *  微信开放平台申请得到的 appid, 需要同时添加在 URL schema
 */
#define kWeiXinKey  @"wx01b5e6ed228e37c8"//@"wx568c5f7a89341ad0"

/**
 * 微信开放平台和商户约定的支付密钥
 * 注意：不能hardcode在客户端，建议genSign这个过程由服务器端完成
 */
#define WXAppKey @"Ua4Le0LfyLdOnl5VZ45RtuvwZaJgvq8DufgwuoCaxGq48ecZJhFnXvPw9wIvcm43I2j0eTyRn58Sq0pmH3X0kHeuuEmSHfmwOIR8XrCbQfIiuySCIeNmSwrvzcg1YhVn"
//@"MZkqpLndwmNGLElmwdYEbBJJV3UuzV8QDqW2EPM6VfadFGy8IK11zqVXETebMwM1TT6640uuf1XBb0duPG1E8P1Koj2476w6hbl1Fwh6P8UZklafWBsiOOW1jYNObbse"

// *  微信公众平台商户模块生成的ID
#define WXPartnerId  @"1231685801"//@"1218867301"
/**
 * 微信开放平台和商户约定的支付密钥
 * 注意：不能hardcode在客户端，建议genSign这个过程由服务器端完成
 */
// @"47016831a1d772cfdb644f32f08cc3f2"
#define WXPartnerKey @"363225b21a24a01ac48401766bd6dd3c" //?? 为什么不是这个？//@"e408674be4b1ae7b83e5f87f3d81b8a0"
/**
 * 微信开放平台和商户约定的密钥
 * 注意：不能hardcode在客户端，建议genSign这个过程由服务器端完成
 */
#define WXAppSecret @"47016831a1d772cfdb644f32f08cc3f2"///@"b0a785b4d9bf19e199694994e59f4efe"


//#warning --------TEST
//微信回调，测试地址
//#define WX_notifyURL @"http://mtest.aimer.com.cn:8888/wxpay/app_confim_wxpay"

//微信回调正式地址
#define WX_notifyURL @"http://m.aimer.com.cn/wxpay/app_confim_wxpay"

//--------------------------end


//QQ
#define kQQAppID @"100504640"


//支付宝正式回调地址
#define Alipay_notifyURL @"www.aimer.com.cn/apppay/app_confim_alipay" //"mobiletest.aimer.com.cn:8888/apppay/app_confim_alipay"//@//@"http://www.aimer.com.cn/mobile/confim_alipay"//@//@//@"http://www.aimer.com.cn/apppay/notify"  "http://124.207.152.104/apppay/confim_alipay"


//支付宝回调测试地址
//#define Alipay_notifyURL @"124.207.152.104/apppay/app_confim_alipay"


//public  static final String NOTIFY_URL = "www.aimer.com.cn/apppay/confim_alipay";
//public  static final String NOTIFY_URL = "124.207.152.104/apppay/confim_alipay";

//====================================================
// 用途: 公共头参数  数据
//====================================================
#define YKOsName  @"iphone"
#define YKAppKey  @"3452AB32D98C987E798E010D798E010D"
#define YKAuthtype @"md5"
#define YKVer      @"1.2"//通讯协议版本号


//====================================================
// 用途: 相关接口  API的host路径
//====================================================

//API的host路径
//#define OFFICIALDOMAIN @"http://mobiletest.aimer.com.cn:8888/mobile/"
#define OFFICIALDOMAIN @"http://www.aimer.com.cn/mobile/"
//#define OFFICIALDOMAIN @"http://124.207.152.104/mobile/"
//#define OFFICIALDOMAIN @"http://www.aimer.com.cn/mobiletest/"
//#define OFFICIALDOMAIN @"http://124.207.72.140:8888/mobiletest/"

//====================================================
// 用途: viewController里主视图的frame
//====================================================
#define XPoint_FULL_SCREEN  5.5f
#define WIDTH_FULL_SCREEN  320.f
#define HEIGHT_FULL_SCREEN 400.f
//#define FRAME_FULL_SCREEN  CGRectMake(0.f, 0.f, WIDTH_FULL_SCREEN, HEIGHT_FULL_SCREEN)


//屏幕宽和高
#define SCREEN_WIDTH 320

#define isiPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)


#define TableViewHigh  isiPhone5? 370+88 :370

//#define SCREEN_HEIGHT ((isiPhone5) ? 1136/2 : 480)
//#define SCREEN_HEIGHT (([UIApplication sharedApplication].statusBarHidden)?480:460)
#define SCREEN_HEIGHT (([UIApplication sharedApplication].statusBarHidden)?480:460)
#define SCREEN_HEIGHT_5 (([UIApplication sharedApplication].statusBarHidden)?568:548)

//当前设备是否支持高清
#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)


//app底部tab bar的高度
#define ToolBar_Height 45

//导航栏高度
#define Navigation_Bar_Height 44

//视图的区域总高度
#define VIEW_HEIGHT (isiPhone5?SCREEN_HEIGHT_5-ToolBar_Height-Navigation_Bar_Height:SCREEN_HEIGHT-ToolBar_Height-Navigation_Bar_Height)


//是否高清，放大系数
#define RetinaFactor (isRetina?2:1)

//通信协议相关宏
//推广ID
#define SOURCEID_STORE(fileName) ([Common getFileContent:fileName])
//通讯协议版本_yek
#define APP_VERSION (@"1.5.0")

//说明，引导图的张数
#define SplashViewCount 4

#define Remenber_notification_State  (@"RemenbernotificationState")
#define LimitbuyTime  (@"LimitbuyTime")


//button按钮相关
#pragma mark - button按钮相关
#define BtnSetImg(button,normal,highlight,click)\
{\
[button setBackgroundImage:[UIImage imageNamed:normal] forState:UIControlStateNormal];\
[button setBackgroundImage:[UIImage imageNamed:highlight] forState:UIControlStateHighlighted];\
[button setBackgroundImage:[UIImage imageNamed:click] forState:UIControlStateSelected];\
}


#define IMAGE(imageName ,ImageType) boundPaths(imageName ,ImageType)


//====================================================
// 用途: 发送服务器请求用的拼接字符串
// 格式: 发送请求的页面_2_跳转后页面_SENDDATA
//====================================================
//#define BRANDS_2_PRODUCTLIST_SENDDATA @"brand:0:" // 这个不要了，废弃
#define CHANNEL_PRODUCTLIST_SENDDATA  @"category:0:"




#define HttpRequestMethod @"requestCommand"

//====================================================
// 用途: 请求tag宏定义
// 格式: http_XX_Tag
//====================================================

#define Http_Main_Tag 99 //app首页

#define Http_Scan_Tag 100 //扫描

#define Http_Login_Tag 101 //登录

#define Http_Home_Tag 102 //首页

#define Http_Search_Tag 103 //搜索

#define Http_Brands_Tag 104 //品牌列表

#define Http_Categories_Tag 105 //分类列表

#define Http_Productlist_Tag 106 //商品列表(附:筛选)

#define Http_Product_Tag 107 // 商品详情

#define Http_Channelcate_Tag 108 //频道专区主页

#define Http_Channelllist_Tag 109 //频道专区主页

#define Http_Car_Tag 110 //购物车

#define Http_Checkout_Tag 111 //结算中心

#define Http_Check_couponcard_Tag 112 // 验证优惠卷是否有效

#define Http_Submitorder_Tag 113 // 提交订单

#define Http_Addresslist_Tag 114 //  地址列表

#define Http_Favorite_Tag 115 // 收藏夹列表

#define Http_Orders_Tag 116 //订单列表

#define Http_Orderdetail_Tag 117 //订单详情

#define Http_More_Tag 118 //获取我的爱慕页面更多推荐的信息

#define Http_Active_Tag 119 //激活(第一次运行)

#define Http_Version_Tag 120 //版本检查

#define Http_Register_Tag 121 //注册

#define Http_Productionfo_Tag 122 // 更新商品信息

#define Http_Logout_Tag 123 //注销

#define Http_Car_add_Tag 124 //添加到购物车

#define Http_Addsuittocar_Tag 125 //  添加套装到购物车

#define Http_EditCar_Tag 126 //修改购物车

#define Http_Editsuittocar_Tag 127 //修改购物车中的套装

#define Http_Suittocart_deletes_Tag 128 // 删除购物车中的套装

#define Http_Delcar_Tag 129 //从购物车删除

#define Http_Addressadd_Tag 130 //添加地址

#define Http_AddressEdit_Tag 131 //修改地址

#define Http_AddressDel_Tag 132 //删除地址

#define Http_FavoriteAdd_Tag 133 //添加到收藏夹

#define Http_FavoriteDel_Tag 134 //从收藏夹删除

#define Http_CancelOrder_Tag 135 //取消订单

#define Http_NoticeList_Tag 136 //消息列表

#define Http_SuitList_Tag 137 //  套装列表

#define Http_SuitInfo_Tag 138 //  套装详情

#define Http_FeedBack_Tag 139 //  意见反馈

#define Http_Store_Tag 140 //   门店查询

#define Http_Magazine_Tag 141 //  杂志

#define Http_Getscoupon_Tag 142 //  领卷页面

#define Http_Getscouponup_Tag 143 //    领取优惠券

#define Http_Showcomment_Tag 144 //    单品评价详

#define Http_Bindmobile_Tag 145 //      绑定手机

#define Http_Sendcodes_Tag 146 //      发送验证码

#define Http_Brandtrend_Tag 147 // 潮流新品

#define Http_Brandzixun_Tag 148  //品牌资讯

#define Http_Notices_Tag   149  // 消息详情/公告详情

#define Http_Resetpass_Tag 150  //重置密码接口

//Add 8.20

#define Http_Resetpassup_Tag 151 ////修改密码 操作  接口

#define Http_Sinaweibo_Tag  152 //新浪微博登录

#define Http_Sinacallback_Tag 153 //新浪微博验证接口

#define Http_Wangyiweibo_Tag  154 //网易微博登录

#define Http_Wangyicallback_Tag 155 //网易微博验证接口

#define Http_Logistics_Tag  156 //查找物流

#define Http_Findpasswordup_Tag 157 // 找回密码(验证邮箱或者手机号发送验证码)

#define Http_CheckCommet_Tag 158 //(我要评价

#define Http_Qqcallback_Tag 159 //qq验证接口
//8.22

//8.26

#define Http_CoupncardList_Tag 160 //优惠卡列表接口

//9.3

#define Http_provemobile_Tag 161 //门店会员激活
#define Http_setv6user_Tag  162 // 注册+验证
#define Http_addcomment_Tag 163 //添加评价

//9.9
#define Http_CheckOfflineMobile_Tag 164 //验证用户是否是线下会员
#define Http_v6userlogin_Tag  165  //已注册过的会员激活验证


#define Http_TrdnoByOrderld_Tag 166 //银联支付接口 返回交易码


#define Http_UpdatePwd_Tag      167  // 修改密码

#define Http_INFO_Tag  168  //我的爱慕显示会员信息
#define Http_EditInfo_Tag 169 ////提交修改

#define Http_Dealapply_Tag 170 //处理申请会员信息

#define Http_Selectgifts_Tag 171 //赠品列表（有活动 1 2 3 4）

#define Http_Uploadface_Tag 172 //修改个人头像
#define Http_Alipaylogin_Tag 173 //支付宝快捷登录

#define Http_Linkageconfirmpay_Tag  174 //联动支付完成后  修改订单状态
#define Http_Confim_alipay_Tag     175   //支付宝完成后  修改订单状态
#define Http_Branddetail_Tag      176 //品牌馆详情

#define Http_exchangecoupon_Tag  177 //积分兑换接口
#define Http_usev6card_Tag  178 //使用尊享卡接口
#define Http_addCouponcard_Tag  179 //绑定优惠券接口
#define Http_getexchangescorerecord_Tag  180 //积分兑换记录

#define Http_Clientinformation_Tag  181  // 客户端信息
#define Http_Makesuregetgood_Tag    182  //确认收货


#define Http_whchatLogin_Tag  183 //微信登录

#define Http_GetRegisterVerifycode_Tag  184 //注册获取验证码


//lee999 200版本开发
#define Http_Homepage20_Tag      201 //新版本 首页！！！
#define Http_MageinzeList20_Tag      202 //新杂志！！！
#define Http_MageinzeDetail20_Tag      203 //新杂志详情！！！
#define Http_StoreList20_Tag      204 //门店查询！！！
#define Http_StoreDetail20_Tag      205 //门店查询 详情！！！
#define Http_Favorite20_Tag      206 //收藏夹列表！！！
#define Http_MoreMyAimer20_Tag      207 //获取我的爱慕页面更多推荐的信息

#define Http_Sort20_Tag      208 //新版本 分类
#define Http_Branddetail20_Tag      209 //品牌馆详情
#define Http_FavoriteList20_Tag 210 //新版本 收藏夹列表
#define Http_PackageInfo20_Tag 211 //新版本 礼包详情
#define Http_CouponList20_Tag 212 //新版本 优惠券列表
#define Http_AddPackageToCart20_Tag 213 //新版本 礼包加入购物车
#define Http_wardrobe_Tag 301 //私人衣橱 1
#define Http_changefrequency20_Tag 302 //设置定期更换内衣提醒
#define Http_bespeak20_Tag 303 //预约测体门店
#define Http_bespeakup20_Tag 304 //测体门店

#define Http_wardrobeinfo20_Tag 305 //我的衣橱列表






//====================================================
// 用途: API拼接
// 格式: 数据名称_API
//====================================================
//#define HOME_PAGE_API      (@"/Home/")//主页
#define Main_API           (@"main") //app首页
#define HOME_PAGE_API      (@"home")
#define SCAN_API           (@"scan") //扫描
#define BRANDS_WALL_API    (@"brandslist")//品牌馆
#define Brandtrend_API     (@"brandtrend")// 潮流新品
#define Brandzixun_API     (@"brandzixun") // 品牌资讯
#define BRANDS_LIST_API    (@"/Brands/index/order/initial")//返回: 使用initial排序的有序数据
#define SORT_API           (@"categories")//分类
#define PRODUCT_LIST_API   (@"productlist")//产品列表
#define PRODUCT_DETIAL_API (@"product")//产品详情
#define CHANNEL_LIST_API   (@"channelcate")//频道专区主页

#define ADD_SUIT_TO_CART   (@"addsuittocar")//添加套装到购物车

#define SEATCH_API         (@"search")//查询
#define REGISTER_API       (@"register")//注册
#define LOGIN_API          (@"login")//登录
#define LOGINOUT_API       (@"logout")//登出

#define CAR_DEL_SUIT       (@"suittocart_deletes")//删除购物车套装
#define CAR_ADD_API        (@"car_add")//加入购物车
#define CAR_DEL_API		   (@"delcar")//删除购物车
#define CAR_EDIT_API       (@"car_edit")//编辑购物车
#define CAR_API            (@"car")//购物车列表
#define CHECKOUT_API       (@"checkout")//结算中心
#define CHECK_COUPONCARD   (@"check_couponcard")//验证优惠劵是否有效


#define ORDER_SUBMIT_API   (@"submitorder")//订单提交
#define ORDERS_API         (@"orders")//订单/Orders/index/
#define ORDER_DETAIL_API   (@"orderdetail")//订单详情
#define ORDER_CANCEL_API   (@"cancelorder")//订单取消
#define ORDER_DEL_API      (@"/Cancelorder/index/")//取消订单

#define FAVORITE_API       (@"favorite")//收藏
#define FAVORITE_ADD_API   (@"favoriteadd")//添加收藏
#define FAVORITE_DEL_API   (@"favoritedel")//删除收藏

#define ADDRESS_ADD_API    (@"addressadd")//添加地址
#define ADDRESS_DEL_API    (@"addressdel")//删除地址
#define ADDRESS_EDIT_API   (@"addressedit")//编辑地址
#define ADDRESS_LIST_API   (@"addresslist")//地址列表

#define SKILL_API          (@"/Skill/index/")//秒杀
#define SKILL_DETIAL_API   (@"/Skilldetail/index/")//秒杀详情

#define FEEDBACK_API       (@"/Feedback/index/")//反馈信息

#define QUESTION_ADD_API   (@"/Addquestion/index/")//添加提问
#define QUESTION_LIST_API  (@"/Questionlist/index/")//问题列表

#define LOGISTICS_API      (@"logistics")//物流查询

#define COMMENT_ADD_API    (@"/Addcomment/index/")//增加评价
#define COMMENT_LIST_API   (@"/Commentlist/index/")//评价列表

#define VERSION_API        (@"version")//版本信息
#define ACTIVE_API         (@"active")//激活
#define EXCHANGECOUPON  (@"exchangecoupon") //积分兑换
#define COUPONCARD_ADD     (@"addCouponcard")//优惠卡增加接口
#define COUPONCARD_LIST    (@"couponcardlist")//优惠卡增加接口
#define USEV6CARD_API          (@"usev6card")//使用尊享卡
#define ADDCOUPONCARD       (@"add_couponcard") //绑定优惠券接口
#define USERINFO_API       (@"/Userinfo/index/")

//lee999
#define Makesuregetgood_API       (@"receivegoods")
#define UpmpTradno_API       (@"upmpTradno")


#define WechatLoginCALLBACK_API   (@"weixincallback")  // 微信登录验证接口



//zanju
#define MORE               (@"more")  //获取我的爱慕页面更多推荐的信息
#define PRODUCT_INFO_API   (@"productinfo") //更新商品信息
#define SUITTOCAR          (@"suittocar_edit") //修改购物车中的套装
#define NOTICELIES_API     (@"noticelist")   //消息列表
#define NOTICES_API        (@"notices")  //消息详情/公告详情
#define SUITLIST_API       (@"suitlist")  //套装列表
#define PRODUCTSUITINFO    (@"suitinfo") //套装详情
#define STORE_API          (@"stores") //门店查询
#define FeedBack_API       (@"feedback") //意见反馈
#define MAGAZINE_API       (@"magazine") //杂志
#define GETSCOUPON_API     (@"getscoupon") //领取页面
#define GETSCOUPONUP_API   (@"getscouponup") //  取领优惠券
#define SHOUCOMMENT_API    (@"showcomment")  //  单品评价详情
#define BINDMOBILE_API     (@"bindmobile")  // 绑定手机
#define SENDCODES_API      (@"sendcodes") //发送验证码
#define Achievecode_API    (@"achievecode") //完善个人资料 发送验证码
#define RESTPASS_API       (@"resetpass") //重置密码接口
#define RESTPASSUP_API     (@"resetpassup") //修改密码 操作  接口
#define SINAWEIBO_API      (@"sinaweibo")   //新浪微博登录
#define SINACALLBACK_API   (@"sinacallback")  // 新浪微博验证接口
#define WANGYIWEIBO_API    (@"wangyicallback")  //网易微博登录
#define WANGYIWEIBOBACK_API    (@"wangyicallback")  //网易微博验证接口
#define FindPasswordUP_API  (@"findpasswordup") //找回密码(验证邮箱或者手机号发送验证码)
#define ResetPassUP_API   (@"resetpassup")  //修改密码 操作  接口
//邱岩
#define CheckCommet_API    (@"goodscomment") //我要评价
#define Qqcallback_API     (@"qqcallback")  //qq验证接口
#define Provemobile_API    (@"provemobile")  //门店会员激活
#define Setv6user_API      (@"setv6user")  //注册+验证
#define Addcomment_AAPI      (@"addcomment")  //添加评价
#define CheckOfflineMobile_API  (@"checkOfflineMobile") //验证用户是否是线下会员
#define V6userlogin_API       (@"v6userlogin")   //已注册过的会员激活验证
#define TrdnoByOrderld_API  (@"")   //银联支付接口 返回交易码
#define UpdatePwd_API        (@"updatepwd") // 修改密码
#define INFO_API              (@"info") //我的爱慕显示会员信息
#define EDITINFO_API         (@"editinfo") //提交修改
#define Dealapply_API        (@"dealapply") //处理申请会员信息

#define Selectgifts_API     (@"selectgifts") //赠品接口
#define Uploadface_API      (@"uploadface") //修改个人头像


#define Alipaylogin_API     (@"alipaylogin") //支付宝快捷登录

#define AlipayloginNEW_API (@"alipaylogining")  // 支付宝登录，新接口


#define Linkageconfirmpay_API (@"linkageconfirmpay") //联动支付完成后  修改订单状态
#define Confim_alipay_API     (@"confim_alipay")   //支付宝完成后  修改订单状态

#define Branddetail_API      (@"branddetail") //品牌馆详情

#define Branddetail20_API      (@"branddetail20") //品牌馆详情


#define Clientinformation_API (@"clientinformation") //客户端信息
#define CouponList20    (@"couponlist20")//优惠卡增加接口

