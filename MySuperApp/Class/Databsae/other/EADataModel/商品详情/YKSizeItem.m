//
//  YKSizeItem.m
//  YKProduct
//
//  Created by k ye on 11-12-26.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "YKSizeItem.h"

@implementation YKSizeItem
-(NSString*)ID{
     return [self attributeForKey:@"id"];
}
-(void)setID:(NSString*)aID{
     [self setAttribute:aID forKey:@"id"];
}
-(NSString*)Spec_id{
     return [self attributeForKey:@"spec_id"];
}
-(void)setSpec_id:(NSString*)aSpec_id{
     [self setAttribute:aSpec_id forKey:@"spec_id"];
}
-(NSString*)Spec_value{
     return [self attributeForKey:@"spec_value"];
}
-(void)setSpec_value:(NSString*)aSpec_value{
     [self setAttribute:aSpec_value forKey:@"spec_value"];
}
-(NSString*)Spec_alias{
     return [self attributeForKey:@"spec_alias"];
}
-(void)setSpec_alias:(NSString*)aSpec_alias{
     [self setAttribute:aSpec_alias forKey:@"spec_alias"];
}
-(NSString*)ImageUrl{
     return [self attributeForKey:@"imgurl"];
}
-(void)setImageUrl:(NSString*)aImageUrl{
     [self setAttribute:aImageUrl forKey:@"imgurl"];
}
@end
