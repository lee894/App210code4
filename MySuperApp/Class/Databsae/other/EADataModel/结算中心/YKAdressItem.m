//
//  YKAdressItem.m
//  YKProduct
//
//  Created by caiting on 11-12-29.
//  Copyright 2011 yek. All rights reserved.
//

#import "YKAdressItem.h"


@implementation YKAdressItem
@synthesize addressId,user_id,user_name,province_id,city_id,address,county_id,zip_code,phone,mobile,email,default_flag,province,city,county;
- (id) init
{
	self = [super init];
	if (self != nil) {
	}
	return self;
}
@end
