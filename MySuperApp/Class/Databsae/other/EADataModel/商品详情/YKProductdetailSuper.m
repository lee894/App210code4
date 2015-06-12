//
//  YKProductdetailSuper.m
//  YKProduct
//
//  Created by zhao wangdong on 11-10-12.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "YKProductdetailSuper.h"


#pragma mark YKNameValue
//用于相同结构的字段
@implementation YKNameValue
//name
-(NSString*)NVName{
	return [self attributeForKey:@"name"];
}
-(void)setNVName:(NSString *)aNVName{
	[self setAttribute:aNVName forKey:@"name"];
}
//value
-(NSString*)NVValue{
	return [self attributeForKey:@"value"];
}
-(void)setNVValue:(NSString *)aNVValue{
	[self setAttribute:aNVValue forKey:@"value"];
}
@end


#pragma mark YKMultiDesc
@implementation YKMultiDesc

//product_multidisc
//"货号:A0001,品牌:Adidas,名称:运动鞋,价格:699,VIP价:269,市场价:1090"
-(NSString*)MultiDesc{
	return [self attributeForKey:@"product_multidisc"];
}
@end

#pragma mark YKActiveShow
@implementation YKActiveShow
//pic
-(NSString*)ActivePic{
	return [self attributeForKey:@"pic"];
}
//title
-(NSString*)ActiveTitle{
	return [self attributeForKey:@"title"];
}
@end
#pragma mark YKSimpleDesc
@implementation YKSimpleDesc
//price1
-(YKNameValue*)SimplePrice1{
	return [self attributeForKey:@"price1"];
}
//price2
-(YKNameValue*)SimplePrice2{
	return [self attributeForKey:@"price2"];
}
//price3
-(YKNameValue*)SimplePrice3{
	return [self attributeForKey:@"price3"];
}
//price4
-(YKNameValue*)SimplePrice4{
	return [self attributeForKey:@"price4"];
}
/** 
 *	price1、price2、price3、price4使用公用的set方法
 *	@param	(NSDictionary *)aMem 待封装的字典
 *	@param	(NSString *)key 标识是price1、2、3、4
 *  @return (void)
 */
-(void)setCommonMember:(NSDictionary *)aMem forKey:(NSString *)key{
    //无论是price1还是price2、、、对应的值都是nv对象
    YKNameValue *nv=[[YKNameValue alloc] init];
    for (id each in [aMem allKeys]) {//each是字典中的两个键
        [nv setAttribute:[aMem objectForKey:each] forKey:each];
    }
	[self setAttribute:nv forKey:key];
}
@end
#pragma mark YKPropertyShow
@implementation YKPropertyShow
//name
-(NSString*)PropertyName{
    return [self attributeForKey:@"name"];
}
//id
-(NSString*)PropertyID{
	return [self attributeForKey:@"productid"];
}
//color
-(NSString*)PropertyColor{
	return [self attributeForKey:@"color"];
}
//color_pic
-(NSString*)PropertyColorPic{
	return [self attributeForKey:@"color_pic"];
}
//size
-(NSString*)PropertySize{
	return [self attributeForKey:@"size"];
}
@end
#pragma mark YKBannerShowInProductdetail
@implementation YKBannerShowInProductdetail
//id
-(NSString*)BannerDetailID{
	return [self attributeForKey:@"id"];
}
//des
-(NSString*)BannerDetailDescribe{
	return [self attributeForKey:@"describe"];
}
//pic
-(NSString*)BannerDetailPic{
	return [self attributeForKey:@"pic"];
}
//pic2
-(NSString*)BannerDetailPic2{
	return [self attributeForKey:@"pic2"];
}
//detailid
-(NSString*)BannerDetailDetailID{
    return [self attributeForKey:@"detailid"];
}
@end

#pragma mark YKBannerShowInProductdetailList
@implementation YKBannerShowInProductdetailList
-(void)addBannerShowInProductdetail:(YKBannerShowInProductdetail *)aBannerShowInProductdetail{
    [self addObject:aBannerShowInProductdetail];
}
@end


