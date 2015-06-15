//
//  PackageInfoParser.m
//  MyAimerApp
//
//  Created by 蒋博男 on 15-6-10.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "PackageInfoParser.h"

@implementation PackageGoodsInfo
-(NSString*)gid
{
    return [[self attributeForKey:@"id"] description];
}
-(NSString*)name
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [[self attributeForKey:[str substringToIndex:str.length - 1]] description];
}
-(NSString*)image_url
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [[self attributeForKey:[str substringToIndex:str.length - 1]] description];
}
-(NSString*)mkt_price
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

@implementation PackageGroupInfo
-(NSString*)gid
{
    return [[self attributeForKey:@"id"] description];
}
-(NSString*)name
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [[self attributeForKey:[str substringToIndex:str.length - 1]] description];
}
-(NSString*)package_id
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [[self attributeForKey:[str substringToIndex:str.length - 1]] description];
}
-(NSString*)group_type
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [[self attributeForKey:[str substringToIndex:str.length - 1]] description];
}
-(NSString*)count
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [[self attributeForKey:[str substringToIndex:str.length - 1]] description];
}
-(NSString*)page_no
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [[self attributeForKey:[str substringToIndex:str.length - 1]] description];
}
-(NSArray*)goods
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [self attributeForKey:[str substringToIndex:str.length - 1]];
}
-(NSString*)total_goods_count
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [[self attributeForKey:[str substringToIndex:str.length - 1]] description];
}
-(NSString*)page_size
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [[self attributeForKey:[str substringToIndex:str.length - 1]] description];
}
-(NSString*)need_select_count
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [[self attributeForKey:[str substringToIndex:str.length - 1]] description];
}
@end

@implementation PackageData
-(NSString*)pId
{
    return [[self attributeForKey:@"id"] description];
}
-(NSString*)name
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [[self attributeForKey:[str substringToIndex:str.length - 1]] description];
}
-(NSString*)promotion_type
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [[self attributeForKey:[str substringToIndex:str.length - 1]] description];
}
-(NSString*)price
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [[self attributeForKey:[str substringToIndex:str.length - 1]] description];
}
-(NSString*)disc_rate
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [[self attributeForKey:[str substringToIndex:str.length - 1]] description];
}
-(NSString*)up_flag
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [[self attributeForKey:[str substringToIndex:str.length - 1]] description];
}
-(NSString*)image_file_path
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [[self attributeForKey:[str substringToIndex:str.length - 1]] description];
}
-(NSString*)thumb_file_path
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [[self attributeForKey:[str substringToIndex:str.length - 1]] description];
}
-(NSArray*)groups
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [self attributeForKey:[str substringToIndex:str.length - 1]];
}
-(NSString*)need_select_count
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [[self attributeForKey:[str substringToIndex:str.length - 1]] description];
}
@end

@implementation PackageInfo
-(NSString*)response
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [[self attributeForKey:[str substringToIndex:str.length - 1]] description];
}
-(PackageData*)packageinfo
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [self attributeForKey:[str substringToIndex:str.length - 1]];
}
@end

@implementation PackageInfoParser
-(PackageInfo *)parsePackageInfo:(NSDictionary*)dic
{
    dicClassNames = @{@"topkey" : @"PackageInfo",
                      @"groups" : @"PackageGroupInfo",
                      @"packageinfo" : @"PackageData",
                      @"goods" : @"PackageGoodsInfo"
                      };
    return [self parseDic:dic byKey:@"topkey"];

}
@end
