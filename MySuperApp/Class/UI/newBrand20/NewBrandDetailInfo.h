//
//  NewBrandDetailInfo.h
//  MyAimerApp
//
//  Created by yanglee on 15/4/26.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "YKBaseEntity.h"
#import "NewHomeInfo.h"


@interface NewBrandDetailZicunData : YKBaseEntity

-(NSString*)brand_name;
-(NSString*)pic;
-(NSString*)params;


@end



@interface NewBrandDetailInfo : YKBaseEntity

-(NSString*)brand;
-(NSString*)atype;
-(NSString*)alias;


-(NSMutableArray*)home_banner;


-(NewBrandDetailZicunData*)brand_trend;
-(NewBrandDetailZicunData*)brand_zixun;


@end
