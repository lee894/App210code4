//
//  NewFavInfo.h
//  MyAimerApp
//
//  Created by yanglee on 15/4/25.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "YKBaseEntity.h"


@interface NewFavStoreData : YKBaseEntity

-(NSString*)storeid;
-(NSString*)store_name;
-(NSString*)store_address;
-(NSString*)store_tel;
-(NSString*)store_gpslng;
-(NSString*)store_gpslat;
-(NSString*)file_path;
-(NSString*)brand;
-(NSString*)promotion_message;
-(NSString*)created;
-(NSString*)update_time;
-(NSString*)update_by;
-(NSString*)business_hours;
-(NSString*)distance;
-(NSString*)is_favorite;


@end



@interface NewFavInfo : YKBaseEntity

-(NSString*)response;
-(NSString*)favtype;
-(NSString*)current_page;
-(NSString*)record_count;
-(NSString*)page_count;

-(NSMutableArray*)favorite_pic;
-(NSMutableArray*)favorite_stores;
-(NSMutableArray*)favorite_magazine;



@end
