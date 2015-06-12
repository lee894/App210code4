//
//  NewFavInfo.m
//  MyAimerApp
//
//  Created by yanglee on 15/4/25.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "NewFavInfo.h"


@implementation NewFavStoreData

-(id)init
{
    if (self = [super init]) {
        self.type = 2;
    }
    return self;
}


-(NSString*)storeid{
    return [[self attributeForKey:@"id"] description];
}
-(NSString*)store_name{
    return [[self attributeForKey:@"store_name"] description];
}
-(NSString*)store_address{
    return [[self attributeForKey:@"store_address"] description];
}
-(NSString*)store_tel{
    return [[self attributeForKey:@"store_tel"] description];
}
-(NSString*)store_gpslng{
    return [[self attributeForKey:@"store_gpslng"] description];
}
-(NSString*)store_gpslat{
    return [[self attributeForKey:@"store_gpslat"] description];
}
-(NSString*)file_path{
    return [[self attributeForKey:@"file_path"] description];
}
-(NSString*)brand{
    return [[self attributeForKey:@"brand"] description];
}
-(NSString*)promotion_message{
    return [[self attributeForKey:@"promotion_message"] description];
}
-(NSString*)created{
    return [[self attributeForKey:@"created"] description];
}
-(NSString*)update_time{
    return [[self attributeForKey:@"update_time"] description];
}
-(NSString*)update_by{
    return [[self attributeForKey:@"update_by"] description];
}
-(NSString*)business_hours{
    return [[self attributeForKey:@"business_hours"] description];
}
-(NSString*)distance{
    return [[self attributeForKey:@"distance"] description];
}

-(NSString*)is_favorite{
    return [[self attributeForKey:@"is_favorite"] description];

}

@end






@implementation NewFavInfo

-(id)init
{
    if (self = [super init]) {
        self.type = 1;
    }
    return self;
}



-(NSString*)response{
    return [[self attributeForKey:@"response"] description];
}
-(NSString*)favtype{
    return [[self attributeForKey:@"type"] description];
}
-(NSString*)current_page{
    return [[self attributeForKey:@"current_page"] description];
}
-(NSString*)record_count{
    return [[self attributeForKey:@"record_count"] description];
}
-(NSString*)page_count{
    return [[self attributeForKey:@"page_count"] description];
}

-(NSMutableArray*)favorite_pic{
    return [self attributeForKey:@"favorite_pic"];
}
-(NSMutableArray*)favorite_stores{
    return [self attributeForKey:@"favorite_stores"];
}
-(NSMutableArray*)favorite_magazine{
    return [self attributeForKey:@"favorite_magazine"];
}


@end
