//
//  ModelManager.h
//  所有model的缓存，并带有解析所有model的方法
//
//  Created by lee on 14-4-4.
//  Copyright (c) 2014年 eastedge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Usev6cardusev6cardModel.h"

#import "GetexchangescorerecordGetModel.h"

#import "LoginLoginModel.h"

#import "ActiveModel.h"

#import "ScanModel.h"

#import "HomeHomeModel.h"

#import "CategoriesModel.h"

#import "BrandsModel.h"

#import "CarCarModel.h"

#import "MainMainModel.h"

#import "GetscouponModel.h"

#import "COCheckOutModel.h"


#import "BrandsProductListModel.h"

#import "ChaoliuChaoliuxinpinModel.h"

#import "MoerMoreModel.h"

#import "AddressAddressLIstModel.h"

#import "ProductProductDetailModel.h"

#import "OrdersOrdersModel.h"

#import "FavoriteFavoriteModel.h"

#import "MagazineMagazineModel.h"

#import "OrderInfoOrderInfoModel.h"

#import "SearchSearchHotModel.h"

#import "SuitListSuitListModel.h"

#import "CouponcardListCouponcardListModel.h"

#import "StoresStoresModel.h"

#import "NoticeListNoticeListModel.h"

#import "FindPasswordFindPasswordModel.h"

#import "ResetpassupResetpassupModel.h"

#import "CannelCannelHomeModel.h"

#import "CodeBindBindCodeModel.h"

#import "SubmitOrderSubmitOrderModel.h"

#import "BindBindModel.h"

#import "AssessAssessModel.h"

#import "LookCheckLookCheckModel.h"

#import "CheckCheckOffineMobile.h"

#import "VersionVersionModel.h"

#import "SetSetVUserModel.h"

#import "NoticesNoticesModel.h"

#import "VuserLoginVuserLoginModel.h"

#import "SuitServiceModel.h"

#import "UpdatepwdupdatepwdModel.h"

#import "SelectGifesModel.h"

#import "InfoInfoModel.h"

#import "ChengeMyInfo.h"

#import "ShowcomMentModel.h"

#import "BranddetailBranddetailModel.h"

#import "ZixunZixunZixunInfoModel.h"

#import "CounponupGetCounponupModel.h"


#import "NewHomeParser.h"



@interface ModelManager : NSObject

@property (retain, nonatomic) GetscouponModel *GetscouponModel;

@property (retain, nonatomic) MainMainModel *MainModel;

@property (retain, nonatomic) LoginLoginModel *LoginModel;

@property (retain, nonatomic) ActiveModel *ActiveModel;

@property (retain, nonatomic) HomeHomeModel *HomeModel;

@property (retain, nonatomic) CategoriesModel *CategoriesModel;

@property (retain, nonatomic) BrandsModel *BrandsModel;

@property (retain, nonatomic) CarCarModel *CarModel;

@property (retain, nonatomic) LoginLoginModel *registModel;

@property (retain, nonatomic) COCheckOutModel *myCheckOutModel;


@property (retain, nonatomic) BrandsProductListModel *BrandsProductListModel;

@property (retain, nonatomic) ChaoliuChaoliuxinpinModel *ChaoliuChaoliuxinpinModel;

@property (retain, nonatomic) MoerMoreModel *MoerMoreModel;

@property (retain, nonatomic) AddressAddressLIstModel *AddressAddressLIstModel;

@property (retain, nonatomic) ProductProductDetailModel *ProductProductDetailModel;

@property (retain, nonatomic) OrdersOrdersModel *OrdersOrdersModel;

@property (retain, nonatomic) FavoriteFavoriteModel *FavoriteFavoriteModel;

@property (retain, nonatomic) MagazineMagazineModel *MagazineMagazineModel;

@property (retain, nonatomic) OrderInfoOrderInfoModel *OrderInfoOrderInfoModel;

@property (retain, nonatomic) StoresStoresModel *StoresStoresModel;




@property (nonatomic, assign) BOOL isClearCache;

+ (id)sharedModelManager;

/*
 字典转对象 正式版
 */
+ (LBaseModel *)parseModelWithDictionary:(NSDictionary *)jsonDic
                                    tag:(int)tag;

+ (LBaseModel *)parseModelWithFaileResult:(NSString *)result
                                     tag:(int)tag;

- (void)setModel:(LBaseModel *)model WithTag:(int)tag;


/*
 *
 * 字典转对象 测试版
 *
 */
+ (LBaseModel *)parseTestModelWithDictionary:(NSDictionary *)jsonDic
                                        tag:(int)tag;

/*
 *
 *  清除内存中的缓存
 *
 */

- (void)clearCacheInMemory;

@end
