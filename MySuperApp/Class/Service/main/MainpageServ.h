//
//  MainpageServ.h
//  MySuperApp
//
//  Created by lee on 14-3-14.
//  Copyright (c) 2014年 aimer. All rights reserved.
//


//#import "NetRequest.h"
#import "ServiceBaseWithMK.h"

@interface MainpageServ : ServiceBaseWithMK

//首页数据
- (void)getMaindata;

//商城数据
- (void)getHomepagedata;

//二维码扫描
- (void)getScan:(NSString *)qr;

//品牌馆数据
-(void)getBrandlist ;
//品牌馆详情请
-(void)getBrandDetaillist;

// *品牌资讯 tag Http_Brandzixun_Tag Brandzixun_API
- (void)getBrandzixun:(NSString *)brandName;
//潮流新品
- (void)getBrandtrend:(NSString *)brandName;

//杂志
- (void)getmagazineData:(NSString *)parent_cate;


//门店
- (void)getShopLocation:(NSString *)lat andLng:(NSString *)lng andDistance:(NSString *)distance;

//搜索关键字
- (void)getSearch;

//商品列表
- (void)getProductlist:(NSString *)params andOrder:(NSString *)order andKeyword:(NSString *)keyword andPage:(NSString *)page andPer_page:(NSString *)per_page;

//套装列表
- (void)getSuitlistwithname:(NSString*)asuitname;

//商品详情
- (void)getProductDetail:(NSString *)productid;

//登录
- (void)initWithusername:(NSString*)username email:(NSString*)email andMobilephone:(NSString *)mobilephone andPassword:(NSString *)password;

//新浪微博联合登录回调
- (void)getSinaCallBack:(NSString *)ids andName:(NSString *)name andGender:(NSString*)gender andImageUrl:(NSString *)url;


//微信联合登录
- (void)getWechatCallBack:(NSString *)openid andName:(NSString *)name;


//支付宝联合登录
//- (void)getAlipaylogin:(NSString *)userid andToken:(NSString *)token;
- (void)getAlipayloginWithauthcode:(NSString *)auth_code;

//退出
-(void)getuserLogout;

//注册
- (void)getRegisterWithusername:(NSString*)username email:(NSString*)email andMobilephone:(NSString *)mobilephone andPassword:(NSString *)password andConfirmpw:(NSString *)confirmpw andIslogin:(BOOL)islogin andVerfyCode:(NSString*)vcode;


//验证用户是否是线下会员
- (void)getCheckOfflineMobile:(NSString *)mobel andType:(NSString *)type;

//获取用户信息
-(void)getUserInfo;

//门店会员激活
- (void)getProveMobile:(NSString *)mobilephone andType:(NSString *)type;

// 注册+验证
- (void)getSetv6user:(NSString *)telNum andCode:(NSString *)code andLoginName:(NSString *)loginName andPwd:(NSString *)pwd;

//已注册过的会员激活验证
- (void)getV6userlogin:(NSString *)v6usermobile andV6checkcode:(NSString *)v6checkcode andLoginName:(NSString *)loginName andLoginPwd:(NSString *)loginPwd;

//qq联合登录验证接口
- (void)getqqCallBack:(NSString *)ids andNickName:(NSString *)nickname andFigureurl:(NSString *)url andGender:(NSString *)gender;

//意见反馈
- (void)getFeedback:(NSString *)content andContact:(NSString *)contact andType:(NSString *)type ;

// 找回密码(验证邮箱或者手机号发送验证码)
- (void)getFindPasswordup:(NSString *)mobilenum;

// 修改密码
- (void)getUpdatePwd:(NSString *)old_password  andNewPad:(NSString *)new_password;

//修改密码 操作 
- (void)getResetpassup:(NSString *)user_id andCheckcode:(NSString *)checkcode andPassword:(NSString *)password;

//绑定手机
- (void)getBindmobile:(NSString *)phonenum andSendcodeno:(NSString *)sendcodeno;

//发送验证码
- (void)getSendcodes:(NSString *)phonenum;

// *地址列表
- (void)getAddersslist;

// *删除地址
- (void)getAddressdel:(NSString *)addressID;

//修改地址
- (void)getAddressEdit:(NSString *)addressID  andName:(NSString *)name andArea:(NSString *)area andMobilephone:(NSString *)mobilephone andCity:(NSString *)city andDetail:(NSString *)detail andProvince:(NSString *)province andTelephone:(NSString *)telephone andZipcode:(NSString *)zipcode andEmail:(NSString *)email;

