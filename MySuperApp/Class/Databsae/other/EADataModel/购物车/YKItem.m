//
//  YKItem.m
//  YKProduct
//
//  Created by caiting on 11-12-26.
//  Copyright 2011 yek. All rights reserved.
//

#import "YKItem.h"


@implementation YKItem
@synthesize productid,type,name,price,subtotal,color,size,number,value,imgurl,goodsid,strsave;
//lee999recode
//@synthesize rate_flag;
@synthesize strdiscountprice;
@synthesize arrSuit;
@synthesize stock;

@synthesize isSollection;


- (id) init
{
	self = [super init];
	if (self != nil) {
        arrSuit =[[NSMutableArray alloc] init];
	}
	return self;
}

@end
