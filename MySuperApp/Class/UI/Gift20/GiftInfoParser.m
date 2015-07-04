//
//  GiftInfoParser.m
//  MyAimerApp
//
//  Created by 蒋博男 on 15/7/4.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "GiftInfoParser.h"

@implementation GoodsGift
-(NSArray*)products
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [self attributeForKey:[str substringToIndex:str.length - 1]];
}
-(YKBaseEntity*)spec_values
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [self attributeForKey:[str substringToIndex:str.length - 1]];
}
-(NSArray*)specs
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [self attributeForKey:[str substringToIndex:str.length - 1]];
}
-(NSString*)productname
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [[self attributeForKey:[str substringToIndex:str.length - 1]] description];
}
-(NSString*)goodsid
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [[self attributeForKey:[str substringToIndex:str.length - 1]] description];
}
-(NSString*)promotion_id
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [[self attributeForKey:[str substringToIndex:str.length - 1]] description];
}
-(NSString*)imageurl
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [[self attributeForKey:[str substringToIndex:str.length - 1]] description];
}
-(NSString*)price
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [[self attributeForKey:[str substringToIndex:str.length - 1]] description];
}
@end

@implementation PromotionName
-(NSString*)promotion_name
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [[self attributeForKey:[str substringToIndex:str.length - 1]] description];
}
@end

@implementation ActionName
-(NSString*)actionname
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [[self attributeForKey:[str substringToIndex:str.length - 1]] description];
}
@end

@implementation GiftAction
-(NSArray*)goods_gifts
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [self attributeForKey:[str substringToIndex:str.length - 1]];
}
-(PromotionName*)promotion_name
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [self attributeForKey:[str substringToIndex:str.length - 1]];
}
-(ActionName*)action_name
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [self attributeForKey:[str substringToIndex:str.length - 1]];
}
@end

@implementation GoodsInfo
-(NSString*)gid
{
    return [[self attributeForKey:@"id"] description];
}
-(NSString*)goods_name
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [[self attributeForKey:[str substringToIndex:str.length - 1]] description];
}
-(NSString*)img_url
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [[self attributeForKey:[str substringToIndex:str.length - 1]] description];
}
@end

@implementation NoGift
-(NSString*)promotion_id
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [[self attributeForKey:[str substringToIndex:str.length - 1]] description];
}
-(NSString*)promotion_name
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [[self attributeForKey:[str substringToIndex:str.length - 1]] description];
}
-(NSString*)actionname
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [[self attributeForKey:[str substringToIndex:str.length - 1]] description];
}
-(BOOL)isSelect
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [[[self attributeForKey:[str substringToIndex:str.length - 1]] description] boolValue];
}
-(void)setIsSelect:(BOOL)isSelect
{
    [self setAttribute:[NSNumber numberWithBool:isSelect] forKey:@"isSelect"];
}
-(BOOL)isopen
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [[[self attributeForKey:[str substringToIndex:str.length - 1]] description] boolValue];
}
-(void)setIsopen:(BOOL)isopen
{
    [self setAttribute:[NSNumber numberWithBool:isopen] forKey:@"isopen"];
}
-(BOOL)ismeet
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [[[self attributeForKey:[str substringToIndex:str.length - 1]] description] boolValue];
}
-(void)setIsmeet:(BOOL)ismeet
{
    [self setAttribute:[NSNumber numberWithBool:ismeet] forKey:@"ismeet"];
}
@end

@implementation Gift
-(GiftAction*)action
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [self attributeForKey:[str substringToIndex:str.length - 1]];
}
-(BOOL)isSelect
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [[[self attributeForKey:[str substringToIndex:str.length - 1]] description] boolValue];
}
-(void)setIsSelect:(BOOL)isSelect
{
    [self setAttribute:[NSNumber numberWithBool:isSelect] forKey:@"isSelect"];
}
-(BOOL)isopen
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [[[self attributeForKey:[str substringToIndex:str.length - 1]] description] boolValue];
}
-(void)setIsopen:(BOOL)isopen
{
    [self setAttribute:[NSNumber numberWithBool:isopen] forKey:@"isopen"];
}
-(BOOL)ismeet
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [[[self attributeForKey:[str substringToIndex:str.length - 1]] description] boolValue];
}
-(void)setIsmeet:(BOOL)ismeet
{
    [self setAttribute:[NSNumber numberWithBool:ismeet] forKey:@"ismeet"];
}
@end

@implementation SelectGifts
-(NSArray*)gifts
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [self attributeForKey:[str substringToIndex:str.length - 1]];
}
-(NSArray*)nogifts
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [self attributeForKey:[str substringToIndex:str.length - 1]];
}
@end

@implementation GiftInfo
-(NSString*)response
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [[self attributeForKey:[str substringToIndex:str.length - 1]] description];
}
-(SelectGifts*)select_gifts
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [self attributeForKey:[str substringToIndex:str.length - 1]];
}
@end

@implementation GiftInfoParser
-(GiftInfo*)ParseGiftInfo:(NSDictionary*)dic
{
    dicClassNames = @{@"topkey" : @"GiftInfo",
                      @"select_gifts" : @"SelectGifts",
                      @"gifts" : @"Gift",
                      @"nogifts" : @"NoGift",
                      @"action" : @"GiftAction",
                      @"promotion_name" : @"PromotionName",
                      @"action_name" : @"ActionName",
                      @"productlist" : @"GiftProductInfo",
                      @"spec_values" : @"SpecValues",
                      @"specs" : @"PackageSpecInfo",
                      @"products" : @"GiftProductItemInfo",
                      @"goods_gifts" : @"GoodsGift",
                      @"0" : @"Zero"
                      };
    return [self parseDic:dic byKey:@"topkey"];
}
@end
