//
//  NewMaginzeListInfo.m
//  MyAimerApp
//
//  Created by yanglee on 15/4/12.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "NewMaginzeListInfo.h"

@implementation NewMaginzeData

-(id)init
{
    if (self = [super init]) {
        self.nType = 2;
    }
    return self;
}

-(NSString*)img_file_path{
    return [[self attributeForKey:@"img_file_path"] description];
}
-(NSString*)magazine_id{
    return [[self attributeForKey:@"magazine_id"] description];
}
-(NSString*)title{
    return [[self attributeForKey:@"title"] description];
}
-(NSString*)subtitle{
    return [[self attributeForKey:@"subtitle"] description];
}
-(NSString*)magazine_type{
    return [[self attributeForKey:@"magazine_type"] description];
}
-(NSString*)type_argu{
    return [[self attributeForKey:@"type_argu"] description];
}

@end



@implementation NewMaginzeListInfo

-(id)init
{
    if (self = [super init]) {
        self.nType = 1;
    }
    return self;
}


-(NSMutableArray*)magazinelist{
    return [self attributeForKey:@"magazinelist"];
}

@end


/*---------    杂志详情     ----------*/



@implementation NewMaginzeDetailProduct

-(id)init
{
    if (self = [super init]) {
        self.nType = 2;
    }
    return self;
}

-(NSString*)good_id{
    return [[self attributeForKey:@"good_id"] description];
}
-(NSString*)good_img{
    return [[self attributeForKey:@"good_img"] description];
}
-(NSString*)good_name{
    return [[self attributeForKey:@"good_name"] description];
}
-(NSString*)mkt_price{
    return [[self attributeForKey:@"mkt_price"] description];
}
-(NSString*)price{
    return [[self attributeForKey:@"price"] description];
}

@end

@implementation NewMaginzeDetailInfoA

-(id)init
{
    if (self = [super init]) {
        self.nType = 2;
    }
    return self;
}

-(NSString*)title{
    return [[self attributeForKey:@"title"] description];
}
-(NSString*)synopsis_text{
    return [[self attributeForKey:@"synopsis_text"] description];
}
-(NSString*)background_url{
    return [[self attributeForKey:@"background_url"] description];
}
-(NSMutableArray*)pic_file_path{
    return [self attributeForKey:@"pic_file_path"];
}
-(NSString*)content{
    return [[self attributeForKey:@"content"] description];
}
-(NSMutableArray*)goods_info{
    return [self attributeForKey:@"goods_info"];
}
-(NSString*)brand_name{
    return [[self attributeForKey:@"brand_name"] description];
}
-(NSString*)bottom_img{
    return [[self attributeForKey:@"bottom_img"] description];
}

@end



@implementation NewMaginzeDetailInfo_dataB

-(id)init
{
    if (self = [super init]) {
        self.nType = 2;
    }
    return self;
}

-(NSString*)img_path{
    return [[self attributeForKey:@"img_path"] description];
}
-(NSString*)title{
    return [[self attributeForKey:@"title"] description];
}
-(NSString*)synopsis_text{
    return [[self attributeForKey:@"synopsis_text"] description];
}
-(NSString*)content{
    return [[self attributeForKey:@"content"] description];
}

-(NSString*)brand_name{
    return [[self attributeForKey:@"brand_name"] description];
}

-(NSString*)good_id{
    return [[self attributeForKey:@"good_id"] description];
}

-(NSString*)backgroud_img_path
{
    return [[self attributeForKey:@"backgroud_img_path"] description];
}


@end


@implementation NewMaginzeDetailInfoB

-(id)init
{
    if (self = [super init]) {
        self.nType = 2;
    }
    return self;
}

-(NewMaginzeDetailInfo_dataB*)info_index{
    return [self attributeForKey:@"info_index"];
}
-(NSMutableArray*)info_content{
    return [self attributeForKey:@"info_content"];
}
-(NewMaginzeDetailInfo_dataB*)info_footer{
    return [self attributeForKey:@"info_footer"];
}

@end




@implementation NewMaginzeDetailInfo

-(id)init
{
    if (self = [super init]) {
        self.nType = 1;
    }
    return self;
}


-(NSString*)response{
    return [[self attributeForKey:@"response"] description];
}
-(NSString*)magazine_type{
    return [[self attributeForKey:@"magazine_type"] description];
}
-(NSString*)magazine_id{
    return [[self attributeForKey:@"magazine_id"] description];
}
-(NSString*)is_favorite{
    return [[self attributeForKey:@"is_favorite"] description];
}


-(NewMaginzeDetailInfoA*)magazine_info_a{
    return [self attributeForKey:@"magazine_info_a"];
}
-(NewMaginzeDetailInfoB*)magazine_info_b{
    return [self attributeForKey:@"magazine_info_b"];
}


@end



