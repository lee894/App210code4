//
//  ModelManager.m
//  所有model的缓存，并带有解析所有model的方法
//
//  Created by lee on 14-4-4.
//  Copyright (c) 2014年 eastedge. All rights reserved.
//

#import "ModelManager.h"
#import "NSString+SBJSON.h"
#import "CommModel.h"

#import "MYMacro.h"


#define kMaxTag 111

@implementation ModelManager

+ (id)sharedModelManager
{
    static dispatch_once_t pred;
    static ModelManager *modelManager = nil;
    
    dispatch_once(&pred, ^{ modelManager = [[self alloc] init]; });
    return modelManager;
}


/* - (id)init */
//
- (id)init
{
    self = [super init];
    if (self) {
        _isClearCache = YES;
    }
    return self;
}

- (void)setModel:(LBaseModel *)model WithTag:(int)tag
{
    switch (tag) {
        case 101:
        {
            [[ModelManager sharedModelManager] setLoginModel:(LoginLoginModel *)model];
        }
            break;
        default:
            break;
    }
}


/*
 字典转对象
 */
+ (LBaseModel *)parseModelWithDictionary:(NSDictionary *)jsonDic
                                    tag:(int)tag
{
    NSString *messageStr = [jsonDic objectForKey:@"response"];
    
    NSDictionary *messageDic = [jsonDic objectForKey:@"error"];
    
    //    返回错误数据
    if ([messageStr isEqualToString:@"error"]) {
        
        LBaseModel *model = [[LBaseModel alloc] initWithResult:messageStr requestTag:10086 andErrorMessage:messageDic];
        
        NSLog(@"%@", model.errorMessage);
        
        return model;
    }
    
    /*开始解析model*/
    switch (tag) {
        case Http_Main_Tag: /*App首页*/
        {
            MainMainModel *mainModel = [MainMainModel modelObjectWithDictionary:jsonDic];
            [mainModel setRequestTag:Http_Main_Tag];
            [[ModelManager sharedModelManager] setMainModel:mainModel];
            return mainModel;
        }
            break;
        case Http_Scan_Tag: /*扫描*/
        {
            ScanModel *loginModel = [ScanModel modelObjectWithDictionary:jsonDic];
            [loginModel setRequestTag:Http_Scan_Tag];
            return loginModel;
        }
            break;
        case Http_Brandtrend_Tag: /*潮流新品*/
        {
            ChaoliuChaoliuxinpinModel *chaoliuModel = [ChaoliuChaoliuxinpinModel modelObjectWithDictionary:jsonDic];
            [chaoliuModel setRequestTag:Http_Brandtrend_Tag];
            [[ModelManager sharedModelManager] setChaoliuChaoliuxinpinModel:chaoliuModel];
            return chaoliuModel;
        }
            break;
            
        case Http_Alipaylogin_Tag: //支付宝登录
        case Http_whchatLogin_Tag: //微信登录
        case Http_Login_Tag: /*登录*/
        {
            LoginLoginModel *loginModel = [LoginLoginModel modelObjectWithDictionary:jsonDic];
            [loginModel setRequestTag:Http_Login_Tag];
            [[ModelManager sharedModelManager] setLoginModel:loginModel];
            return loginModel;
        }
            break;
        case Http_Qqcallback_Tag: /*qq登录*/
        {
            LoginLoginModel *loginModel = [LoginLoginModel modelObjectWithDictionary:jsonDic];
            [loginModel setRequestTag:Http_Login_Tag];
            [[ModelManager sharedModelManager] setLoginModel:loginModel];
            return loginModel;
        }
            break;
        case Http_Wangyicallback_Tag: //网易登录
        case Http_Sinaweibo_Tag: /*新浪登录*/
        {
            LoginLoginModel *loginModel = [LoginLoginModel modelObjectWithDictionary:jsonDic];
            [loginModel setRequestTag:Http_Sinaweibo_Tag];
            [[ModelManager sharedModelManager] setLoginModel:loginModel];
            return loginModel;
        }
            break;
        case Http_Active_Tag: /*激活*/
        {
            ActiveModel *activeModel = [ActiveModel modelObjectWithDictionary:jsonDic];
             [[NSUserDefaults standardUserDefaults] setValue:activeModel.response forKey:@"unique"];
            [activeModel setRequestTag:Http_Active_Tag];
            [[ModelManager sharedModelManager] setActiveModel:activeModel];
            return activeModel;
        }
            break;
        case Http_Home_Tag: /*主页*/
        {
            HomeHomeModel *homeModel = [HomeHomeModel modelObjectWithDictionary:jsonDic];
            [homeModel setRequestTag:Http_Home_Tag];
            //            [[ModelManager sharedModelManager] setHomeModel:HomeHomeModel];
            return homeModel;
        }
            break;
        case Http_Categories_Tag: /*分类列表*/
        {
            CategoriesModel *categoriesModel = [CategoriesModel modelObjectWithDictionary:jsonDic];
            [categoriesModel setRequestTag:Http_Categories_Tag];
            [[ModelManager sharedModelManager] setCategoriesModel:categoriesModel];
            return categoriesModel;
        }
            break;
        case Http_Brands_Tag: /*品牌列表*/
        {
            BrandsModel *brandsModel = [BrandsModel modelObjectWithDictionary:jsonDic];
            [brandsModel setRequestTag:Http_Brands_Tag];
            [[ModelManager sharedModelManager] setBrandsModel:brandsModel];
            return brandsModel;
        }
            break;
        case Http_Productlist_Tag: /*商品列表*/
        {
            BrandsProductListModel *productlistdModel = [BrandsProductListModel modelObjectWithDictionary:jsonDic];
            [productlistdModel setRequestTag:Http_Productlist_Tag];
            [[ModelManager sharedModelManager] setBrandsProductListModel:productlistdModel];
            return productlistdModel;
        }
            break;
        case Http_Product_Tag: /*商品详情*/
        {
            ProductProductDetailModel *productlistModel = [ProductProductDetailModel modelObjectWithDictionary:jsonDic];
            [productlistModel setRequestTag:Http_Product_Tag];
            [[ModelManager sharedModelManager] setProductProductDetailModel:productlistModel];
            return productlistModel;
        }
            break;
        case Http_Channelcate_Tag: /*频道专区主页#import "CannelCannelHomeModel.h"*/
        {
            CannelCannelHomeModel *productlistModels = [CannelCannelHomeModel modelObjectWithDictionary:jsonDic];
            [productlistModels setRequestTag:Http_Channelcate_Tag];
            //                      [[ModelManager sharedModelManager] setProductlistModel:productlistModels];
            return productlistModels;
        }
            break;
        case Http_Car_Tag: /*购物车*/
        {
            CarCarModel *carModel = [CarCarModel modelObjectWithDictionary:jsonDic];
            [carModel setRequestTag:Http_Car_Tag];
            [[ModelManager sharedModelManager] setCarModel:carModel];
            return carModel;
        }
            break;
        case Http_Checkout_Tag: /*结算中心*/
        {
            COCheckOutModel *acheckOutModel = [COCheckOutModel modelObjectWithDictionary:jsonDic];
            [acheckOutModel setRequestTag:Http_Checkout_Tag];
            [[ModelManager sharedModelManager] setMyCheckOutModel:acheckOutModel];
            return acheckOutModel;
        }
            break;
        case Http_Check_couponcard_Tag: /*验证优惠劵是否有效*/
        {
            CarCarModel *carModel = [CarCarModel modelObjectWithDictionary:jsonDic];
            [carModel setRequestTag:Http_Check_couponcard_Tag];
            [[ModelManager sharedModelManager] setCarModel:carModel];
            return carModel;
        }
            break;
        case Http_Submitorder_Tag: /* 提交订单 */
        {
            SubmitOrderSubmitOrderModel *carModel = [SubmitOrderSubmitOrderModel modelObjectWithDictionary:jsonDic];
            [carModel setRequestTag:Http_Submitorder_Tag];
            return carModel;
        }
            break;
        case Http_Addresslist_Tag: /*地址列表*/
        {
            AddressAddressLIstModel *addressModel = [AddressAddressLIstModel modelObjectWithDictionary:jsonDic];
            [addressModel setRequestTag:Http_Addresslist_Tag];
            [[ModelManager sharedModelManager] setAddressAddressLIstModel:addressModel];
            return addressModel;
        }
            break;
        case Http_Favorite_Tag: /*收藏夹列表*/
        {
            FavoriteFavoriteModel *favoriteModel = [FavoriteFavoriteModel modelObjectWithDictionary:jsonDic];
            [favoriteModel setRequestTag:Http_Favorite_Tag];
            [[ModelManager sharedModelManager] setFavoriteFavoriteModel:favoriteModel];
            return favoriteModel;
        }
            break;
        case Http_Orders_Tag: /*订单列表*/
        {
            OrdersOrdersModel *orderModel = [OrdersOrdersModel modelObjectWithDictionary:jsonDic];
            [orderModel setRequestTag:Http_Orders_Tag];
            [[ModelManager sharedModelManager] setOrdersOrdersModel:orderModel];
            return orderModel;
        }
            break;
        case Http_Orderdetail_Tag: /*订单详情*/
        {
            OrderInfoOrderInfoModel *orderDetail = [OrderInfoOrderInfoModel modelObjectWithDictionary:jsonDic];
            [orderDetail setRequestTag:Http_Orderdetail_Tag];
            [[ModelManager sharedModelManager] setOrderInfoOrderInfoModel:orderDetail];
            return orderDetail;
        }
            break;
        case Http_More_Tag: /*获取我的爱慕页面更多推荐的信息*/
        {
            MoerMoreModel *moreModel = [MoerMoreModel modelObjectWithDictionary:jsonDic];
            [moreModel setRequestTag:Http_More_Tag];
            [[ModelManager sharedModelManager] setMoerMoreModel:moreModel];
            return moreModel;
        }
            break;
        case Http_Version_Tag: /*版本检查*/
        {
            
            VersionVersionModel *carModel = [VersionVersionModel modelObjectWithDictionary:jsonDic];
            [carModel setRequestTag:Http_Version_Tag];
            return carModel;
        }
            break;
        case Http_Register_Tag: /*注册*/
        {
            LoginLoginModel *registModel = [LoginLoginModel modelObjectWithDictionary:jsonDic];
            [registModel setRequestTag:Http_Register_Tag];
            [[ModelManager sharedModelManager] setRegistModel:registModel];
            return registModel;
        }
            break;
        case Http_Productionfo_Tag: /*更新商品信息*/
        {
            CarCarModel *carModel = [CarCarModel modelObjectWithDictionary:jsonDic];
            [carModel setRequestTag:Http_Productionfo_Tag];
            [[ModelManager sharedModelManager] setCarModel:carModel];
            return carModel;
        }
            break;
        case Http_Logout_Tag: /*登出*/
        {
            //LBaseModel *loginOutModel = [[LBaseModel alloc] initWithRequestTag:Http_Logout_Tag];
            CommModel *loginOutModel = [[CommModel alloc] init];
            loginOutModel.requestTag = Http_Logout_Tag;
            //[loginOutModel setRequestTag:Http_Logout_Tag];

            return loginOutModel;
        }
            break;
        case Http_Findpasswordup_Tag: /*找回密码(发送验证码)*/
        {
            FindPasswordFindPasswordModel *passwordModel = [FindPasswordFindPasswordModel modelObjectWithDictionary:jsonDic];
            [passwordModel setRequestTag:Http_Findpasswordup_Tag];
            return passwordModel;
        }
            break;
        case Http_Resetpassup_Tag: /*找回密码(提交)*/
        {
            ResetpassupResetpassupModel *resetModel = [ResetpassupResetpassupModel modelObjectWithDictionary:jsonDic];
            [resetModel setRequestTag:Http_Resetpassup_Tag];
            return resetModel;
        }
            break;
        case Http_Car_add_Tag: /*添加到购物车*/
        {
            CarCarModel *carModel = [CarCarModel modelObjectWithDictionary:jsonDic];
            [carModel setRequestTag:Http_Car_add_Tag];
            [[ModelManager sharedModelManager] setCarModel:carModel];
            return carModel;
        }
            break;
        case Http_Addsuittocar_Tag: /*添加套装到购物车*/
        {
            CarCarModel *carModel = [CarCarModel modelObjectWithDictionary:jsonDic];
            [carModel setRequestTag:Http_Addsuittocar_Tag];
            [[ModelManager sharedModelManager] setCarModel:carModel];
            return carModel;
        }
            break;
        case Http_EditCar_Tag: /*修改购物车*/
        {
            CarCarModel *carModel = [CarCarModel modelObjectWithDictionary:jsonDic];
            [carModel setRequestTag:Http_EditCar_Tag];
            [[ModelManager sharedModelManager] setCarModel:carModel];
            return carModel;
        }
            break;
        case Http_Editsuittocar_Tag: /*修改购物车中的套装*/
        {
            CarCarModel *carModel = [CarCarModel modelObjectWithDictionary:jsonDic];
            [carModel setRequestTag:Http_Editsuittocar_Tag];
            [[ModelManager sharedModelManager] setCarModel:carModel];
            return carModel;
        }
            break;
        case Http_Suittocart_deletes_Tag: /*删除购物车中的套装*/
        {
            CarCarModel *carModel = [CarCarModel modelObjectWithDictionary:jsonDic];
            [carModel setRequestTag:Http_Suittocart_deletes_Tag];
            [[ModelManager sharedModelManager] setCarModel:carModel];
            return carModel;
        }
            break;
        case Http_Delcar_Tag: /*从购物车删除 */
        {
            CarCarModel *carModel = [CarCarModel modelObjectWithDictionary:jsonDic];
            [carModel setRequestTag:Http_Delcar_Tag];
            [[ModelManager sharedModelManager] setCarModel:carModel];
            return carModel;
        }
            break;
            
        case Http_Logistics_Tag: /*查看物流*/
        {
            LookCheckLookCheckModel *lookCheckModel = [LookCheckLookCheckModel modelObjectWithDictionary:jsonDic];
            [lookCheckModel setRequestTag:Http_Logistics_Tag];
            return lookCheckModel;
        }
         break;
       case Http_AddressEdit_Tag: /*修改地址*/
       {
           AddressAdd *carModel = [AddressAdd modelObjectWithDictionary:jsonDic];
           [carModel setRequestTag:Http_AddressEdit_Tag];
           return carModel;
       }
           break;
//        case Http_AddressDel_Tag: /*删除地址*/
//        {
//            CarModel *carModel = [CarModel modelObjectWithDictionary:jsonDic];
//            [carModel setRequestTag:Http_AddressDel_Tag];
//            [[ModelManager sharedModelManager] setCarModel:carModel];
//            return carModel;
//        }
            break;
            
        case Http_Addressadd_Tag:  /*新增地址*/
        {
            AddressAdd *noticeModel = [AddressAdd modelObjectWithDictionary:jsonDic];
            [noticeModel setRequestTag:Http_Addressadd_Tag];
            return noticeModel;
        }
            break;
        case Http_FavoriteAdd_Tag: /*添加到收藏夹*/
        {
//            LBaseModel *favoriteModel = [LBaseModel modelObjectWithDictionary:jsonDic];
            CommModel *favoriteModel = [[CommModel alloc] init];
            [favoriteModel setRequestTag:Http_FavoriteAdd_Tag];
            return favoriteModel;
        }
            break;
        case Http_FavoriteDel_Tag: /*从收藏夹删除*/
        {
//            LBaseModel *FavoriteDelModle = [[LBaseModel alloc] initWithRequestTag:Http_FavoriteDel_Tag];
            CommModel *FavoriteDelModle = [[CommModel alloc] init];
            [FavoriteDelModle setRequestTag:Http_FavoriteDel_Tag];
            return FavoriteDelModle;
        }
            break;
        case Http_CancelOrder_Tag: /*取消订单*/
        {
//            LBaseModel *cancelOrderModle = [[LBaseModel alloc] initWithRequestTag:Http_CancelOrder_Tag];
            CommModel *cancelOrderModle = [[CommModel alloc] init];
            [cancelOrderModle setRequestTag:Http_CancelOrder_Tag];
            return cancelOrderModle;
        }
            break;
        case Http_NoticeList_Tag: /*消息列表*/
        {
            NoticeListNoticeListModel *carModel = [NoticeListNoticeListModel modelObjectWithDictionary:jsonDic];
            [carModel setRequestTag:Http_NoticeList_Tag];
            //            [[ModelManager sharedModelManager] setCarModel:carModel];
            return carModel;
        }
            break;
            //        case Http_NoticeList_Tag: /*消息列表*/
            //        {
            //            CarModel *carModel = [CarModel modelObjectWithDictionary:jsonDic];
            //            [carModel setRequestTag:Http_NoticeList_Tag];
            //            [[ModelManager sharedModelManager] setCarModel:carModel];
            //            return carModel;
            //        }
            //            break;
        case Http_SuitList_Tag: /*套装列表*/
        {
            SuitListSuitListModel *carModel = [SuitListSuitListModel modelObjectWithDictionary:jsonDic];
            [carModel setRequestTag:Http_SuitList_Tag];
            //                [[ModelManager sharedModelManager] setCarModel:carModel];
            return carModel;
        }
            break;
         case Http_SuitInfo_Tag: /*套装详情*/
           {
           SuitServiceModel *carModel = [SuitServiceModel modelObjectWithDictionary:jsonDic];
           [carModel setRequestTag:Http_SuitInfo_Tag];
           return carModel;
           }
         break;
        case Http_FeedBack_Tag: /*意见反馈*/
        {
//            LBaseModel *feedBackModel = [[LBaseModel alloc] initWithRequestTag:Http_FeedBack_Tag];
            CommModel *feedBackModel = [[CommModel alloc] init];
            [feedBackModel setRequestTag:Http_FeedBack_Tag];
            return feedBackModel;
        }
            break;
            
        case Http_TrdnoByOrderld_Tag: /*银联支付流水号*/
        {
            CommModel *unpayTNModel = [[CommModel alloc] init];
            [unpayTNModel setRequestTag:Http_TrdnoByOrderld_Tag];
            return unpayTNModel;
        }break;
            
            //        case Http_Store_Tag: /*门店查询*/
            //        {
            //            CarModel *carModel = [CarModel modelObjectWithDictionary:jsonDic];
            //            [carModel setRequestTag:Http_Store_Tag];
            //            [[ModelManager sharedModelManager] setCarModel:carModel];
            //            return carModel;
            //        }
            //            break;
        case Http_Magazine_Tag: /*杂志*/
        {
            MagazineMagazineModel *magazineModel = [MagazineMagazineModel modelObjectWithDictionary:jsonDic];
            [magazineModel setRequestTag:Http_Magazine_Tag];
            [[ModelManager sharedModelManager] setMagazineMagazineModel:magazineModel];
            return magazineModel;
        }
        case Http_Store_Tag: /*门店查询*/
        {
            StoresStoresModel *storesModel = [StoresStoresModel modelObjectWithDictionary:jsonDic];
            [storesModel setRequestTag:Http_Store_Tag];
            [[ModelManager sharedModelManager] setStoresStoresModel:storesModel];
            return storesModel;
        }
            break;
            //
        case Http_Getscoupon_Tag: /*领卷页面*/
        {
            GetscouponModel *getscouponModel = [GetscouponModel modelObjectWithDictionary:jsonDic];
            [getscouponModel setRequestTag:Http_Getscoupon_Tag];
//            [[ModelManager sharedModelManager] setGetscouponModel:getscouponModel];
            return getscouponModel;
        }
            break;
        case Http_setv6user_Tag: /*门店激活*/
        {
            SetSetVUserModel *userModel = [SetSetVUserModel modelObjectWithDictionary:jsonDic];
            [userModel setRequestTag:Http_setv6user_Tag];
            return userModel;
        }
            break;
        case Http_v6userlogin_Tag: /*门店激活*/
        {
            VuserLoginVuserLoginModel *vuserModel = [VuserLoginVuserLoginModel modelObjectWithDictionary:jsonDic];
            [vuserModel setRequestTag:Http_v6userlogin_Tag];
            return vuserModel;
        }
            break;
        case Http_addcomment_Tag: /*提交评价*/
        {
            CodeBindBindCodeModel *addCommentModel = [CodeBindBindCodeModel modelObjectWithDictionary:jsonDic];
            [addCommentModel setRequestTag:Http_addcomment_Tag];
            return addCommentModel;
        }
            break;
        case Http_Bindmobile_Tag: /*绑定手机*/
        {
            BindBindModel *bindModel = [BindBindModel modelObjectWithDictionary:jsonDic];
            [bindModel setRequestTag:Http_Bindmobile_Tag];
            return bindModel;
        }
            break;
        case Http_provemobile_Tag:
        case Http_Sendcodes_Tag: /*发送验证码*/
        {
            CodeBindBindCodeModel *bindCodeModel =[CodeBindBindCodeModel modelObjectWithDictionary:jsonDic];
            [bindCodeModel setRequestTag:Http_Sendcodes_Tag];
            return bindCodeModel;
        }
            break;
            
        case Http_Brandzixun_Tag: /*品牌咨询*/
        {
            ZixunZixunZixunInfoModel *zixunModel = [ZixunZixunZixunInfoModel modelObjectWithDictionary:jsonDic];
            [zixunModel setRequestTag:Http_Brandzixun_Tag];
//            [[ModelManager sharedModelManager] setZixunZixunInfoModel:zixunModel];
            return zixunModel;
        }
            break;
        case Http_Search_Tag: /*搜索页面*/
        {
            SearchSearchHotModel *searchModel = [SearchSearchHotModel modelObjectWithDictionary:jsonDic];
            [searchModel setRequestTag:Http_Search_Tag];
            //            [[ModelManager sharedModelManager] setZixunZixunInfoModel:zixunModel];
            return searchModel;
        }
            break;
        case Http_CheckCommet_Tag: /*我要评价*/
        {
            AssessAssessModel *accessModel = [AssessAssessModel modelObjectWithDictionary:jsonDic];
            [accessModel setRequestTag:Http_CheckCommet_Tag];
            return accessModel;
        }
            break;
        case Http_CoupncardList_Tag: /*优惠卡列表接口*/
        {
            CouponcardListCouponcardListModel *couponcardListModel = [CouponcardListCouponcardListModel modelObjectWithDictionary:jsonDic];
            [couponcardListModel setRequestTag:Http_CoupncardList_Tag];
            //            [[ModelManager sharedModelManager] setZixunZixunInfoModel:zixunModel];
            return couponcardListModel;
        }
            break;
        case Http_usev6card_Tag:/*使用会员卡接口*/
        {
            Usev6cardusev6cardModel *couponcardListModel = [Usev6cardusev6cardModel modelObjectWithDictionary:jsonDic];
            [couponcardListModel setRequestTag:Http_usev6card_Tag];
            return couponcardListModel;
        }
            break;
        case Http_addCouponcard_Tag://绑定优惠券
        {
            
            ChengeMyInfo *noticeModel = [ChengeMyInfo modelObjectWithDictionary:jsonDic];
            [noticeModel setRequestTag:Http_addCouponcard_Tag];
            return noticeModel;
        }
            break;
        case Http_exchangecoupon_Tag://积分兑换
        {
//            LBaseModel *feedBackModel = [[LBaseModel alloc] initWithRequestTag:Http_exchangecoupon_Tag];
            CommModel *feedBackModel = [[CommModel alloc] init];
            [feedBackModel setRequestTag:Http_exchangecoupon_Tag];
            return feedBackModel;
        }
            break;
        case Http_getexchangescorerecord_Tag://积分兑换记录
        {
            GetexchangescorerecordGetModel *model = [GetexchangescorerecordGetModel modelObjectWithDictionary:jsonDic];
            [model setRequestTag:Http_getexchangescorerecord_Tag];
            return model;
        }
            break;
        case Http_CheckOfflineMobile_Tag: /*是否线下会员*/
        {
            CheckCheckOffineMobile *offineModel = [CheckCheckOffineMobile modelObjectWithDictionary:jsonDic];
            [offineModel setRequestTag:Http_CheckOfflineMobile_Tag];
            return offineModel;
        }
            break;
        case Http_Notices_Tag:  /*公告详情*/
        {
            NoticesNoticesModel *noticeModel = [NoticesNoticesModel modelObjectWithDictionary:jsonDic];
            [noticeModel setRequestTag:Http_Notices_Tag];
            return noticeModel;
        }
            break;
        case Http_UpdatePwd_Tag:  /*修改密码*/
        {
            UpdatepwdupdatepwdModel *noticeModel = [UpdatepwdupdatepwdModel modelObjectWithDictionary:jsonDic];
            [noticeModel setRequestTag:Http_UpdatePwd_Tag];
            return noticeModel;
        }
            break;
        case Http_Selectgifts_Tag:  /*赠品列表*/
        {
            SelectGifesModel *noticeModel = [SelectGifesModel modelObjectWithDictionary:jsonDic];
            [noticeModel setRequestTag:Http_Selectgifts_Tag];
            return noticeModel;
        }
            break;
            
        case Http_INFO_Tag:  /*会员资料*/
        {
            InfoInfoModel *noticeModel = [InfoInfoModel modelObjectWithDictionary:jsonDic];
            [noticeModel setRequestTag:Http_INFO_Tag];
            return noticeModel;
        }
            break;
        case Http_Uploadface_Tag:  /*修改个人头像*/
        {
            LoginLoginModel *noticeModel = [LoginLoginModel modelObjectWithDictionary:jsonDic];
            [noticeModel setRequestTag:Http_Uploadface_Tag];
            return noticeModel;
        }
            break;
        case Http_EditInfo_Tag:  /*修改个人资料*/
        {
            ChengeMyInfo *noticeModel = [ChengeMyInfo modelObjectWithDictionary:jsonDic];
            [noticeModel setRequestTag:Http_EditInfo_Tag];
            return noticeModel;
        }
            break;
        case Http_Showcomment_Tag:  /*单品评价详*/
        {
            ShowcomMentModel *noticeModel = [ShowcomMentModel modelObjectWithDictionary:jsonDic];
            [noticeModel setRequestTag:Http_Showcomment_Tag];
            return noticeModel;
        }
            break;
            
        case Http_Branddetail_Tag:  /*品牌详情*/
        {
            BranddetailBranddetailModel *noticeModel = [BranddetailBranddetailModel modelObjectWithDictionary:jsonDic];
            [noticeModel setRequestTag:Http_Branddetail_Tag];
            return noticeModel;
        }
            break;
        case Http_Getscouponup_Tag:  /*领取优惠券*/
        {
            CounponupGetCounponupModel *noticeModel = [CounponupGetCounponupModel modelObjectWithDictionary:jsonDic];
            [noticeModel setRequestTag:Http_Getscouponup_Tag];
            return noticeModel;
        }
            break;
        case Http_Dealapply_Tag:  /*邀请入会*/
        {
            ChengeMyInfo *noticeModel = [ChengeMyInfo modelObjectWithDictionary:jsonDic];
            [noticeModel setRequestTag:Http_Dealapply_Tag];
            return noticeModel;
        }
            break;
        case Http_Clientinformation_Tag:  /*获取客户端信息*/
        {
            LBaseModel *noticeModel = [LBaseModel modelObjectWithDictionary:jsonDic];
            [noticeModel setRequestTag:Http_Clientinformation_Tag];
            return noticeModel;
        }
            break;
            
        case Http_Makesuregetgood_Tag:  /*确认收货*/
        {
            LBaseModel *noticeModel = [LBaseModel modelObjectWithDictionary:jsonDic];
            [noticeModel setRequestTag:Http_Makesuregetgood_Tag];
            return noticeModel;
        }
            break;
            
        case Http_GetRegisterVerifycode_Tag:
        {
            CommModel *cancelOrderModle = [[CommModel alloc] init];
            [cancelOrderModle setRequestTag:Http_GetRegisterVerifycode_Tag];
            return cancelOrderModle;
            
        }
            break;
            
            //lee999  200版本之后新增
//        case Http_Homepage20_Tag:  /*确认收货*/
//        {
//            NewHomeParser *home = [LBaseModel modelObjectWithDictionary:jsonDic];
//            [noticeModel setRequestTag:Http_Homepage20_Tag];
//            return noticeModel;
//        }
            break;
            
            

        default:
            return nil;
            break;
    }
    return nil;
}

