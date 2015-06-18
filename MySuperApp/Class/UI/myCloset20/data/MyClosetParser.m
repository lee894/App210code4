//
//  MyClosetParser.m
//  MyAimerApp
//
//  Created by yanglee on 15/6/14.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "MyClosetParser.h"




@implementation MyClosetData

-(NSString*)value
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [[self attributeForKey:[str substringToIndex:str.length - 1]] description];
}

-(NSString*)wardrobe_name
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [[self attributeForKey:[str substringToIndex:str.length - 1]] description];
}

@end

@implementation MyClosetInfo


-(NSArray*)chuanyizhidao
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [self attributeForKey:[str substringToIndex:str.length - 1]];
}


-(NSArray*)style
{
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [self attributeForKey:[str substringToIndex:str.length - 1]];
}


@end



@implementation MyClosetParser

-(MyClosetInfo *)parseClosetInfo:(NSDictionary*)dic
{
    dicClassNames = @{@"topkey" : @"MyClosetInfo",
                      @"chuanyizhidao" : @"MyClosetData",
                      @"style" : @"MyClosetData",
                      };
    return [self parseDic:dic byKey:@"topkey"];
}

@end



@implementation MybespeakData

-(NSString*)aid{
    return [[self attributeForKey:@"id"] description];
}

-(NSString*)name{
    
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [self attributeForKey:[str substringToIndex:str.length - 1]];
}

@end


@implementation MybespeakInfo

-(NSArray*)stores{
    
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [self attributeForKey:[str substringToIndex:str.length - 1]];
}

@end

@implementation MybespeakParser

-(MybespeakInfo *)parsebespeakInfo:(NSDictionary*)dic{
    dicClassNames = @{@"topkey" : @"MybespeakInfo",
                      @"stores" : @"MybespeakData",
                      };
    return [self parseDic:dic byKey:@"topkey"];

}

@end


