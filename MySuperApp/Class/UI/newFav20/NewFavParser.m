//
//  NewFavParser.m
//  MyAimerApp
//
//  Created by yanglee on 15/4/25.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "NewFavParser.h"
#import "NewMaginzeListInfo.h"

@implementation NewFavParser



-(NewFavInfo *)parseNewFavStoreInfo:(NSDictionary*)dic{

    
    dicClassNames = @{@"topkey" : @"NewFavInfo",
                      @"favorite_stores" : @"NewFavStoreData",
                      };
    return [self parseDic:dic byKey:@"topkey"];
    
}


-(NewFavInfo *)parseNewFavMaginzeInfo:(NSDictionary*)dic{

    
    dicClassNames = @{@"topkey" : @"NewFavInfo",
                      @"favorite_magazine" : @"NewMaginzeData",
                      };
    return [self parseDic:dic byKey:@"topkey"];
    
}


@end
