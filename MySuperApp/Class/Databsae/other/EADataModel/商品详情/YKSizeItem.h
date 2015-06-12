//
//  YKSizeItem.h
//  YKProduct
//
//  Created by k ye on 11-12-26.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YKBaseEntity.h"
@interface YKSizeItem : YKBaseEntity{

}
-(NSString*)ID;
-(void)setID:(NSString*)aID;
-(NSString*)Spec_id;
-(void)setSpec_id:(NSString*)aSpec_id;
-(NSString*)Spec_value;
-(void)setSpec_value:(NSString*)aSpec_value;
-(NSString*)Spec_alias;
-(void)setSpec_alias:(NSString*)aSpec_alias;
-(NSString*)ImageUrl;
-(void)setImageUrl:(NSString*)aImageUrl;
@end
