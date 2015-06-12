//
//  YKProductdetailSuper.h
//  YKProduct
//
//  Created by zhao wangdong on 11-10-12.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YKBaseEntityList.h"
#pragma mark YKNameValue
//价格信息的封装 ：名字，数值
@interface YKNameValue : YKBaseEntity {
    
}
-(NSString*)NVName;
-(void)setNVName:(NSString *)aNVName;
-(NSString*)NVValue;
-(void)setNVValue:(NSString *)aNVValue;
@end


#pragma mark -
#pragma mark YKMultiDesc
//商品详细信息描述
@interface YKMultiDesc : YKBaseEntity {
    
}
//product_multidisc
-(NSString*)MultiDesc;
@end

#pragma mark YKActiveShow
//活动信息描述
@interface YKActiveShow : YKBaseEntity {
    
}
//title
-(NSString*)ActiveTitle;
//pic
-(NSString*)ActivePic;

@end

#pragma mark YKSimpleDesc
//商品价格描述，使用YKNameValue类的对象
@interface YKSimpleDesc : YKBaseEntity {
    
}
//price1
-(YKNameValue*)SimplePrice1;
//price2
-(YKNameValue*)SimplePrice2;
//price3
-(YKNameValue*)SimplePrice3;
//price4
-(YKNameValue*)SimplePrice4;
-(void)setCommonMember:(NSDictionary *)aMem forKey:(NSString *)key;
@end

#pragma mark YKPropertyShow
//商品属性描述
@interface YKPropertyShow : YKBaseEntity {
    
}
//name
-(NSString*)PropertyName;
//size
-(NSString*)PropertySize;
//color
-(NSString*)PropertyColor;
//colorPic
-(NSString*)PropertyColorPic;
//id
-(NSString*)PropertyID;
@end

#pragma mark YKBannerShowInProductdetail
//是商品的其中一张图片的各种属性
@interface YKBannerShowInProductdetail : YKBaseEntity {
    
}
//pic2
-(NSString*)BannerDetailPic2;
//pic
-(NSString*)BannerDetailPic;
//des
-(NSString*)BannerDetailDescribe;
//detailid
-(NSString*)BannerDetailDetailID;
//id
-(NSString*)BannerDetailID;

@end


#pragma mark -
#pragma mark YKBannerShowInProductdetailList
//YKBannerShowInProductdetail的集合
@interface YKBannerShowInProductdetailList : YKBaseEntityList {
    
}
-(void)addBannerShowInProductdetail:(YKBannerShowInProductdetail *)aBannerShowInProductdetail;
@end

#pragma mark -
#pragma mark YKProductdetail
//最底层的商品详情，包含此商品的各种说明和图片,即YKBannerShowInProductdetailList，YKPropertyShow，YKSimpleDesc，YKActiveShow4个属性。
@interface YKProductdetail : YKBaseEntity {
    
}
//multi_desc
-(YKMultiDesc *)Productdetail_MultiShow;
-(void)setProductdetail_MultiShow:(YKMultiDesc *)asetProductdetail_MultiShow;
//active_show
-(YKActiveShow *)Productdetail_ActiveShow;
-(void)setProductdetail_ActiveShow:(YKActiveShow *)asetProductdetail_ActiveShow;
//simple_desc
-(YKSimpleDesc *)Productdetail_SimpleDesc;
-(void)setProductdetail_SimpleDesc:(YKSimpleDesc *)asetProductdetail_SimpleDesc;
//property_show
-(YKPropertyShow *)Productdetail_PropertyShow;
-(void)setProductdetail_PropertyShow:(YKPropertyShow *)aProductdetail_PropertyShow;
//banner_showList
-(YKBannerShowInProductdetailList *)Productdetail_BannerShowList;
-(void)setProductdetail_BannerShow:(YKBannerShowInProductdetailList *)aProductdetail_BannerShowList;
@end

#pragma mark YKProductdetailList
//n个同类不同色的商品的集合，成员是YKProductdetail
@interface YKProductdetailList : YKBaseEntityList {
    
}
-(void)addProductdetail:(YKProductdetail*)aProductdetail;
@end


#pragma mark -
#pragma mark YKProductdetailSuper
//请求一个商品详情时，服务器所返回的全部信息所构成的类，核心成员是YKProductdetailList（YKBaseEntityList），是n个同类不同色的商品的集合
@interface YKProductdetailSuper :  YKBaseEntity{
    
}
//productdetail
-(YKProductdetailList *)ProductdetailSuperDetail;
-(void)setProductdetailSuperDetail:(NSArray *)asetProductdetailSuperDetail;
//QA
-(NSString *)ProductdetailQA;
//comment
-(NSString *)ProductdetailComment;
//response
-(NSString *)ProductdetailResponse;
//styleID
-(NSString *)ProductdetailStyle;
@end
