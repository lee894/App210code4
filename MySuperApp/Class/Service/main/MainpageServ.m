//
//  MainpageServ.m
//  MySuperApp
//
//  Created by lee on 14-3-14.
//  Copyright (c) 2014年 aimer. All rights reserved.
//

#import "MainpageServ.h"
#import "SingletonState.h"
#import "MYMacro.h"

@implementation MainpageServ

- (void)getMaindata {
    [self sendPostWithURL:Main_API tag:Http_Main_Tag beforeRequest:^{
    }];
}

//商城数据
- (void)getHomepagedata{
    [self sendPostWithURL:HOME_PAGE_API tag:Http_Home_Tag beforeRequest:^{
    }];
}

//二维码扫描
- (void)getScan:(NSString *)qr{
    [self sendPostWithURL:SCAN_API tag:Http_Scan_Tag beforeRequest:^{
        [self addParam:@"bn" withValue:qr];
    }];
}

//品牌列表
-(void)getBrandlist{
    [self sendPostWithURL:BRANDS_WALL_API tag:Http_Brands_Tag beforeRequest:^{
    }];
}
////品牌馆详情  tag 176
-(void)getBrandDetaillist{
    [self sendPostWithURL:Branddetail_API tag:Http_Branddetail_Tag beforeRequest:^{
        
    }];
}


/*
 *品牌资讯 tag Http_Brandzixun_Tag Brandzixun_API
 */
- (void)getBrandzixun:(NSString *)brandName{
    
    NSLog(@"brandName---:%@",brandName);
    [self sendPostWithURL:Brandzixun_API tag:Http_Brandzixun_Tag beforeRequest:^{
        [self addParam:@"brandName" withValue:brandName];
    }];
}

/*
 *潮流新品  tag Http_Brandtrend_Tag Brandtrend_API
 */
- (void)getBrandtrend:(NSString *)brandName {
    
    [self sendPostWithURL:Brandtrend_API tag:Http_Brandtrend_Tag beforeRequest:^{
        [self addParam:@"brandName" withValue:brandName];
    }];
}

//杂志
- (void)getmagazineData:(NSString *)parent_cate{
    [self sendPostWithURL:MAGAZINE_API tag:Http_Magazine_Tag beforeRequest:^{
        [self addParam:@"parent_cate" withValue:parent_cate];
    }];
}


//门店
- (void)getShopLocation:(NSString *)lat andLng:(NSString *)lng andDistance:(NSString *)distance{
    if (lat == nil) {
        lat = @"";
    }
    if (lng == nil) {
        lng = @"";
    }
    [self sendPostWithURL:STORE_API tag:Http_Store_Tag beforeRequest:^{
        [self addParam:@"lat" withValue:lat];
        [self addParam:@"lng" withValue:lng];
        [self addParam:@"distance" withValue:distance];
    }];
    
}

//搜索关键字
- (void)getSearch{
    [self sendPostWithURL:SEATCH_API tag:Http_Search_Tag beforeRequest:^{
    }];
}

//商品列表
- (void)getProductlist:(NSString *)params andOrder:(NSString *)order andKeyword:(NSString *)keyword andPage:(NSString *)page andPer_page:(NSString *)per_page{
    
    if (params == nil) {
        params = @"";
    }
    if (order == nil) {
        order = @"";
    }
    if (keyword == nil) {
        keyword = @"";
    }
    if (page == nil) {
        page = @"";
    }
    if (per_page == nil) {
        per_page = @"";
    }
    
    //0 其他    1首页 需要追加参数  2 品牌馆商品列表  3 MillHome   4，废弃   5,为我推荐的更多推荐
    //首页  home
    if ([SingletonState sharedStateInstance].productlistType == 1) {
        params = [NSString stringWithFormat:@"%@%@",CHANNEL_PRODUCTLIST_SENDDATA,params];
        
    }else if ([SingletonState sharedStateInstance].productlistType == 2){        
    }else if ([SingletonState sharedStateInstance].productlistType == 3){
    }else if ([SingletonState sharedStateInstance].productlistType == 4){
    }

        [self sendPostWithURL:PRODUCT_LIST_API tag:Http_Productlist_Tag beforeRequest:^{
            
            
        [self addParam:@"params" withValue:params];
        [self addParam:@"order" withValue:order];
        [self addParam:@"keyword" withValue:keyword];
        [self addParam:@"page" withValue:page];
        [self addParam:@"per_page" withValue:per_page];
            
        if ([SingletonState sharedStateInstance].productlistType == 5){
            //lee999 新增   为我推荐的更多推荐   5
            [self addParam:@"category" withValue:@"3267"];
        }
    }];
}

//套装列表
- (void)getSuitlistwithname:(NSString*)asuitname{
    [self sendPostWithURL:SUITLIST_API tag:Http_SuitList_Tag beforeRequest:^{
        [self addParam:@"suitname" withValue:asuitname];
        
        //[asuitname stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]
    }];
}

