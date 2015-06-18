//
//  MyClosetListParser.h
//  MyAimerApp
//
//  Created by yanglee on 15/6/18.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "BaseParser.h"
#import "YKBaseEntity.h"



@interface MyClosetPriceData : YKBaseEntity

-(NSString*)name;
-(NSString*)value;


@end



@interface MyClosetitemData : YKBaseEntity

-(NSString*)aid;
-(NSString*)name;
-(NSString*)pic;
-(MyClosetPriceData*)price;
-(MyClosetPriceData*)price1;

@end


@interface MyClosetListData : YKBaseEntity

-(NSString*)aid;
-(NSString*)name;

-(NSArray*)goods_list;

@end

@interface MyClosetListInfo : YKBaseEntity

-(NSArray*)wardrobe_info;


@end




@interface MyClosetListParser : BaseParser

-(MyClosetListInfo *)parseClosetListInfo:(NSDictionary*)dic;


@end
