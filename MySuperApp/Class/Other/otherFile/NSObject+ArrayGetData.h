//
//  NSObject+ArrayGetData.h
//  paipaiiphone
//
//  Created by JDMAC on 15-1-6.
//  Copyright (c) 2015年 lee. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ArrayBlock)(BOOL isArray,Class className);

typedef void(^DictionaryBlock)(BOOL isDictionary,Class className);

@interface NSObject (ArrayGetData)

-(id)objectAtIndex:(NSUInteger)index isArray:(ArrayBlock)block;

-(id)objectForKey:(NSString *)key isDictionary:(DictionaryBlock)block;

@end