//商品详情
- (void)getProductDetail:(NSString *)productid {
    [self sendPostWithURL:PRODUCT_DETIAL_API tag:Http_Product_Tag beforeRequest:^{
        [self addParam:@"productid" withValue:productid];
    }];
}


//登录
- (void)initWithusername:(NSString*)username email:(NSString*)email andMobilephone:(NSString *)mobilephone andPassword:(NSString *)password{
    if (username == nil) {
        username = @"";
    }
    if (password == nil) {
        password = @"";
    }
    [self sendPostWithURL:LOGIN_API tag:Http_Login_Tag beforeRequest:^{
        [self addParam:@"username" withValue:username];
        [self addParam:@"password" withValue:password];
    }];
}

//新浪微博联合登录回调
- (void)getSinaCallBack:(NSString *)ids andName:(NSString *)name andGender:(NSString*)gender andImageUrl:(NSString *)url
{
    [self sendPostWithURL:SINACALLBACK_API tag:Http_Sinaweibo_Tag beforeRequest:^{
        [self addParam:@"id" withValue:ids];
        [self addParam:@"name" withValue:name];
        [self addParam:@"gender" withValue:gender];
        [self addParam:@"profile_image_url" withValue:url];
    }];
}

//微信联合登录
- (void)getWechatCallBack:(NSString *)openid andName:(NSString *)name
{
    [self sendPostWithURL:WechatLoginCALLBACK_API tag:Http_whchatLogin_Tag beforeRequest:^{
        [self addParam:@"openid" withValue:openid];
        [self addParam:@"nickname" withValue:name];
    }];
}


//支付宝联合登录
//- (void)getAlipaylogin:(NSString *)userid andToken:(NSString *)token{
//    [self sendPostWithURL:AlipayloginNEW_API tag:Http_Alipaylogin_Tag beforeRequest:^{
//        [self addParam:@"token" withValue:token];
//        [self addParam:@"aliuserid" withValue:userid];
//    }];
//}

- (void)getAlipayloginWithauthcode:(NSString *)auth_code{
    [self sendPostWithURL:AlipayloginNEW_API tag:Http_Alipaylogin_Tag beforeRequest:^{
        [self addParam:@"auth_code" withValue:auth_code];
    }];
}


//退出
-(void)getuserLogout{
    [self sendPostWithURL:LOGINOUT_API tag:Http_Logout_Tag beforeRequest:^{
    }];
}

//注册
- (void)getRegisterWithusername:(NSString*)username email:(NSString*)email andMobilephone:(NSString *)mobilephone andPassword:(NSString *)password andConfirmpw:(NSString *)confirmpw andIslogin:(BOOL)islogin andVerfyCode:(NSString*)vcode{
    if (username == nil) {
        username = @"";
    }
    if (email == nil) {
        email = @"";
    }
    if (mobilephone == nil) {
        mobilephone = @"";
    }
    if (password == nil) {
        password = @"";
    }
    if (confirmpw == nil) {
        confirmpw = @"";
    }
    
    [self.dataParams removeAllObjects];
    
    [self sendPostWithURL:REGISTER_API tag:Http_Register_Tag beforeRequest:^{
        [self addParam:@"username" withValue:username];
        [self addParam:@"email" withValue:@""];
        [self addParam:@"mobilephone" withValue:@""];
        [self addParam:@"verify_code" withValue:vcode];
        [self addParam:@"password" withValue:password];
        [self addParam:@"confirmpw" withValue:confirmpw];

    }];
}

//验证用户是否是线下会员
- (void)getCheckOfflineMobile:(NSString *)mobel andType:(NSString *)type{
    
    [self sendPostWithURL:CheckOfflineMobile_API tag:Http_CheckOfflineMobile_Tag beforeRequest:^{
        [self addParam:@"mobile" withValue:mobel];
        [self addParam:@"type" withValue:type];
    }];
}

//获取用户信息
-(void)getUserInfo{
    [self sendPostWithURL:MORE tag:Http_More_Tag beforeRequest:^{
    }];
}


//门店会员激活
- (void)getProveMobile:(NSString *)mobilephone andType:(NSString *)type{
    if (mobilephone == nil) {
        mobilephone = @"";
    }
    if (type == nil) {
        type = @"";
    }
    [self sendPostWithURL:Provemobile_API tag:Http_provemobile_Tag beforeRequest:^{
        [self addParam:@"mobile" withValue:mobilephone];
        [self addParam:@"type" withValue:type];
    }];
}

// 注册+验证
- (void)getSetv6user:(NSString *)telNum andCode:(NSString *)code andLoginName:(NSString *)loginName andPwd:(NSString *)pwd{
    if (telNum == nil) {
        telNum = @"";
    }
    if (code == nil) {
        code = @"";
    }
    if (loginName == nil) {
        loginName = @"";
    }
    if (pwd == nil) {
        pwd = @"";
    }
    [self sendPostWithURL:Setv6user_API tag:Http_setv6user_Tag beforeRequest:^{
        [self addParam:@"v6usermobile" withValue:telNum];
        [self addParam:@"v6checkcode" withValue:code];
        [self addParam:@"login_name" withValue:loginName];
        [self addParam:@"pws" withValue:pwd];
    }];
}

