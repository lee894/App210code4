//
//  BaseParser.h
//  paipaiiphone
//
//  Created by 蒋博男 on 14-8-25.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseParser : NSObject
{
    NSDictionary* dicClassNames;
}
@end

@interface BaseParser ()
-(id)parseDic:(NSDictionary*)dic byKey:(NSString*)key;
-(id)parseArray:(NSArray*)array byKey:(NSString*)key;
@end
