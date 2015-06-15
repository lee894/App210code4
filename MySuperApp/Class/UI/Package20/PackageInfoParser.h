//
//  PackageInfoParser.h
//  MyAimerApp
//
//  Created by 蒋博男 on 15-6-10.
//  Copyright (c) 2015年 aimer. All rights reserved.
//
#import "YKBaseEntity.h"
#import "BaseParser.h"

@interface PackageGoodsInfo  : YKBaseEntity
-(NSString*)gid;
-(NSString*)name;
-(NSString*)image_url;
-(NSString*)mkt_price;
-(NSString*)price;
@end

@interface PackageGroupInfo  : YKBaseEntity
-(NSString*)gid;
-(NSString*)name;
-(NSString*)package_id;
-(NSString*)group_type;
-(NSString*)count;
-(NSString*)page_no;
-(NSArray*)goods;
-(NSString*)total_goods_count;
-(NSString*)page_size;
-(NSString*)need_select_count;
@end

@interface PackageData : YKBaseEntity
-(NSString*)pId;
-(NSString*)name;
-(NSString*)promotion_type;
-(NSString*)price;
-(NSString*)disc_rate;
-(NSString*)up_flag;
-(NSString*)image_file_path;
-(NSString*)thumb_file_path;
-(NSArray*)groups;
-(NSString*)need_select_count;
@end

@interface PackageInfo : YKBaseEntity
-(NSString*)response;
-(PackageData*)packageinfo;
@end

@interface PackageInfoParser : BaseParser
-(PackageInfo *)parsePackageInfo:(NSDictionary*)dic;
@end