//已注册过的会员激活验证
- (void)getV6userlogin:(NSString *)v6usermobile andV6checkcode:(NSString *)v6checkcode andLoginName:(NSString *)loginName andLoginPwd:(NSString *)loginPwd
{
    
    [self sendPostWithURL:V6userlogin_API tag:Http_v6userlogin_Tag beforeRequest:^{
        [self addParam:@"v6usermobile" withValue:v6usermobile];
        [self addParam:@"v6checkcode" withValue:v6checkcode];
        [self addParam:@"login_name" withValue:loginName];
        [self addParam:@"login_pwd" withValue:loginPwd];
    }];
}

//qq验证接口
- (void)getqqCallBack:(NSString *)ids andNickName:(NSString *)nickname andFigureurl:(NSString *)url andGender:(NSString *)gender
{
    [self sendPostWithURL:Qqcallback_API tag:Http_Qqcallback_Tag beforeRequest:^{
        [self addParam:@"id" withValue:ids];
        [self addParam:@"nickname" withValue:nickname];
        [self addParam:@"figureurl" withValue:url];
        [self addParam:@"gender" withValue:gender];
    }];
}

//意见反馈
- (void)getFeedback:(NSString *)content andContact:(NSString *)contact andType:(NSString *)type {
    [self sendPostWithURL:FeedBack_API tag:Http_FeedBack_Tag beforeRequest:^{
        [self addParam:@"content" withValue:content];
        [self addParam:@"contact" withValue:contact];
        [self addParam:@"type" withValue:type];
    }];
}

// 找回密码(验证邮箱或者手机号发送验证码)
- (void)getFindPasswordup:(NSString *)mobilenum{
    [self sendPostWithURL:FindPasswordUP_API tag:Http_Findpasswordup_Tag beforeRequest:^{
        [self addParam:@"mobilenum" withValue:mobilenum];
    }];
}

// 修改密码
- (void)getUpdatePwd:(NSString *)old_password  andNewPad:(NSString *)new_password{
    [self sendPostWithURL:UpdatePwd_API tag:Http_UpdatePwd_Tag beforeRequest:^{
        [self addParam:@"old_password" withValue:old_password];
        [self addParam:@"new_password" withValue:new_password];
    }];
}

//修改密码 操作
- (void)getResetpassup:(NSString *)user_id andCheckcode:(NSString *)checkcode andPassword:(NSString *)password{
    [self sendPostWithURL:RESTPASSUP_API tag:Http_Resetpassup_Tag beforeRequest:^{
        [self addParam:@"user_id" withValue:user_id];
        [self addParam:@"checkcode" withValue:checkcode];
        [self addParam:@"password" withValue:password];
    }];
}

//绑定手机
- (void)getBindmobile:(NSString *)phonenum andSendcodeno:(NSString *)sendcodeno{
    [self sendPostWithURL:BINDMOBILE_API tag:Http_Bindmobile_Tag beforeRequest:^{
        [self addParam:@"phonenum" withValue:phonenum];
        [self addParam:@"sendcodeno" withValue:sendcodeno];
    }];
}

//发送验证码
- (void)getSendcodes:(NSString *)phonenum{
    [self sendPostWithURL:SENDCODES_API tag:Http_Sendcodes_Tag beforeRequest:^{
        [self addParam:@"phonenum" withValue:phonenum];
    }];
}

// *地址列表
- (void)getAddersslist{
    [self sendPostWithURL:ADDRESS_LIST_API tag:Http_Addresslist_Tag beforeRequest:^{
    }];
}

// *删除地址
- (void)getAddressdel:(NSString *)addressID{
    [self sendPostWithURL:ADDRESS_DEL_API tag:Http_AddressDel_Tag beforeRequest:^{
        [self addParam:@"id" withValue:addressID];
    }];
}
//修改地址
- (void)getAddressEdit:(NSString *)addressID  andName:(NSString *)name andArea:(NSString *)area andMobilephone:(NSString *)mobilephone andCity:(NSString *)city andDetail:(NSString *)detail andProvince:(NSString *)province andTelephone:(NSString *)telephone andZipcode:(NSString *)zipcode andEmail:(NSString *)email{
    
    [self sendPostWithURL:ADDRESS_EDIT_API tag:Http_AddressEdit_Tag beforeRequest:^{
        [self addParam:@"id" withValue:addressID];
        [self addParam:@"name" withValue:name];
        [self addParam:@"area" withValue:area];
        [self addParam:@"mobilephone" withValue:mobilephone];
        [self addParam:@"city" withValue:city];
        [self addParam:@"detail" withValue:detail];
        [self addParam:@"province" withValue:province];
        [self addParam:@"telephone" withValue:telephone];
        [self addParam:@"zipcode" withValue:zipcode];
        [self addParam:@"email" withValue:email];
    }];
}

