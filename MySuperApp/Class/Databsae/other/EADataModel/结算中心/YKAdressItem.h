//
//  YKAdressItem.h
//  YKProduct
//
//  Created by caiting on 11-12-29.
//  Copyright 2011 yek. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface YKAdressItem : NSObject {
	NSString* addressId;
	NSString* user_id;
	NSString* user_name;
	NSString* province_id;
	NSString* city_id;
	NSString* county_id;
	NSString* address;
	NSString* zip_code;
	NSString* phone;
	NSString* mobile;
	NSString* email;
	NSString* default_flag;
	NSString* province;
	NSString* city;
	NSString* county;
}
@property(nonatomic,retain) NSString* addressId;
@property(nonatomic,retain) NSString* user_id;
@property(nonatomic,retain) NSString* user_name;
@property(nonatomic,retain) NSString* province_id;
@property(nonatomic,retain) NSString* city_id;
@property(nonatomic,retain) NSString* county_id;
@property(nonatomic,retain) NSString* address;
@property(nonatomic,retain) NSString* zip_code;
@property(nonatomic,retain) NSString* phone;
@property(nonatomic,retain) NSString* mobile;
@property(nonatomic,retain) NSString* email;
@property(nonatomic,retain) NSString* default_flag;
@property(nonatomic,retain) NSString* province;
@property(nonatomic,retain) NSString* city;
@property(nonatomic,retain) NSString* county;
@end
