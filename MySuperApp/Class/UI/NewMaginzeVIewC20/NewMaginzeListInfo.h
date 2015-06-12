//
//  NewMaginzeListInfo.h
//  MyAimerApp
//
//  Created by yanglee on 15/4/12.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "YKBaseEntity.h"

@interface NewMaginzeData: YKBaseEntity

-(NSString*)img_file_path;
-(NSString*)magazine_id;
-(NSString*)title;
-(NSString*)subtitle;
-(NSString*)magazine_type;
-(NSString*)type_argu;

@end

@interface NewMaginzeListInfo : YKBaseEntity

-(NSMutableArray*)magazinelist;

@end



/*---------    杂志详情     ----------*/


@interface NewMaginzeDetailProduct : YKBaseEntity

-(NSString*)good_id;
-(NSString*)good_img;
-(NSString*)good_name;
-(NSString*)mkt_price;
-(NSString*)price;

@end

@interface NewMaginzeDetailInfoA : YKBaseEntity

-(NSString*)title;
-(NSString*)synopsis_text;
-(NSString*)background_url;
-(NSMutableArray*)pic_file_path;
-(NSString*)content;
-(NSMutableArray*)goods_info;
-(NSString*)brand_name;
-(NSString*)bottom_img;

@end



@interface NewMaginzeDetailInfo_dataB : YKBaseEntity

-(NSString*)img_path;
-(NSString*)title;
-(NSString*)synopsis_text;
-(NSString*)content;
-(NSString*)brand_name;

-(NSString*)good_id;

-(NSString*)backgroud_img_path;


@end


@interface NewMaginzeDetailInfoB : YKBaseEntity


-(NewMaginzeDetailInfo_dataB*)info_index;
-(NSMutableArray*)info_content;
-(NewMaginzeDetailInfo_dataB*)info_footer;

@end




@interface NewMaginzeDetailInfo : YKBaseEntity
-(NSString*)response;
-(NSString*)magazine_type;
-(NSString*)magazine_id;
-(NSString*)is_favorite;


-(NewMaginzeDetailInfoA*)magazine_info_a;
-(NewMaginzeDetailInfoB*)magazine_info_b;

@end





//@interface NewMaginzeDetailInfo_contentB : YKBaseEntity
//
//-(NSString*)img_path;
//-(NSString*)title;
//-(NSString*)synopsis_text;
//-(NSString*)content;
//
//@end
//
//@interface NewMaginzeDetailInfo_footerB : YKBaseEntity
//
//-(NSString*)brand_name;
//-(NSString*)img_path;
//@end