//添加地址
- (void)getAddressAdd:(NSString *)name andArea:(NSString *)area andMobilephone:(NSString *)mobilephone andCity:(NSString *)city andDetail:(NSString *)detail andProvince:(NSString *)province andTelephone:(NSString *)telephone andZipcode:(NSString *)zipcode andEmail:(NSString *)email{
    
    [self sendPostWithURL:ADDRESS_ADD_API tag:Http_Addressadd_Tag beforeRequest:^{
        [self addParam:@"name" withValue:name];
        [self addParam:@"area" withValue:area];
        [self addParam:@"mobilephone" withValue:mobilephone];
        [self addParam:@"city" withValue:city];
        [self addParam:@"detail" withValue:detail];
        [self addParam:@"province" withValue:province];
        [self addParam:@"telephone" withValue:telephone];
        [self addParam:@"zipcode" withValue:zipcode];
        [self addParam:@"email" withValue:email];
    }];
}

//我的爱慕，个人信息
- (void)getuserInfo{
    [self sendPostWithURL:INFO_API tag:Http_INFO_Tag beforeRequest:^{
    }];
}


//我的爱慕，个人信息
- (void)editUSerinfoBrasize:(NSString *)brasize andUnderpants:(NSString *)underpants andClothsize:(NSString *)clothsize andRealname:(NSString *)realname andGender:(NSString *)gender andNickname:(NSString *)nickname andBirthday:(NSString *)birthday andMobile:(NSString *)mobile andAddress:(NSString *)address andEmail:(NSString *)email andProfession:(NSString *)profession andIncome:(NSString *)income andChild1_Birthday:(NSString *)child1_birthday andAk_Name_1:(NSString *)ak_name_1 andAk_Name_2:(NSString *)ak_name_2 andAk_Sex_1:(NSString *)ak_sex_1 andAk_Sex_2:(NSString *)ak_sex_2 andChild1H:(NSString *)child1H andChild2H:(NSString *)child2H andZipcode:(NSString *)zipcode andChild2_Birthday:(NSString *)child2_birthday{

    
    NSLog(@"--%@--%@--%@--%@--%@--%@--%@--%@--%@--%@--%@--%@--%@--%@--%@--%@--%@--%@--%@--%@--%@",brasize,underpants,clothsize,realname,gender,nickname,birthday,mobile,address,email,profession,income,child1_birthday,ak_name_1,ak_name_2,ak_sex_1,ak_sex_2,child1H,child2H,zipcode,child2_birthday);
    
    
    [self sendPostWithURL:EDITINFO_API tag:Http_EditInfo_Tag beforeRequest:^{
        
        [self addParam:@"brasize" withValue:brasize];
        [self addParam:@"underpants" withValue:underpants];
        [self addParam:@"clothsize" withValue:clothsize];
        [self addParam:@"realname" withValue:realname];
        [self addParam:@"gender" withValue:gender];
        [self addParam:@"nickname" withValue:nickname];
        [self addParam:@"birthday" withValue:birthday];
        [self addParam:@"mobile" withValue:mobile];
        [self addParam:@"address" withValue:address];
        [self addParam:@"email" withValue:email];
        [self addParam:@"profession" withValue:profession];
        [self addParam:@"income" withValue:income];
        [self addParam:@"child1_birthday" withValue:child1_birthday];
        [self addParam:@"ak_name_1" withValue:ak_name_1];
        [self addParam:@"ak_name_2" withValue:ak_name_2];
        [self addParam:@"ak_sex_1" withValue:ak_sex_1];
        [self addParam:@"ak_sex_2" withValue:ak_sex_2];
        [self addParam:@"child1H" withValue:child1H];
        [self addParam:@"child2H" withValue:child2H];
        [self addParam:@"zipcode" withValue:zipcode];
        [self addParam:@"child2_birthday" withValue:child2_birthday];
    }];
}

//添加到收藏夹
- (void)getFavoriteadd:(NSString *)productid andType:(NSString*)atype{
    [self.dataParams removeAllObjects];
    [self sendPostWithURL:FAVORITE_ADD_API tag:Http_FavoriteAdd_Tag beforeRequest:^{
        [self addParam:@"productid" withValue:productid];
        [self addParam:@"type" withValue:atype];
    }];
}

//从收藏夹删除
- (void)getFavoritedel:(NSString *)productid  andType:(NSString*)atype{
    [self.dataParams removeAllObjects];
    [self sendPostWithURL:FAVORITE_DEL_API tag:Http_FavoriteDel_Tag beforeRequest:^{
        [self addParam:@"productid" withValue:productid];
        [self addParam:@"type" withValue:atype];
    }];
}

//收藏夹列表
-(void)getFavList:(NSString *)page andPer_page:(NSString *)per_page andtype:(NSString*)atype{

    [self sendPostWithURL:FAVORITE_API tag:Http_Favorite_Tag beforeRequest:^{
        [self addParam:@"page" withValue:page];
        [self addParam:@"per_page" withValue:per_page];
        [self addParam:@"type" withValue:atype];

    }];
}