+ (LBaseModel *)parseModelWithFaileResult:(NSString *)result
                                     tag:(int)tag
{
    LBaseModel *tempModel = [[LBaseModel alloc] initWithResult:result requestTag:tag andErrorMessage:@{@"text":@"请求超时"}];
    if([[ModelManager sharedModelManager] isClearCache])
    {
        [[ModelManager sharedModelManager] setModel:tempModel WithTag:tag];
    }
    return tempModel;
}


/*
 *
 * 字典转对象 测试版
 *
 */
+ (LBaseModel *)parseTestModelWithDictionary:(NSDictionary *)jsonDic
                                        tag:(int)tag
{
    if (jsonDic != nil) {
        return [ModelManager parseModelWithDictionary:jsonDic tag:tag];
    }
    
    NSString *homePath = NSHomeDirectory();
    NSString *documentsPath = [homePath stringByAppendingPathComponent:@"Documents"];
    NSString *tempJsonStr = [NSString stringWithContentsOfFile:[documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%d.txt",tag]] encoding:NSUTF8StringEncoding error:nil];
    jsonDic = [tempJsonStr JSONValue];
    return [ModelManager parseModelWithDictionary:jsonDic tag:tag];
}

- (void)clearCacheInMemory
{
    for (int i = 0; i < kMaxTag+1; i++) {
        [[ModelManager sharedModelManager] setModel:nil WithTag:i];
    }
}

@end
