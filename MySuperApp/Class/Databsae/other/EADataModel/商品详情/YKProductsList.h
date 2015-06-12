//
//  YKProductsList.h
//  YKProduct
//
//  Created by k ye on 11-12-27.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YKBaseEntityList.h"
#import "YKProductsItem.h"
@interface YKProductsList : YKBaseEntityList{

}
- (void)addProdcut:(YKProductsItem *)rProdcut;
@end
@interface YKColor_SizeList : YKBaseEntityList {

}
-(void)addColor_Size:(YKColor_Size*)rColor_Size;
@end
@interface YKBannerList : YKBaseEntityList {

}
-(void)addBanner:(YKBannerItem*)rBanner;

@end