//订单列表
- (void)getOrderlists:(NSString *)action andPage:(NSString *)page andPer_page:(NSString *)per_page{

    [self sendPostWithURL:ORDERS_API tag:Http_Orders_Tag beforeRequest:^{
        [self addParam:@"action" withValue:action];
        [self addParam:@"current_page" withValue:page];
        [self addParam:@"per_page" withValue:per_page];
    }];
}

//频道专区主页
- (void)getChannelcate:(NSString *)channelid{
    [self sendPostWithURL:CHANNEL_LIST_API tag:Http_Channelcate_Tag beforeRequest:^{
        [self addParam:@"channelid" withValue:channelid];
    }];
}

//消息列表
- (void)getNoticelist{
    [self sendPostWithURL:NOTICELIES_API tag:Http_NoticeList_Tag beforeRequest:^{
    }];
}

//消息详情
- (void)getNotices:(NSString *)noticesID{
    [self sendPostWithURL:NOTICES_API tag:Http_Notices_Tag beforeRequest:^{
        [self addParam:@"noticeid" withValue:noticesID];
    }];
}

//添加购物车
- (void)getCar_add:(NSString *)sku{
    
    [self sendPostWithURL:CAR_ADD_API tag:Http_Car_add_Tag beforeRequest:^{
        [self addParam:@"sku" withValue:sku];
    }];
}


 //*修改购物车  tag Http_EditCar_Tag
- (void)getEditcar:(NSString *)sku {
    
    [self sendPostWithURL:CAR_EDIT_API tag:Http_EditCar_Tag beforeRequest:^{
        [self addParam:@"sku" withValue:sku];
    }];
}

/*
 *修改购物车中的套装  tag Http_Editsuittocar_Tag
 */

- (void)getEditsuittocar:(NSString *)sku andSuitid:(NSString *)suitid {
    
    [self sendPostWithURL:SUITTOCAR tag:Http_Editsuittocar_Tag beforeRequest:^{
        [self addParam:@"sku" withValue:sku];
        [self addParam:@"suitid" withValue:suitid];
    }];
}

/*
 *删除购物车中的套装  tag Http_Suittocart_deletes_Tag
 */

- (void)getDeletesuittocar:(NSString *)sku{
    
    [self sendPostWithURL:CAR_DEL_SUIT tag:Http_Suittocart_deletes_Tag beforeRequest:^{
        [self addParam:@"suitid" withValue:sku];
    }];
}

/*
 *从购物车删除  tag Http_Delcar_Tag
 */

- (void)getDelcar:(NSString *)sku {
    [self sendPostWithURL:CAR_DEL_API tag:Http_Delcar_Tag beforeRequest:^{
        [self addParam:@"sku" withValue:sku];
    }];
}

//获取购物车数据
- (void)getCar {
    [self sendPostWithURL:CAR_API tag:Http_Car_Tag beforeRequest:^{
    }];
}

//购物车选择赠品
- (void)getSelectgifts{
    [self sendPostWithURL:Selectgifts_API tag:Http_Selectgifts_Tag beforeRequest:^{
    }];
}

//结算中心
- (void)getCheckout:(NSString *)address andV6usercard_id:(NSString *)v6CardId andCouponcard:(NSString *)couponcard payway:(NSString*)paywaystr{
    [self sendPostWithURL:CHECKOUT_API tag:Http_Checkout_Tag beforeRequest:^{
        [self addParam:@"address" withValue:address];
        [self addParam:@"v6usercard_id" withValue:v6CardId];
        [self addParam:@"couponcard" withValue:couponcard];
        [self addParam:@"payway" withValue:paywaystr];
    }];
}

//提交订单
- (void)getSubmitorder:(NSString *)address andCouponcard:(NSString *)couponcard andPayway:(NSString *)payway andPayprice:(NSString *)payprice andRemarkmsg:(NSString *)remarkmsg andCard_id:(NSString *)card_id{
    [self sendPostWithURL:ORDER_SUBMIT_API tag:Http_Submitorder_Tag beforeRequest:^{
        [self addParam:@"address" withValue:address];
        [self addParam:@"couponcard" withValue:couponcard];
        [self addParam:@"payway" withValue:payway];
        [self addParam:@"payprice" withValue:payprice];
        [self addParam:@"remarkmsg" withValue:remarkmsg];
        [self addParam:@"cards_id" withValue:card_id];

    }];
}

//订单详情
- (void)getOrderdetail:(NSString *)orderid{
    
    [self sendPostWithURL:ORDER_DETAIL_API tag:Http_Orderdetail_Tag beforeRequest:^{
        [self addParam:@"orderid" withValue:orderid];
    }];
}


//支付宝完成后  修改订单状态
- (void)getConfim_alipay:(NSString *)co_id{
    [self sendPostWithURL:Confim_alipay_API tag:Http_Confim_alipay_Tag beforeRequest:^{
        [self addParam:@"co_id" withValue:co_id];
    }];

}

