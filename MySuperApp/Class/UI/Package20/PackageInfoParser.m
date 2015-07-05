//
//  PackageInfoParser.m
//  MyAimerApp
//
//  Created by 蒋博男 on 15-6-10.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "PackageInfoParser.h"

@implementation PackageSpecValueInfo
-(NSString*)sid
{
    return [[self attributeForKey:@"id"] description];
}
-(NSString*)spec_id
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [[self attributeForKey:[str substringToIndex:str.length - 1]] description];
}
-(NSString*)spec_value
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [[self attributeForKey:[str substringToIndex:str.length - 1]] description];
}
-(NSString*)spec_alias
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [[self attributeForKey:[str substringToIndex:str.length - 1]] description];
}
-(NSString*)imgurl
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [[self attributeForKey:[str substringToIndex:str.length - 1]] description];
}
@end

@implementation PackageSpecInfo
-(NSString*)sId
{
    return [[self attributeForKey:@"id"] description];
}
-(NSString*)spec_type
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [[self attributeForKey:[str substringToIndex:str.length - 1]] description];
}
-(NSString*)type
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [[self attributeForKey:[str substringToIndex:str.length - 1]] description];
}
-(NSString*)view_name
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [[self attributeForKey:[str substringToIndex:str.length - 1]] description];
}
@end

@implementation PackageProductInfo
-(NSString*)product_id
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [[self attributeForKey:[str substringToIndex:str.length - 1]] description];
}
-(NSInteger)count
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [[[self attributeForKey:[str substringToIndex:str.length - 1]] description] integerValue];
}
-(YKBaseEntity*)_spec_value_ids
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [self attributeForKey:[str substringToIndex:str.length - 1]];
}
@end

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
-(NSMutableArray*)products
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [self attributeForKey:[str substringToIndex:str.length - 1]];
}
-(NSArray*)specs
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [self attributeForKey:[str substringToIndex:str.length - 1]];
}
-(YKBaseEntity*)spec_values
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [self attributeForKey:[str substringToIndex:str.length - 1]];
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
-(BOOL)isOpen
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [[[self attributeForKey:[str substringToIndex:str.length - 1]] description] boolValue];
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
//    return [[self attributeForKey:@"id"] description];
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
                      @"goods" : @"PackageGoodsInfo",
                      @"specs" : @"PackageSpecInfo",
                      @"products" : @"PackageProductInfo"
                      };
    return [self parseDic:dic byKey:@"topkey"];

}
@end
