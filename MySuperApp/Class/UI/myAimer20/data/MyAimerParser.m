//
//  MyClosetParser.m
//  MyAimerApp
//
//  Created by yanglee on 15/6/14.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "MyAimerParser.h"



@implementation UserInfo

-(NSString*)isbind{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [[self attributeForKey:[str substringToIndex:str.length - 1]] description];
} //是否绑定手机

-(NSString*)valid_score{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [[self attributeForKey:[str substringToIndex:str.length - 1]] description];
} //积分

-(NSString*)ordernum{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [[self attributeForKey:[str substringToIndex:str.length - 1]] description];
} //订单数

-(NSString*)shopcartcount{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [[self attributeForKey:[str substringToIndex:str.length - 1]] description];
} //购物车商品数

-(NSString*)order_count{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [[self attributeForKey:[str substringToIndex:str.length - 1]] description];
} //近三个月 订单数

-(NSString*)norates{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [[self attributeForKey:[str substringToIndex:str.length - 1]] description];
}   //未评论数

-(NSString*)username{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [[self attributeForKey:[str substringToIndex:str.length - 1]] description];
} //用户名

-(NSString*)nodispose{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [[self attributeForKey:[str substringToIndex:str.length - 1]] description];
} //待处理 订单数

-(NSString*)nopay{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [[self attributeForKey:[str substringToIndex:str.length - 1]] description];
} //未付款 订单数

-(NSString*)addressnum{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [[self attributeForKey:[str substringToIndex:str.length - 1]] description];
} //地址数

-(NSString*)ordcancel{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [[self attributeForKey:[str substringToIndex:str.length - 1]] description];
}  //已取消 订单数

-(NSString*)favoritenum{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [[self attributeForKey:[str substringToIndex:str.length - 1]] description];
} //收藏数

-(NSString*)userface{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [[self attributeForKey:[str substringToIndex:str.length - 1]] description];
}  //用户图片下载地址


-(NSString*)is_wardrobe{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [[self attributeForKey:[str substringToIndex:str.length - 1]] description];
}   //私人衣橱的信息


@end

@implementation MyAimerInfo

-(UserInfo*)userinfo{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [self attributeForKey:[str substringToIndex:str.length - 1]];
}

-(NSArray*)notice{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [self attributeForKey:[str substringToIndex:str.length - 1]];
}

@end




@implementation MyAimerParser

-(MyAimerInfo *)parsemyAimerInfo:(NSDictionary*)dic{
    
    dicClassNames = @{@"topkey" : @"MyAimerInfo",
                      @"userinfo" : @"UserInfo",
                      };
    return [self parseDic:dic byKey:@"topkey"];

}

@end


