//
//  NewBrandDetailInfo.m
//  MyAimerApp
//
//  Created by yanglee on 15/4/26.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "NewBrandDetailInfo.h"




@implementation NewBrandDetailZicunData

-(id)init
{
    if (self = [super init]) {
        self.nType = 1;
    }
    return self;
}

-(NSString*)brand_name{
    return [[self attributeForKey:@"brand_name"] description];
}
-(NSString*)pic{
    return [[self attributeForKey:@"pic"] description];
}

-(NSString*)params{
    return [[self attributeForKey:@"params"] description];
}


@end



@implementation NewBrandDetailInfo

-(id)init
{
    if (self = [super init]) {
        self.nType = 2;
    }
    return self;
}

-(NSString*)brand{
    return [[self attributeForKey:@"brand"] description];

}
-(NSString*)atype{
    return [[self attributeForKey:@"type"] description];

}
-(NSString*)alias{
    return [[self attributeForKey:@"alias"] description];
}


-(NSMutableArray*)home_banner{
    return [self attributeForKey:@"home_banner"];

}


-(NewBrandDetailZicunData*)brand_trend{
    return [self attributeForKey:@"brand_trend"];

}
-(NewBrandDetailZicunData*)brand_zixun{
    return [self attributeForKey:@"brand_zixun"];

}


@end
