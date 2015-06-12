//
//  EADefine.h
//  网络请求用到的各种常量、宏定义、枚举等
//
//  Created by yufeiyue  on 13-7-9.
//  Copyright (c) 2014年 eastedge. All rights reserved.
//

//请求地址

//18315151515  密码 1qaz1qaz



//====================================================
// 用途: 服务器地址
//====================================================




//#define WebSeviceUrl TESTDOMAIN

//#define HttpRequestMethod @"requestCommand"

//请求tag宏定义
//
//#define Http_Main_Tag 99 //app首页
//
//#define Http_Scan_Tag 100 //扫描
//
//#define Http_Login_Tag 101 //登录
//
//#define Http_Home_Tag 102 //首页
//
//#define Http_Search_Tag 103 //搜索
//
//#define Http_Brands_Tag 104 //品牌列表
//
//#define Http_Categories_Tag 105 //分类列表
//
//#define Http_Productlist_Tag 106 //商品列表(附:筛选)
//
//#define Http_Product_Tag 107 // 商品详情
//
//#define Http_Channelcate_Tag 108 //频道专区主页
//
//#define Http_Channelllist_Tag 109 //频道专区主页
//
//#define Http_Car_Tag 110 //购物车
//
//#define Http_Checkout_Tag 111 //结算中心
//
//#define Http_Check_couponcard_Tag 112 // 验证优惠卷是否有效
//
//#define Http_Submitorder_Tag 113 // 提交订单
//
//#define Http_Addresslist_Tag 114 //  地址列表
//
//#define Http_Favorite_Tag 115 // 收藏夹列表
//
//#define Http_Orders_Tag 116 //订单列表
//
//#define Http_Orderdetail_Tag 117 //订单详情
//
//#define Http_More_Tag 118 //获取我的爱慕页面更多推荐的信息
//
//#define Http_Active_Tag 119 //激活(第一次运行)
//
//#define Http_Version_Tag 120 //版本检查
//
//#define Http_Register_Tag 121 //注册
//
//#define Http_Productionfo_Tag 122 // 更新商品信息
//
//#define Http_Logout_Tag 123 //注销
//
//#define Http_Car_add_Tag 124 //添加到购物车
//
//#define Http_Addsuittocar_Tag 125 //  添加套装到购物车
//
//#define Http_EditCar_Tag 126 //修改购物车
//
//#define Http_Editsuittocar_Tag 127 //修改购物车中的套装
//
//#define Http_Suittocart_deletes_Tag 128 // 删除购物车中的套装
//
//#define Http_Delcar_Tag 129 //从购物车删除
//
//#define Http_Addressadd_Tag 130 //添加地址
//
//#define Http_AddressEdit_Tag 131 //修改地址
//
//#define Http_AddressDel_Tag 132 //删除地址
//
//#define Http_FavoriteAdd_Tag 133 //添加到收藏夹
//
//#define Http_FavoriteDel_Tag 134 //从收藏夹删除
//
//#define Http_CancelOrder_Tag 135 //取消订单
//
//#define Http_NoticeList_Tag 136 //消息列表
//
//#define Http_SuitList_Tag 137 //  套装列表
//
//#define Http_SuitInfo_Tag 138 //  套装详情
//
//#define Http_FeedBack_Tag 139 //  意见反馈
//
//#define Http_Store_Tag 140 //   门店查询
//
//#define Http_Magazine_Tag 141 //  杂志
//
//#define Http_Getscoupon_Tag 142 //  领卷页面
//
//#define Http_Getscouponup_Tag 143 //    领取优惠券
//
//#define Http_Showcomment_Tag 144 //    单品评价详
//
//#define Http_Bindmobile_Tag 145 //      绑定手机
//
//#define Http_Sendcodes_Tag 146 //      发送验证码
//
//#define Http_Brandtrend_Tag 147 // 潮流新品
//
//#define Http_Brandzixun_Tag 148  //品牌资讯
//
//#define Http_Notices_Tag   149  // 消息详情/公告详情
//
//#define Http_Resetpass_Tag 150  //重置密码接口
//
////Add 8.20
//
//#define Http_Resetpassup_Tag 151 ////修改密码 操作  接口
//
//#define Http_Sinaweibo_Tag  152 //新浪微博登录
//
//#define Http_Sinacallback_Tag 153 //新浪微博验证接口
//
//#define Http_Wangyiweibo_Tag  154 //网易微博登录
//
//#define Http_Wangyicallback_Tag 155 //网易微博验证接口
//
//#define Http_Logistics_Tag  156 //查找物流
//
//#define Http_Findpasswordup_Tag 157 // 找回密码(验证邮箱或者手机号发送验证码)
//
//#define Http_CheckCommet_Tag 158 //(我要评价
//
//#define Http_Qqcallback_Tag 159 //qq验证接口
////8.22
//
//
//
////8.26
//
//#define Http_CoupncardList_Tag 160 //优惠卡列表接口
//
////9.3
//
//#define Http_provemobile_Tag 161 //门店会员激活
//#define Http_setv6user_Tag  162 // 注册+验证
//#define Http_addcomment_Tag 163 //添加评价
//
////9.9
//#define Http_CheckOfflineMobile_Tag 164 //验证用户是否是线下会员
//#define Http_v6userlogin_Tag  165  //已注册过的会员激活验证
//
//
//#define Http_TrdnoByOrderld_Tag 166 //银联支付接口 返回交易码
//
//
//#define Http_UpdatePwd_Tag      167  // 修改密码
//
//#define Http_INFO_Tag  168  //我的爱慕显示会员信息
//#define Http_EditInfo_Tag 169 ////提交修改
//
//#define Http_Dealapply_Tag 170 //处理申请会员信息
//
//#define Http_Selectgifts_Tag 171 //赠品列表（有活动 1 2 3 4）
//
//#define Http_Uploadface_Tag 172 //修改个人头像
//#define Http_Alipaylogin_Tag 173 //支付宝快捷登录
//
//#define Http_Linkageconfirmpay_Tag  174 //联动支付完成后  修改订单状态
//#define Http_Confim_alipay_Tag     175   //支付宝完成后  修改订单状态
//
//#define Http_Branddetail_Tag      176 //品牌馆详情
//
//#define Http_exchangecoupon_Tag  200 //积分兑换接口
//#define Http_usev6card_Tag  201 //使用尊享卡接口
//#define Http_addCouponcard_Tag  202 //绑定优惠券接口
//#define Http_getexchangescorerecord_Tag  203 //积分兑换记录
//
//
//#define Http_Clientinformation_Tag 1889  // 客户端信息
//
////lee999
//#define Http_Makesuregetgood_Tag    99228  //确认收货
//
//#define Http_ANWOAD_Tag 9001 //安沃广告ID
//
//
////2.0新版本开发
//#define Http_Homepage20_Tag      300 //新版本！！！
//


