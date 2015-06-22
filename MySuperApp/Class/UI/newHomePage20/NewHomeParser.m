//
//  NewHomeParser.m
//  MyAimerApp
//
//  Created by yanglee on 15/4/9.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "NewHomeParser.h"

@implementation NewHomeParser


-(NewHomeInfo*)parseNewHomeInfo:(NSDictionary*)dic
{
    dicClassNames = @{@"topkey" : @"NewHomeInfo",
                      @"top_banner" : @"NewhomeNormalData",
                      @"home_banner" : @"NewhomeNormalData",
                      @"home_navi" : @"NewhomeNormalData",
                      @"home_match" : @"NewhomeNormalData",
                      @"home_limitsale" : @"NewhomeNormalData",
                      @"home_hot" : @"NewhomeNormalData",
                      @"home_news" : @"NewhomeNormalData",
                      @"home_more" : @"NewhomeNormalData",
                      @"price" : @"NewhomegoodPriceData",
                      @"price1" : @"NewhomegoodPriceData",
                    };
    return [self parseDic:dic byKey:@"topkey"];
}



@end
