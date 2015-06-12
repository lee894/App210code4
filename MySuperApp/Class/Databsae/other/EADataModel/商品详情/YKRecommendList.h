//
//  YKRecommendList.h
//  YKProduct
//
//  Created by k ye on 11-12-26.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YKBaseEntityList.h"
#import "YKRecommendItem.h"
@interface YKRecommendList : YKBaseEntityList{

}
- (void)addRecommend:(YKRecommendItem *)rRecommends;
@end