//联动支付完成后  修改订单状态
- (void)getLinkageconfirmpay:(NSString *)co_id{

    [self sendPostWithURL:Linkageconfirmpay_API tag:Http_Linkageconfirmpay_Tag beforeRequest:^{
        [self addParam:@"co_id" withValue:co_id];
    }];
}

//取消订单
- (void)getCancelorder:(NSString *)ordered{
    [self sendPostWithURL:ORDER_CANCEL_API tag:Http_CancelOrder_Tag beforeRequest:^{
        [self addParam:@"ordered" withValue:ordered];
    }];
}


//商品详情评价
- (void)getShowcomment:(NSString *)goodsid andPage:(NSString *)page andPer_page:(NSString *)per_page{
    [self sendPostWithURL:SHOUCOMMENT_API tag:Http_Showcomment_Tag beforeRequest:^{
        [self addParam:@"goodsid" withValue:goodsid];
        [self addParam:@"pageno" withValue:page];
        [self addParam:@"per_page" withValue:per_page];
    }];
}

//获取评价
- (void)getCheckComment:(NSString *)goodsid andCo_id:(NSString *)co_id{
    [self sendPostWithURL:CheckCommet_API tag:Http_CheckCommet_Tag beforeRequest:^{
        [self addParam:@"co_id" withValue:co_id];
    }];
}

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
                   andContent:(NSString *)content
{
    [self sendPostWithURL:Addcomment_AAPI tag:Http_addcomment_Tag beforeRequest:^{
        [self addParam:@"product_id" withValue:product_id];
        [self addParam:@"goods_id" withValue:goods_id];
        [self addParam:@"co_id" withValue:co_id];
        [self addParam:@"score0" withValue:score0];
        [self addParam:@"score1" withValue:score1];
        [self addParam:@"score2" withValue:score2];
        [self addParam:@"score3" withValue:score3];
        [self addParam:@"score4" withValue:score4];
        [self addParam:@"score5" withValue:score5];
        [self addParam:@"content" withValue:content];
    }];
}

//评论整个订单
- (void)getAddOrdercomments:(NSString *)comms
                      co_id:(NSString *)coid
                  andScore0:(NSString *)score0
                  andScore1:(NSString *)score1
                  andScore2:(NSString *)score2
                  anonymous:(NSString *)anony{
    
    
    [self sendPostWithURL:Addcomment_AAPI tag:Http_addcomment_Tag beforeRequest:^{
        [self addParam:@"comments" withValue:comms];
        [self addParam:@"co_id" withValue:coid];
        [self addParam:@"score0" withValue:score0];
        [self addParam:@"score1" withValue:score1];
        [self addParam:@"score2" withValue:score2];
        [self addParam:@"anonymous" withValue:anony];
    }];
}


//套装详情
- (void)getSuitinfo:(NSString *)suitinfo{
    [self sendPostWithURL:PRODUCTSUITINFO tag:Http_SuitInfo_Tag beforeRequest:^{
        [self addParam:@"suitid" withValue:suitinfo];
    }];
}

// * 添加套装到购物车
- (void)getAddsuittocar:(NSString *)sku andSuitid:(NSString *)suitid {
    
    [self sendPostWithURL:ADD_SUIT_TO_CART tag:Http_Addsuittocar_Tag beforeRequest:^{
        [self addParam:@"sku" withValue:suitid];
        [self addParam:@"suitid" withValue:sku];
    }];
}

//绑定优惠券
- (void)addCouponcard:(NSString *)card_id
{
    [self sendPostWithURL:ADDCOUPONCARD tag:Http_addCouponcard_Tag beforeRequest:^{
        [self addParam:@"couponcard" withValue:card_id];
    }];
}

//积分兑换记录
- (void)getexchangescorerecord:(NSString *)card_id{
    
    [self sendPostWithURL:@"getexchangescorerecord" tag:Http_getexchangescorerecord_Tag beforeRequest:^{
        [self addParam:@"card_id" withValue:card_id];
    }];
}

 //优惠卡列表接口
- (void)getCouponcardListWithPage:(NSString *)page andPer_page:(NSString *)per_page{
    [self sendPostWithURL:COUPONCARD_LIST tag:Http_CoupncardList_Tag beforeRequest:^{
        [self addParam:@"page" withValue:page];
        [self addParam:@"per_page" withValue:per_page];

    }];
}

//积分兑换接口
- (void)exchangecoupon:(NSString *)card_id{
    [self sendPostWithURL:EXCHANGECOUPON tag:Http_exchangecoupon_Tag beforeRequest:^{
        [self addParam:@"card_id" withValue:card_id];
    }];
}


//使用尊享卡接口
- (void)usev6card:(NSString *)cardId mobile:(NSString *)mobile checkcode:(NSString *)checkcode{

    [self sendPostWithURL:USEV6CARD_API tag:Http_usev6card_Tag beforeRequest:^{
        [self addParam:@"card_id" withValue:cardId];
        [self addParam:@"mobile" withValue:mobile];
        [self addParam:@"checkcode" withValue:checkcode];

    }];
}

