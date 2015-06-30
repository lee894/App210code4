//
//  MoerUserinfo.h
//
//  Created by malan  on 14-4-15
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface MoerUserinfo : NSObject <NSCoding>

@property (nonatomic, retain) NSString *isbind; //是否绑定手机
@property (nonatomic, retain) NSString *validScore; //积分
@property (nonatomic, retain) NSString *ordernum; //订单数
@property (nonatomic, assign) double shopcartcount; //购物车商品数
@property (nonatomic, retain) NSString *orderCount; //近三个月 订单数
@property (nonatomic, assign) NSString* norates;   //未评论数
@property (nonatomic, retain) NSString *username; //用户名
@property (nonatomic, retain) NSString *nodispose; //待处理 订单数
@property (nonatomic, retain) NSString *nopay; //未付款 订单数

@property (nonatomic, retain) NSString *addressnum; //地址数
@property (nonatomic, retain) NSString *ordcancel;  //已取消 订单数
@property (nonatomic, retain) NSString *favoritenum;
@property (nonatomic, retain) NSString *userface;


+ (MoerUserinfo *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
