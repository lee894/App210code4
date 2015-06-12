//
//  YKRecommendItem.m
//  YKProduct
//
//  Created by k ye on 11-12-26.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "YKRecommendItem.h"

@implementation YKRecommendItem
-(NSString*)RecommendID{
     return  [self attributeForKey:@"id"];
}
-(void)setRecommendID:(NSString*)aRecommendID{
     [self setAttribute:aRecommendID forKey:@"id"];
}
-(NSString*)RecommendPic{
     return  [self attributeForKey:@"pic"];
}
-(void)setRecommendPic:(NSString*)aRecommendPic{
     [self setAttribute:aRecommendPic forKey:@"pic"];
}
@end
