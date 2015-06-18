//
//  MyClosetListParser.m
//  MyAimerApp
//
//  Created by yanglee on 15/6/18.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "MyClosetListParser.h"


@implementation MyClosetPriceData 

-(NSString*)name{
    
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [self attributeForKey:[str substringToIndex:str.length - 1]];
}

-(NSString*)value{
    
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [self attributeForKey:[str substringToIndex:str.length - 1]];
}



@end



@implementation MyClosetitemData 

-(NSString*)aid{
    return [[self attributeForKey:@"id"] description];
}

-(NSString*)name{
    
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [self attributeForKey:[str substringToIndex:str.length - 1]];
}

-(NSString*)pic{
    
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [self attributeForKey:[str substringToIndex:str.length - 1]];
}

-(MyClosetPriceData*)price{
    
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [self attributeForKey:[str substringToIndex:str.length - 1]];
}

-(MyClosetPriceData*)price1{
    
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [self attributeForKey:[str substringToIndex:str.length - 1]];
}


@end


@implementation MyClosetListData 

-(NSString*)aid{
    return [[self attributeForKey:@"id"] description];
}

-(NSString*)name{
    
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [self attributeForKey:[str substringToIndex:str.length - 1]];
}


-(NSArray*)goods_list{
    
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [self attributeForKey:[str substringToIndex:str.length - 1]];
}


@end

@implementation MyClosetListInfo 

-(NSArray*)wardrobe_info{
    
    NSString* str = [[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] componentsSeparatedByString:@" "] lastObject];
    return [self attributeForKey:[str substringToIndex:str.length - 1]];
}



@end



@implementation MyClosetListParser


-(MyClosetListInfo *)parseClosetListInfo:(NSDictionary*)dic{

    dicClassNames = @{@"topkey" : @"MyClosetListInfo",
                      @"wardrobe_info" : @"MyClosetListData",
                      @"goods_list" : @"MyClosetitemData",
                      @"price" : @"MyClosetPriceData",
                      @"price" : @"MyClosetPriceData",

                      };
    return [self parseDic:dic byKey:@"topkey"];
    
}


@end
