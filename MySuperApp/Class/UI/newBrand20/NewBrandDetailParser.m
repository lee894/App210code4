//
//  NewBrandDetailParser.m
//  MyAimerApp
//
//  Created by yanglee on 15/4/26.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "NewBrandDetailParser.h"
#import "NewHomeInfo.h"

@implementation NewBrandDetailParser
-(NewBrandDetailInfo *)parseBrandDetailInfo:(NSDictionary*)dic{

    
    dicClassNames = @{@"topkey" : @"NewBrandDetailInfo",
                      @"home_banner" : @"NewhomeNormalData",
                      @"brand_trend" : @"NewBrandDetailZicunData",
                      @"brand_zixun" : @"NewBrandDetailZicunData",
                      };
    return [self parseDic:dic byKey:@"topkey"];



}



@end
