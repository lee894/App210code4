//
//  MyClosetParser.h
//  MyAimerApp
//
//  Created by yanglee on 15/6/14.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "YKBaseEntity.h"
#import "BaseParser.h"
//#import "MyClosetInfo.h"

@interface MyClosetData: YKBaseEntity

-(NSString*)value;
-(NSString*)wardrobe_name;

@end

@interface MyClosetInfo : YKBaseEntity

-(NSArray*)chuanyizhidao;
-(NSArray*)style;

@end


@interface MyClosetParser : BaseParser

-(MyClosetInfo *)parseClosetInfo:(NSDictionary*)dic;

@end


//---------------------------------//


@interface MybespeakData : YKBaseEntity

-(NSString*)aid;
-(NSString*)name;

@end


@interface MybespeakInfo : YKBaseEntity

-(NSArray*)stores;

@end

@interface MybespeakParser : BaseParser

-(MybespeakInfo *)parsebespeakInfo:(NSDictionary*)dic;

@end