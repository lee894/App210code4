//
//  BaseParser.m
//  paipaiiphone
//
//  Created by 蒋博男 on 14-8-25.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "YKBaseEntity.h"
#import "BaseParser.h"

@implementation BaseParser
-(id)parseDic:(NSDictionary*)dic byKey:(NSString*)key{
    id<BaseEntityDelegate> result = nil;
    if ([dicClassNames objectForKey:key]) {
        Class  c = NSClassFromString([dicClassNames objectForKey:key]);
        if (c) {
            result = [[c alloc] init];
        }else{
            result = [[YKBaseEntity alloc] init];
        }
    }else
    {
        result = [[YKBaseEntity alloc] init];
    }
    NSArray* keys = [dic allKeys];
    
    //加入了 各类的解析类型 1列表 2对象
    
    for (int i = 0; i < [keys count]; ++i) {
        id item = [dic objectForKey:[keys objectAtIndex:i]];
        //        NSLog(@"%@", [keys objectAtIndex:i]);
        if ([item respondsToSelector:@selector(stringWithFormat:)])
        {
            [result setAttribute:item forKey:[keys objectAtIndex:i]];
        }
        else if ([item respondsToSelector:@selector(objectForKey:)])
        {
            [result setAttribute:[self parseDic:item byKey:[keys objectAtIndex:i]] forKey:[keys objectAtIndex:i]];
        }
        else if ([item respondsToSelector:@selector(removeLastObject)])
        {
            NSMutableArray* arr = [self parseArray:item byKey:[keys objectAtIndex:i]];
            [result setAttribute:arr forKey:[keys objectAtIndex:i]];
        }
        else if ([item class] != [NSNull class])
        {
            [result setAttribute:item forKey:[keys objectAtIndex:i]];
        }
        else
        {
            if ([dicClassNames objectForKey:[keys objectAtIndex:i]]) {
                Class c = NSClassFromString([dicClassNames objectForKey:[keys objectAtIndex:i]]);
                if (c) {
                    YKBaseEntity* temp = [[c alloc] init];
                    switch (temp.type) {
                        case 1:
                        {
                            NSMutableArray* arr = [[NSMutableArray alloc] initWithCapacity:1];
                            [result setAttribute:arr forKey:[keys objectAtIndex:i]];
                        }
                            break;
                        case 2:
                        {
                            [result setAttribute:temp forKey:[keys objectAtIndex:i]];
                        }
                            break;
                        default:
                            break;
                    }
                }
            }
            else
            {
                [result setAttribute:@"" forKey:[keys objectAtIndex:i]];
            }
        }
    }
    return result;
}

-(id)parseArray:(NSArray*)array byKey:(NSString*)key
{
    NSMutableArray* result = [[NSMutableArray alloc] initWithCapacity:1];
    for (int i = 0; i < [array count]; ++i) {
        id item = [array objectAtIndex:i];
        if ([item respondsToSelector:@selector(objectForKey:)]) {
            [result addObject:[self parseDic:item byKey:key]];
        }else if([item respondsToSelector:@selector(removeLastObject)])
        {
            [result addObject:[self parseArray:item byKey:key]];
        }else if([item respondsToSelector:@selector(stringWithFormat:)])
        {
            [result addObject:item];
        }
        else if([item class] != [NSNull class])
        {
            [result addObject:item];
        }
        else
        {
            [result addObject:@""];
        }
    }
    return result;
}

@end
