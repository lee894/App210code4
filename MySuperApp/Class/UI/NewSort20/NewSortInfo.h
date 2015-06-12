//
//  NewSortInfo.h
//  MyAimerApp
//
//  Created by yanglee on 15/4/15.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "YKBaseEntity.h"


@interface NewFilterData : YKBaseEntity

-(NSString*)ftype;
-(NSString*)name;
-(NSString*)value;

@end


@interface NewSortData : YKBaseEntity

-(NSString*)alias;
-(NSString*)params;
-(NSString*)pic;

@end


@interface NewSortInfo : YKBaseEntity


-(NSMutableArray*)woman;
-(NSMutableArray*)man;
-(NSMutableArray*)girl;
-(NSMutableArray*)boy;

@end
