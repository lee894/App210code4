//
//  YKProductsItem.h
//  YKProduct
//
//  Created by k ye on 11-12-27.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YKBaseEntity.h"

@interface YKSuitListItem : YKBaseEntity {
    NSString *suitid;
    float disountprice;
    float price;
    float save;
    int number;
    //lee999 新增套装的积分
    int suit_score;
    
    NSMutableArray *suits;
}
@property(nonatomic,retain) NSString *suitid;
@property(nonatomic,assign) float disountprice;
@property(nonatomic,assign) float price;
@property(nonatomic,assign) float save;
@property(nonatomic,assign) int number;
//lee999 新增套装的积分
@property(nonatomic,assign) int suit_score;
@property(nonatomic,retain) NSString* packageid;

@property(nonatomic,retain) NSMutableArray *suits;
@end



@interface YKProductsItem : YKBaseEntity{

}
//@property (nonatomic, assign) BOOL rate_flag;

-(NSString *)goodsid;
-(void)setGoodsid:(NSString *)goodsid;

-(NSString*)ID;
-(void)setID:(NSString*)aID;
-(NSString*)Count;
-(void)setCount:(NSString*)aCount;
-(NSDictionary*)Spec_value_id;
-(void)setSpec_value_id:(NSDictionary*)aSpec_value_id;

//供套装使用
-(NSString*)product_id;
-(void)setProduct_id:(NSString*)aId;

-(NSString*)name;
-(void)setName:(NSString*)aName;

-(NSString*)pic;
-(void)setPic:(NSString*)aPic;

-(float)mkt_price;
-(void)setMkt_price:(float)aPrice;

-(float)price;
-(void)setPrice:(float)aPrice;

-(NSString*)size;
-(void)setSize:(NSString*)aSize;

-(NSString*)color;
-(void)setColor:(NSString*)aColor;

-(NSString*)stock;
-(void)setStock:(NSString*)aStock;

@end
@interface YKColor_Size : YKBaseEntity {
}
-(NSString*)ID;
-(void)setID:(NSString*)aID;
-(NSString*)Spec_type;
-(void)setSpec_type:(NSString*)aSpec_type;
-(NSString*)Type;
-(void)setType:(NSString*)aType;
-(NSString*)View_name;
-(void)setView_name:(NSString*)aView_name;
@end
@interface YKBannerItem : YKBaseEntity {

}
-(NSString*)ID;
-(void)setID:(NSString*)aID;
-(NSString*)BannerPic;
-(void)setBannerPic:(NSString*)aBannerPic;
@end

//
//@interface YKAllowPayType : YKBaseEntity
//
//-(NSString*)typeID;
//-(void)settypeID:(NSString*)aID;
//
//-(NSString*)typeDesc;
//-(void)settypeDesc:(NSString*)adesc;
//
//@end


//lee999 新增支付方式选择
@interface YKAllowPayType : YKBaseEntity {
    NSString *paytypeDesc;
    int payid;
}
@property(nonatomic,retain) NSString *paytypeDesc;
@property(nonatomic,assign) int payid;

@end