//添加地址
- (void)getAddressAdd:(NSString *)name andArea:(NSString *)area andMobilephone:(NSString *)mobilephone andCity:(NSString *)city andDetail:(NSString *)detail andProvince:(NSString *)province andTelephone:(NSString *)telephone andZipcode:(NSString *)zipcode andEmail:(NSString *)email;

//我的爱慕，个人信息
- (void)getuserInfo;

//我的爱慕，个人信息
- (void)editUSerinfoBrasize:(NSString *)brasize andUnderpants:(NSString *)underpants andClothsize:(NSString *)clothsize andRealname:(NSString *)realname andGender:(NSString *)gender andNickname:(NSString *)nickname andBirthday:(NSString *)birthday andMobile:(NSString *)mobile andAddress:(NSString *)address andEmail:(NSString *)email andProfession:(NSString *)profession andIncome:(NSString *)income andChild1_Birthday:(NSString *)child1_birthday andAk_Name_1:(NSString *)ak_name_1 andAk_Name_2:(NSString *)ak_name_2 andAk_Sex_1:(NSString *)ak_sex_1 andAk_Sex_2:(NSString *)ak_sex_2 andChild1H:(NSString *)child1H andChild2H:(NSString *)child2H andZipcode:(NSString *)zipcode andChild2_Birthday:(NSString *)child2_birthday;

//添加到收藏夹
- (void)getFavoriteadd:(NSString *)productid andType:(NSString*)atype;

//从收藏夹删除
- (void)getFavoritedel:(NSString *)productid andType:(NSString*)atype;

//收藏夹列表
-(void)getFavList:(NSString *)page andPer_page:(NSString *)per_page andtype:(NSString*)atype;

//订单列表
- (void)getOrderlists:(NSString *)action andPage:(NSString *)page andPer_page:(NSString *)per_page;

//频道专区主页
- (void)getChannelcate:(NSString *)channelid;

//消息列表
- (void)getNoticelist;

//消息详情
- (void)getNotices:(NSString *)noticesID;

//添加购物车
- (void)getCar_add:(NSString *)sku;

//*修改购物车  tag Http_EditCar_Tag
- (void)getEditcar:(NSString *)sku;

//修改购物车中的套装
- (void)getEditsuittocar:(NSString *)sku andSuitid:(NSString *)suitid;

//*删除购物车中的套装
- (void)getDeletesuittocar:(NSString *)sku;

//*从购物车删除
- (void)getDelcar:(NSString *)sku;

//获取购物车数据
- (void)getCar;

//购物车选择赠品
- (void)getSelectgifts;

//结算中心
- (void)getCheckout:(NSString *)address andV6usercard_id:(NSString *)v6CardId andCouponcard:(NSString *)couponcard payway:(NSString*)paywaystr;

//提交订单
- (void)getSubmitorder:(NSString *)address andCouponcard:(NSString *)couponcard andPayway:(NSString *)payway andPayprice:(NSString *)payprice andRemarkmsg:(NSString *)remarkmsg andCard_id:(NSString *)card_id;

//订单详情
- (void)getOrderdetail:(NSString *)orderid;

//支付宝完成后  修改订单状态
- (void)getConfim_alipay:(NSString *)co_id;

//联动支付完成后  修改订单状态
- (void)getLinkageconfirmpay:(NSString *)co_id;

//取消订单
- (void)getCancelorder:(NSString *)ordered andReason:(NSString*)strreson;

//商品详情评价
- (void)getShowcomment:(NSString *)goodsid andPage:(NSString *)page andPer_page:(NSString *)per_page;

//发表评价  //发表订单评价 lee999
- (void)getCheckComment:(NSString *)goodsid andCo_id:(NSString *)co_id;


//添加评价
- (void)getAddcommentGoods_Id:(NSString *)goods_id
                andProduct_Id:(NSString *)product_id
                     andCo_Id:(NSString *)co_id
                    andScore0:(NSString *)score0
                    andScore1:(NSString *)score1
                    andScore2:(NSString *)score2
                    andScore3:(NSString *)score3
                    andScore4:(NSString *)score4
                    andScore5:(NSString *)score5
                   andContent:(NSString *)content;


//评论整个订单
- (void)getAddOrdercomments:(NSString *)comms
                      co_id:(NSString *)coid
                  andScore0:(NSString *)score0
                  andScore1:(NSString *)score1
                  andScore2:(NSString *)score2
                  anonymous:(NSString *)anony;


//套装详情
- (void)getSuitinfo:(NSString *)suitinfo;

//套装添加到购物车
- (void)getAddsuittocar:(NSString *)sku andSuitid:(NSString *)suitid;