//完善资料 发送验证码
- (void)getAchievecode:(NSString *)phonenum {

    [self sendPostWithURL:Achievecode_API tag:Http_addCouponcard_Tag beforeRequest:^{
        [self addParam:@"mobile" withValue:phonenum];
    }];
}

//处理申请会员信息
- (void)getDealapplyZunxiang:(NSString *)zunxiang andKey:(NSString *)key andName:(NSString *)name andSex:(NSString *)sex andNick_Name:(NSString *)nick_name andMobile:(NSString *)mobile andAk_Height_1:(NSString *)ak_height_1 andAk_Height_2:(NSString *)ak_height_2 andCheckcode:(NSString *)checkcode andAk1_Year:(NSString *)ak1_Year andAk1_Month:(NSString *)ak1_Month andAk1_Day:(NSString *)ak1_Day andAk2_Year:(NSString *)ak2_Year andAk2_Month:(NSString *)ak2_Month andAk2_Day:(NSString *)ak2_Day andAk_Name_1:(NSString *)ak_name_1 andAk_Name_2:(NSString *)ak_name_2 andV6User_Year:(NSString *)v6user_Year andV6User_Month:(NSString *)v6user_Month andV6User_Day:(NSString *)v6user_Day andAk_Sex_1:(NSString *)ak_sex_1 andAk_Sex_2:(NSString *)ak_sex_2 andAddress:(NSString *)address andEmail:(NSString *)email andZipcode:(NSString *)zipcode andAge:(NSString *)age andIncome:(NSString *)income andProfession:(NSString *)profession andBrasize:(NSString *)brasize andUnderpants:(NSString *)underpants andClothsize:(NSString *)clothsize{

    [self sendPostWithURL:Dealapply_API tag:Http_Dealapply_Tag beforeRequest:^{
        [self addParam:@"zunxiang" withValue:zunxiang];
        [self addParam:@"key" withValue:key];
        [self addParam:@"name" withValue:name];
        [self addParam:@"sex" withValue:sex];
        [self addParam:@"nick_name" withValue:nick_name];
        [self addParam:@"ak_height_1" withValue:ak_height_1];
        [self addParam:@"ak_height_2" withValue:ak_height_2];
        [self addParam:@"checkcode" withValue:checkcode];
        [self addParam:@"ak1_Year" withValue:ak1_Year];
        [self addParam:@"ak1_Month" withValue:ak1_Month];
        [self addParam:@"ak1_Day" withValue:ak1_Day];
        [self addParam:@"ak2_Year" withValue:ak2_Year];
        [self addParam:@"ak2_Month" withValue:ak2_Month];
        
        [self addParam:@"ak2_Day" withValue:ak2_Day];
        [self addParam:@"ak_name_1" withValue:ak_name_1];
        [self addParam:@"ak_name_2" withValue:ak_name_2];
        [self addParam:@"v6user_Year" withValue:v6user_Year];

        [self addParam:@"v6user_Month" withValue:v6user_Month];
        [self addParam:@"v6user_Day" withValue:v6user_Day];
        [self addParam:@"ak_sex_1" withValue:ak_sex_1];
        [self addParam:@"ak_sex_2" withValue:ak_sex_2];
        [self addParam:@"address" withValue:address];

        [self addParam:@"email" withValue:email];
        [self addParam:@"zipcode" withValue:zipcode];
        [self addParam:@"age" withValue:age];
        [self addParam:@"income" withValue:income];
        [self addParam:@"profession" withValue:profession];

        [self addParam:@"brasize" withValue:brasize];
        [self addParam:@"underpants" withValue:underpants];
        [self addParam:@"clothsize" withValue:clothsize];
    }];
}

//领取优惠券界面~
- (void)getGetscoupon:(NSString *)couponed{
    [self sendPostWithURL:GETSCOUPON_API tag:Http_Getscoupon_Tag beforeRequest:^{
        [self addParam:@"couponid" withValue:couponed];
    }];
}

//领取优惠券~
- (void)getGetscouponup:(NSString *)couponid{
    [self sendPostWithURL:GETSCOUPONUP_API tag:Http_Getscouponup_Tag beforeRequest:^{
        [self addParam:@"couponid" withValue:couponid];
    }];
}

//查找物流
- (void)getLogistics:(NSString *)expressed andDelivery_type:(NSString *)delivery_type{

    [self sendPostWithURL:LOGISTICS_API tag:Http_Logistics_Tag beforeRequest:^{
        [self addParam:@"expressid" withValue:expressed];
        [self addParam:@"delivery_type" withValue:delivery_type];
    }];
}

//lee999recode上传头像
- (void)getUpLoadface:(NSData *)Filedata{
    
    self.isuploadDATA = YES;
    
    [self sendPostWithURL:Uploadface_API tag:Http_Uploadface_Tag beforeRequest:^{
        [self addParam:@"Filedata" withValue:Filedata];
    }];
}

/*
 *版本检查 tag Http_Version_Tag
*/
- (void)getappVersion{
    [self sendPostWithURL:VERSION_API tag:Http_Version_Tag beforeRequest:^{
    }];
}


