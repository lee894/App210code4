//
//  CouponListInfoParser.h
//  MyAimerApp
//
//  Created by 蒋博男 on 15-6-15.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "BaseParser.h"
#import "YKBaseEntity.h"

@interface FreePostCardInfo : YKBaseEntity
-(NSString*)name;
-(NSString*)code;
-(NSString*)total_times;
-(NSString*)used_times;
-(NSString*)start_time;
-(NSString*)end_time;
-(NSString*)user_update_time;
-(NSString*)status;
-(NSString*)desc;
-(NSString*)info;
@end

@interface V6CardInfo : YKBaseEntity
-(NSString*)name;
-(NSString*)card_id;
-(NSString*)canUseScore;
-(NSString*)frozenScore;
-(NSString*)balance;
-(NSString*)card_status;
-(NSString*)frozenBalance;
@end

@interface CouponInfo : YKBaseEntity
-(NSString*)code;
-(NSString*)type;
-(NSString*)stuatus;
-(NSString*)failtime;
-(NSString*)start_time;
-(NSString*)title;
-(NSString*)price;
-(NSString*)desc;
-(NSString*)info;
-(NSString*)url;
@end

@interface CouponListInfo : YKBaseEntity
-(NSString*)response;
-(NSInteger)current_page;
-(NSInteger)record_count;
-(NSInteger)page_count;
-(NSArray*)coupons;
-(NSArray*)v6cards;
-(NSArray*)freepostcards;
@end

@interface CouponListInfoParser : BaseParser
-(CouponListInfo *)parseCouponListInfo:(NSDictionary*)dic;
@end
