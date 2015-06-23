//
//  NewHomeInfo.m
//  MyAimerApp
//
//  Created by yanglee on 15/4/9.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "NewHomeInfo.h"


@implementation NewhomegoodPriceData

-(id)init
{
    if (self = [super init]) {
        self.nType = 2;
    }
    return self;
}

-(NSString*)value{
    return [[self attributeForKey:@"value"] description];
}
-(void)setvalue:(NSString *)value_
{
    [self setAttribute:value_ forKey:@"value"];
}


-(NSString*)name{
    return [[self attributeForKey:@"name"] description];
}

@end


@implementation NewhomeNormalData
-(id)init
{
    if (self = [super init]) {
        self.nType = 2;
    }
    return self;
}
-(NSString*)atype{
    return [[self attributeForKey:@"type"] description];
}
-(NSString*)bannerid{
    return [[self attributeForKey:@"id"] description];
}
-(NSString*)title{
    return [[self attributeForKey:@"title"] description];
}

-(NSString*)nexttitle{
    return [[self attributeForKey:@"nexttitle"] description];
}

-(NSString*)pic{
    return [[self attributeForKey:@"pic"] description];
}

-(void)setPic:(NSString *)pic_
{
    [self setAttribute:pic_ forKey:@"pic"];
}

-(NSString*)type_argu{
    return [[self attributeForKey:@"type_argu"] description];
}

-(NSString*)titledes{
    return [[self attributeForKey:@"titledes"] description];
}

-(NSString*)channelid{
    return [[self attributeForKey:@"channelid"] description];
}


-(NSString*)params{
    return [[self attributeForKey:@"params"] description];
}


-(NSString*)goodid{
    return [[self attributeForKey:@"id"] description];
}
-(NSString*)name{
    return [[self attributeForKey:@"name"] description];
}



-(NewhomegoodPriceData*)price{
    return [self attributeForKey:@"price"];

}
-(NewhomegoodPriceData*)price1{
    return [self attributeForKey:@"price1"];

}


@end


@implementation NewHomeInfo

-(id)init
{
    if (self = [super init]) {
        self.nType = 1;
    }
    return self;
}

-(int)errCode{
    return [[self attributeForKey:@"priceValue"] intValue];
}

-(int)retCode{
    return [[self attributeForKey:@"priceValue"] intValue];
}

-(NSString*)msg{
    return [self attributeForKey:@"msg"];
}

-(NSMutableArray*)top_banner{
    return [self attributeForKey:@"top_banner"];
}



-(NSMutableArray*)home_banner{
    return [self attributeForKey:@"home_banner"];
}

-(NSMutableArray*)home_navi{
    return [self attributeForKey:@"home_navi"];
}

-(NSMutableArray*)home_more //为我推荐   商品
{
    return [self attributeForKey:@"home_more"];
}


-(NewhomeNormalData*)home_match{
    return [self attributeForKey:@"home_match"];
}

-(NewhomeNormalData*)home_limitsale{
    return [self attributeForKey:@"home_limitsale"];
}

-(NewhomeNormalData*)home_hot{
    return [self attributeForKey:@"home_hot"];
}

-(NewhomeNormalData*)home_news{
    return [self attributeForKey:@"home_news"];
}


@end

