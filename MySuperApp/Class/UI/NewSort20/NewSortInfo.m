//
//  NewSortInfo.m
//  MyAimerApp
//
//  Created by yanglee on 15/4/15.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "NewSortInfo.h"


@implementation NewFilterData

-(NSString*)ftype{
    return [[self attributeForKey:@"type"] description];
}

-(NSString*)name{
    return [[self attributeForKey:@"name"] description];
}
-(NSString*)value{
    return [[self attributeForKey:@"value"] description];
}

@end


@implementation NewSortData


-(NSString*)alias{
    return [[self attributeForKey:@"alias"] description];
}

-(NSString*)params{
    return [[self attributeForKey:@"params"] description];
}


-(NSString*)pic{
    return [[self attributeForKey:@"pic"] description];
}

@end


@implementation NewSortInfo


-(NSMutableArray*)woman{
    return [self attributeForKey:@"woman"];
}

-(NSMutableArray*)man{
    return [self attributeForKey:@"man"];
}

-(NSMutableArray*)girl{
    return [self attributeForKey:@"girl"];
}


-(NSMutableArray*)boy{
    return [self attributeForKey:@"boy"];
}

@end
