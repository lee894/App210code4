//
//  YKRecommendItem.h
//  YKProduct
//
//  Created by k ye on 11-12-26.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YKBaseEntity.h"
@interface YKRecommendItem : YKBaseEntity{

}
-(NSString*)RecommendID;
-(void)setRecommendID:(NSString*)aRecommendID;
-(NSString*)RecommendPic;
-(void)setRecommendPic:(NSString*)aRecommendPic;    
@end