//YKProductdetailSuper 可以根据键productdetail获得YKProductdetail对象，包括YKBannerShowInProductdetailList，YKPropertyShow，YKSimpleDesc，YKActiveShow4个属性
#pragma mark YKProductdetail
@implementation YKProductdetail
//banner_showList
-(YKBannerShowInProductdetailList *)Productdetail_BannerShowList{
	return [self attributeForKey:@"banner_show"];
}
-(void)setProductdetail_BannerShow:(YKBannerShowInProductdetailList *)aProductdetail_BannerShowList{
	[self setAttribute:aProductdetail_BannerShowList forKey:@"banner_show"];
}
//property_show
-(YKPropertyShow *)Productdetail_PropertyShow{
	return [self attributeForKey:@"property_show"];
}
-(void)setProductdetail_PropertyShow:(YKPropertyShow *)aProductdetail_PropertyShow{
	[self setAttribute:aProductdetail_PropertyShow forKey:@"property_show"];
}
//simple_desc
-(YKSimpleDesc *)Productdetail_SimpleDesc{
	return [self attributeForKey:@"simple_desc"];
}
-(void)setProductdetail_SimpleDesc:(YKSimpleDesc *)asetProductdetail_SimpleDesc{
	[self setAttribute:asetProductdetail_SimpleDesc forKey:@"simple_desc"];
}
//active_show
-(YKActiveShow *)Productdetail_ActiveShow{
	return [self attributeForKey:@"active_show"];
}
-(void)setProductdetail_ActiveShow:(YKActiveShow *)asetProductdetail_ActiveShow{
	[self setAttribute:asetProductdetail_ActiveShow forKey:@"active_show"];
}
//multi_desc
-(YKMultiDesc *)Productdetail_MultiShow{
	return [self attributeForKey:@"multi_desc"];
}
-(void)setProductdetail_MultiShow:(YKMultiDesc *)asetProductdetail_MultiShow{
	[self setAttribute:asetProductdetail_MultiShow forKey:@"multi_desc"];
}
@end

#pragma mark YKProductdetailList
@implementation YKProductdetailList
/** 
 *	将 商品详情信息model 添加到YKProductdetailList中
 *	@param	(YKProductdetail*)aProductdetail 单个商品详情model
 *  @return (void)
 */
-(void)addProductdetail:(YKProductdetail*)aProductdetail{
    [self addObject:aProductdetail];
}
@end

#pragma mark YKProductdetailSuper
@implementation YKProductdetailSuper
//QA
-(NSString *)ProductdetailQA{
    return [self attributeForKey:@"product_qabtn"];
}
//comment
-(NSString *)ProductdetailComment{
    return [self attributeForKey:@"product_commentbtn"];
}
//response
-(NSString *)ProductdetailResponse{
    return [self attributeForKey:@"response"];
}
//styleID
-(NSString *)ProductdetailStyle{
    return [self attributeForKey:@"styleid"];
}
/** 
 *	get 所有商品的详情信息model
 *  @return YKProductdetailList
 */
-(YKProductdetailList *)ProductdetailSuperDetail{
	return [self attributeForKey:@"productdetail"];
}

/** 
 *	将 商品详情信息数组 组装成YKProductdetailList
 *	@param	(NSArray *)asetProductdetailSuperDetail 单个商品的详情信息
 *  @return (void)
 */
-(void)setProductdetailSuperDetail:(NSArray *)asetProductdetailSuperDetail{
    //for循环遍历数组 针对每一个YKProductdetail对象操作 取出banner、property对象
    YKProductdetailList *proDetailList=[[YKProductdetailList alloc] init];
    for (id cms in asetProductdetailSuperDetail) {
        YKProductdetail *detail=[[YKProductdetail alloc] init];
        NSArray *ban=[cms objectForKey:@"product_banner"];//取出bannershow
        
        YKBannerShowInProductdetailList *banList=[[YKBannerShowInProductdetailList alloc] init];
        for (id banCms in ban) {
            YKBannerShowInProductdetail *banDetail=[[YKBannerShowInProductdetail alloc] init];
            for (id eachKey in [banCms allKeys]) {
                [banDetail setAttribute:[banCms objectForKey:eachKey] forKey:eachKey];
            }
            [banList addBannerShowInProductdetail:banDetail];
        }
        [detail setProductdetail_BannerShow:banList];
        //YKBannerShowInProductdetailList创建好了
		
		
        NSDictionary *property=[cms objectForKey:@"product_property"];        
        YKPropertyShow *pro=[[YKPropertyShow alloc] init];
        for (id eachKey in [property allKeys]) {
            [pro setAttribute:[property objectForKey:eachKey] forKey:eachKey];
        }
        [detail setProductdetail_PropertyShow:pro];
        //YKPropertyShow创建好了
        
        
        NSDictionary *simple=[cms objectForKey:@"product_simpledesc"];
        YKSimpleDesc *sim=[[YKSimpleDesc alloc] init];
        for (id eachKey in [simple allKeys]) {
            [sim setCommonMember:[simple objectForKey:eachKey] forKey:eachKey];
        }
        [detail setProductdetail_SimpleDesc:sim];
        //YKSimpleDesc创建好了
        
        NSDictionary *active=[cms objectForKey:@"product_activity"];
        YKActiveShow *ace=[[YKActiveShow alloc] init];
        for (id eachKey in [active allKeys]) {
            [sim setAttribute:[active objectForKey:eachKey] forKey:eachKey];
        }
        [detail setProductdetail_ActiveShow:ace];
        //YKActiveShow创建好了
        
        NSString *multi=[cms objectForKey:@"product_multidisc"];
        YKMultiDesc *mul=[[YKMultiDesc alloc] init];
        [mul setAttribute:multi forKey:@"product_multidisc"];
        [detail setProductdetail_MultiShow:mul];
        //YKMultiDesc创建好了
        
        [proDetailList addProductdetail:detail];
        
    }
	[self setAttribute:proDetailList forKey:@"productdetail"];
}
@end