//绑定优惠券
- (void)addCouponcard:(NSString *)card_id;

//积分兑换记录
- (void)getexchangescorerecord:(NSString *)card_id;

//优惠卡列表接口
- (void)getCouponcardListWithPage:(NSString *)page andPer_page:(NSString *)per_page;

//积分兑换接口
- (void)exchangecoupon:(NSString *)card_id;

//使用尊享卡接口
- (void)usev6card:(NSString *)cardId mobile:(NSString *)mobile checkcode:(NSString *)checkcode;

//完善资料 发送验证码
- (void)getAchievecode:(NSString *)phonenum;

//处理申请会员信息
- (void)getDealapplyZunxiang:(NSString *)zunxiang andKey:(NSString *)key andName:(NSString *)name andSex:(NSString *)sex andNick_Name:(NSString *)nick_name andMobile:(NSString *)mobile andAk_Height_1:(NSString *)ak_height_1 andAk_Height_2:(NSString *)ak_height_2 andCheckcode:(NSString *)checkcode andAk1_Year:(NSString *)ak1_Year andAk1_Month:(NSString *)ak1_Month andAk1_Day:(NSString *)ak1_Day andAk2_Year:(NSString *)ak2_Year andAk2_Month:(NSString *)ak2_Month andAk2_Day:(NSString *)ak2_Day andAk_Name_1:(NSString *)ak_name_1 andAk_Name_2:(NSString *)ak_name_2 andV6User_Year:(NSString *)v6user_Year andV6User_Month:(NSString *)v6user_Month andV6User_Day:(NSString *)v6user_Day andAk_Sex_1:(NSString *)ak_sex_1 andAk_Sex_2:(NSString *)ak_sex_2 andAddress:(NSString *)address andEmail:(NSString *)email andZipcode:(NSString *)zipcode andAge:(NSString *)age andIncome:(NSString *)income andProfession:(NSString *)profession andBrasize:(NSString *)brasize andUnderpants:(NSString *)underpants andClothsize:(NSString *)clothsize;

//领取优惠券界面~
- (void)getGetscoupon:(NSString *)couponed;

//领取优惠券~
- (void)getGetscouponup:(NSString *)couponid;

//查找物流
- (void)getLogistics:(NSString *)expressed andDelivery_type:(NSString *)delivery_type;

//上传头像
- (void)getUpLoadface:(NSData *)Filedata;


/*
 *版本检查 tag Http_Version_Tag
 */
- (void)getappVersion;

//确认收货
- (void)makesuregetgood:(NSString*)goodid;

//获取银联交易号
-(void)upmpTradno:(NSString*)aorderid;




//lee999 200版本开发
//首页2.0
- (void)getHomePage20data;

//杂志
- (void)getMageinzeList20datawithTpye:(NSString*)atype;

- (void)getMageinzeDetail20data:(NSString*)mageinzeid;

//店铺
- (void)getStoreList20data;

- (void)getStoreDetail20data;

//收藏夹列表！！！
- (void)getFavorite20data;

//获取我的爱慕页面更多推荐的信息
- (void)getMoreMyAimer20data;


- (void)getSort20data;


-(void)getBrandDetail20:(NSString*)brandID;


//存储私人衣橱的信息
- (void)getaddwardrobeupdata:(NSString *)wardrobe_name
                    andcrowd:(NSString*)crowd
                andfrequency:(NSString*)frequency
                     andsize:(NSString *)size
                    andprops:(NSString*)props_id
                     andtype:(NSString*)type;


//新版本收藏夹列表  tag210
-(void)getFavListnew20:(NSString *)page andPer_page:(NSString *)per_page andtype:(NSString*)atype;



//获取注册时候的验证码
- (void)getRegisterVerifycode:(NSString *)mobile;



//获取私人衣橱2 的数据
-(void)getCloset2Data:(NSString*)strtype;

//获得礼包详情
-(void)getPackageInfoWithPid:(NSString*)pid;

//获得优惠券列表
- (void)getCouponcardList20WithPage:(NSString *)page andPer_page:(NSString *)per_page andType:(NSString*)type;


//礼包加入购物车
- (void)addPackageToCartWithData:(NSArray*)data andPid:(NSString*)pid_;

//定期更换内衣提醒
-(void)alertChangeMyClost:(NSString *)shangyi andDown:(NSString*)xiayi;

//获取预约测体门店
-(void)getbespeak;


//预约测体
-(void)bespeakup:(NSString*)storeid andTime:(NSString*)atime anduid:(NSString*)userid;

//获取私人衣橱列表
-(void)getwardrobeinfo;

@end







