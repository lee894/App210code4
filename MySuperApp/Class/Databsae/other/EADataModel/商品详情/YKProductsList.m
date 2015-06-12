//
//  YKProductsList.m
//  YKProduct
//
//  Created by k ye on 11-12-27.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "YKProductsList.h"

@implementation YKProductsList
- (void)addProdcut:(YKProductsItem *)rProdcut{
     [self addObject:rProdcut];
}
@end
@implementation YKColor_SizeList



-(void)addColor_Size:(YKColor_Size*)rColor_Size{
     [self addObject:rColor_Size];
}
@end
@implementation YKBannerList
-(void)addBanner:(YKBannerItem*)rBanner{
     [self addObject:rBanner];
}

@end