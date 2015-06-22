//
//  NewHomeInfo.h
//  MyAimerApp
//
//  Created by yanglee on 15/4/9.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YKBaseEntity.h"


@interface NewhomegoodPriceData: YKBaseEntity

-(NSString*)value;
-(NSString*)name;

@end



@interface NewhomeNormalData: YKBaseEntity

-(NSString*)atype;
-(NSString*)bannerid;
-(NSString*)title;
-(NSString*)nexttitle;
-(NSString*)pic;
-(NSString*)type_argu;
-(NSString*)titledes;
-(NSString*)channelid;

-(NSString*)params;


-(NSString*)goodid;
-(NSString*)name;

-(NewhomegoodPriceData*)price;
-(NewhomegoodPriceData*)price1;


@end


@interface NewHomeInfo : YKBaseEntity

-(int)errCode;
-(NSMutableArray*)top_banner;

-(NSMutableArray*)home_banner;
-(NSMutableArray*)home_navi;
-(NSMutableArray*)home_more; //为我推荐   商品

-(NewhomeNormalData*)home_match;
-(NewhomeNormalData*)home_limitsale;
-(NewhomeNormalData*)home_hot;
-(NewhomeNormalData*)home_news;
@end



/*
@interface NewhomeNormalData: YKBaseEntity

-(NSString*)type;
-(NSString*)pic;

@end

@interface Newhome_matchData: YKBaseEntity

@end


@interface Newhome_hotData: YKBaseEntity

@end

@interface Newhome_newsData: YKBaseEntity

@end
*/