//确认收货
- (void)makesuregetgood:(NSString*)goodid{
    [self sendPostWithURL:Makesuregetgood_API tag:Http_Makesuregetgood_Tag beforeRequest:^{
        [self addParam:@"co_id" withValue:goodid];
    }];
}

//获取银联交易号
-(void)upmpTradno:(NSString*)aorderid{
    [self sendPostWithURL:UpmpTradno_API tag:Http_TrdnoByOrderld_Tag beforeRequest:^{
        [self addParam:@"orderid" withValue:aorderid];
    }];
}



//lee999 200版本开发

- (void)getHomePage20data{
    [self sendPostWithURL:@"home20" tag:Http_Homepage20_Tag beforeRequest:^{
    }];
}


- (void)getSort20data{
    [self sendPostWithURL:@"catelist" tag:Http_Sort20_Tag beforeRequest:^{
    }];
}

- (void)getMageinzeList20datawithTpye:(NSString*)atype{
    [self sendPostWithURL:@"magazinelist" tag:Http_MageinzeList20_Tag beforeRequest:^{
        //type :  儿童/女士/搭配/男士/全部
        if ([atype description].length < 1) {
        }else{
            [self addParam:@"type" withValue:atype];
        }
    }];
}


- (void)getMageinzeDetail20data:(NSString*)mageinzeid{
    [self sendPostWithURL:@"magazineinfo" tag:Http_MageinzeDetail20_Tag beforeRequest:^{
        //magazine_id :  杂志ID
        [self addParam:@"magazine_id" withValue:mageinzeid];

        
    }];
}


- (void)getStoreList20data{
    [self sendPostWithURL:@"store" tag:Http_StoreList20_Tag beforeRequest:^{
    }];
}


- (void)getStoreDetail20data{
    [self sendPostWithURL:@"storeinfo" tag:Http_StoreDetail20_Tag beforeRequest:^{
        //store_id : 门店ID
        
    }];
}

//收藏夹列表！！！
- (void)getFavorite20data{
    [self sendPostWithURL:@"favorite" tag:Http_Favorite20_Tag beforeRequest:^{
        //type : “good”   //类型 包括 good,store, magazine
        
    }];
}

//获取我的爱慕页面更多推荐的信息
- (void)getMoreMyAimer20data{
    [self sendPostWithURL:@"more" tag:Http_MoreMyAimer20_Tag beforeRequest:^{
    }];
}


////品牌馆详情  最新版本   tag 209
-(void)getBrandDetail20:(NSString*)brandID{
    [self sendPostWithURL:Branddetail20_API tag:Http_Branddetail20_Tag beforeRequest:^{
        [self addParam:@"brandName" withValue:brandID];
    }];
}



//新版本收藏夹列表  tag210
-(void)getFavListnew20:(NSString *)page andPer_page:(NSString *)per_page andtype:(NSString*)atype{
    
    [self sendPostWithURL:FAVORITE_API tag:Http_Favorite20_Tag beforeRequest:^{
        [self addParam:@"page" withValue:page];
        [self addParam:@"per_page" withValue:per_page];
        [self addParam:@"type" withValue:atype];
        
    }];
}

//获取注册时候的验证码
- (void)getRegisterVerifycode:(NSString *)mobile{
    [self sendPostWithURL:@"sendachievecode" tag:Http_GetRegisterVerifycode_Tag beforeRequest:^{
        [self addParam:@"mobile" withValue:mobile];
    }];
}


//获取私人衣橱2 的数据
-(void)getCloset2Data:(NSString*)strtype{
    
    [self sendPostWithURL:@"wardrobe" tag:Http_wardrobe_Tag beforeRequest:^{
        [self addParam:@"type" withValue:strtype];
    }];
}



-(void)getPackageInfoWithPid:(NSString*)pid
{
    [self sendPostWithURL:@"packageinfo" tag:Http_PackageInfo20_Tag beforeRequest:^{
        [self addParam:@"package_id" withValue:pid];
    }];
}

- (void)getCouponcardList20WithPage:(NSString *)page andPer_page:(NSString *)per_page andType:(NSString*)type{
    [self sendPostWithURL:CouponList20 tag:Http_CouponList20_Tag beforeRequest:^{
        [self addParam:@"page" withValue:page];
        [self addParam:@"per_page" withValue:per_page];
        [self addParam:@"type" withValue:type];
    }];
}

- (void)addPackageToCartWithData:(NSArray*)data andPid:(NSString*)pid_
{
    NSMutableArray* marrData = [NSMutableArray arrayWithCapacity:1];
    for (NSDictionary* dic in data) {
        [marrData addObject:[[dic allKeys] firstObject]];
    }
    [self sendPostWithURL:@"addpackagetoshopcart" tag:Http_AddPackageToCart20_Tag beforeRequest:^{
        [self addParam:@"package_id" withValue:pid_];
        [self addParam:@"product_id" withValue:[marrData componentsJoinedByString:@"|"]];
        [self addParam:@"number" withValue:@"1"];
    }];
}
@end






