//
//  NewSortParser.m
//  MyAimerApp
//
//  Created by yanglee on 15/4/15.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "NewSortParser.h"

@implementation NewSortParser

-(NewSortInfo *)parseNewHomeInfo:(NSDictionary*)dic{
    
    
    dicClassNames = @{@"topkey" : @"NewSortInfo",
                      @"woman" : @"NewSortData",
                      @"man" : @"NewSortData",
                      @"girl" : @"NewSortData",
                      @"boy" : @"NewSortData",
                      };
    return [self parseDic:dic byKey:@"topkey"];
}

@end
