//
//  YKGiftItem.m
//  YKProduct
//
//  Created by caiting on 12-1-10.
//  Copyright 2012 yek. All rights reserved.
//

#import "YKGiftItem.h"


@implementation YKGiftItem
@synthesize productname,imageurl,price,colorArray,sizeArray,idArray,goodsid,promotion_id;
@synthesize sizeNameStr;
@synthesize colorNameStr;
@synthesize isSelect;
- (id) init
{
	colorArray = [[NSMutableArray alloc] init];
	sizeArray = [[NSMutableArray alloc] init];
	idArray = [[NSMutableArray alloc] init];
	self = [super init];
	if (self != nil) {
	}
	return self;
}
@end
