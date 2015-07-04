//
//  GiftInfoParser.h
//  MyAimerApp
//
//  Created by 蒋博男 on 15/7/4.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "PackageInfoParser.h"
#import "ManageGiftInfoParser.h"
#import "YKBaseEntity.h"
#import "BaseParser.h"

@interface GoodsGift : YKBaseEntity
-(NSArray*)products;
-(YKBaseEntity*)spec_values;
-(NSArray*)specs;
-(NSString*)productname;
-(NSString*)goodsid;
-(NSString*)promotion_id;
-(NSString*)imageurl;
-(NSString*)price;
@end

@interface PromotionName : YKBaseEntity
-(NSString*)promotion_name;
@end

@interface ActionName : YKBaseEntity
-(NSString*)actionname;
@end

@interface GiftAction : YKBaseEntity
-(NSArray*)goods_gifts;
-(PromotionName*)promotion_name;
-(ActionName*)action_name;
@end

@interface GoodsInfo : YKBaseEntity
-(NSString*)gid;
-(NSString*)goods_name;
-(NSString*)img_url;
@end

@interface NoGift : YKBaseEntity
-(NSString*)promotion_id;
-(NSString*)promotion_name;
-(NSString*)actionname;
-(BOOL)isSelect;
-(void)setIsSelect:(BOOL)isSelect;
-(BOOL)isopen;
-(void)setIsopen:(BOOL)isopen;
-(BOOL)ismeet;
-(void)setIsmeet:(BOOL)ismeet;
@end

@interface Gift : YKBaseEntity
-(GiftAction*)action;
-(BOOL)isSelect;
-(void)setIsSelect:(BOOL)isSelect;
-(BOOL)isopen;
-(void)setIsopen:(BOOL)isopen;
-(BOOL)ismeet;
-(void)setIsmeet:(BOOL)ismeet;
@end

@interface SelectGifts : YKBaseEntity
-(NSArray*)gifts;
-(NSArray*)nogifts;
@end

@interface GiftInfo : YKBaseEntity
-(NSString*)response;
-(SelectGifts*)select_gifts;
@end

@interface GiftInfoParser : BaseParser
-(GiftInfo*)ParseGiftInfo:(NSDictionary*)dic;
@end