//end






//====================================================
// 用途: API拼接
// 格式: 数据名称_API
//====================================================

/*

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

#define Clientinformation_API (@"clientinformation") //客户端信息


*/

////====================================================
//// 用途: 发送服务器请求用的拼接字符串
//// 格式: 发送请求的页面_2_跳转后页面_SENDDATA
////====================================================
//#define BRANDS_2_PRODUCTLIST_SENDDATA @"brand:0:"
//#define CHANNEL_PRODUCTLIST_SENDDATA  @"category:0:"
//#define SORT_2_PRODUCTLIST_SENDDATA   @"category/"
//#define SEARCH_2_PRODUCTLIST_SENDDATA @""
//#define PRODUCTLIST_2_PRODUCTDETAIL_SENDDATA @""
//#define PRODUCTLIST_2_SEKPRODUCTDETAIL_SENDDATA @"skillid/"

//#define AddController_backgroundColor self.view.backgroundColor=[UIColor colorWithRed:(0xde)/255.0 green:(0xe1)/255.0 blue:(0xe5)/255.0 alpha:(0.0)];
//#define Background_RGBACOLOR [UIColor colorWithRed:(0xde)/255.0 green:(0xe1)/255.0 blue:(0xe5)/255.0 alpha:(0.0)]
//#define WHETHERTABLEHIDDEN(_TABLE,_IMAGE,_WHETHER,_RESETEDITING){_TABLE.hidden=_WHETHER;_IMAGE.hidden=!_WHETHER;if([_TABLE isKindOfClass:[UITableView class]]){_TABLE.editing=_RESETEDITING?NO:_TABLE.editing;}}

//====================================================
// 用途: 用于跳转升级的URL
//====================================================
//#define UPDATE_URL @"http://bjyek.9966.org:8080/yekapi/index.php/"


//====================================================
// 用途: 判断字符串是否为空
//====================================================
//#define strIsEmpty(str) (str==nil || [str length]<1 ? YES : NO )

//====================================================
//#define RGBACOLOR(_r, _g, _b, _a) [UIColor colorWithRed:(_r)/255.0 green:(_g)/255.0 blue:(_b)/255.0 alpha:(_a)]