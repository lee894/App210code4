//
//  MyClosetParser.h
//  MyAimerApp
//
//  Created by yanglee on 15/6/14.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "YKBaseEntity.h"
#import "BaseParser.h"
//#import "MyClosetInfo.h"

@interface UserInfo: YKBaseEntity

-(NSString*)isbind; //是否绑定手机
-(NSString*)valid_score; //积分
-(NSString*)ordernum; //订单数
-(NSString*)shopcartcount; //购物车商品数
-(NSString*)order_count; //近三个月 订单数
-(NSString*)norates;   //未评论数
-(NSString*)username; //用户名
-(NSString*)nodispose; //待处理 订单数
-(NSString*)nopay; //未付款 订单数

-(NSString*)addressnum; //地址数
-(NSString*)ordcancel;  //已取消 订单数
-(NSString*)favoritenum; //收藏数
-(NSString*)userface;  //用户图片下载地址

-(NSString*)is_wardrobe;  //私人衣橱的信息

-(NSString*)bind_number; //绑定的手机号码
@end

@interface MyAimerInfo : YKBaseEntity

-(UserInfo*)userinfo;
-(NSArray*)notice;

@end


@interface MyAimerParser : BaseParser

-(MyAimerInfo *)parsemyAimerInfo:(NSDictionary*)dic;

@end