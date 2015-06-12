//
//  NogiftsModel.m
//  MySuperApp
//
//  Created by bonan on 14-4-28.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "NogiftsModel.h"

@implementation NogiftsModel


@synthesize requestTag;
@synthesize errorMessage;

+ (NogiftsModel *)modelObjectWithDictionary:(NSDictionary *)dict{
    NogiftsModel *instance = [[NogiftsModel alloc] initWithDictionary:dict];
    return instance;

}
- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        
        _nogiftsItemArr = [[NSMutableArray alloc] init];
        
        self.strSelect = @"";
        
        NSArray *allKeys = [dict allKeys];
        
        for (int i = 0; i < allKeys.count; i++) {
            NSDictionary *dic = [dict objectForKey:[allKeys objectAtIndex:i]];
            
            if ([[allKeys objectAtIndex:i] isEqualToString:@"promotion_name"]||[[allKeys objectAtIndex:i] isEqualToString:@"actionname"]||[[allKeys objectAtIndex:i] isEqualToString:@"promotion_id"]||[[allKeys objectAtIndex:i] isEqualToString:@"select"]) {
                
                self.promotion_name = [dict objectForKey:@"promotion_name"];
                self.actionname = [dict objectForKey:@"actionname"];
                self.promotion_id = [dict objectForKey:@"promotion_id"];
                self.isSelect = [dict objectForKey:@"select"]?YES:NO;
                self.strSelect = [dict objectForKey:@"select"];
                continue;
            }
            
            NogiftsItem *nogifts = [[NogiftsItem alloc]init];
            nogifts.ids = [dic objectForKey:@"id"];
            nogifts.goos_name = [dic  objectForKey:@"goods_name"];
            nogifts.img_url = [dic  objectForKey:@"img_url"];
            
            [self.nogiftsItemArr addObject:nogifts];
        }

    }
    return self;
    
}


@end
