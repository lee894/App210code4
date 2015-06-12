//
//  YKSpecitem.h
//  YKProduct
//
//  Created by caiting on 12-1-10.
//  Copyright 2012 yek. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface YKSpecitem : NSObject {
	NSString* productid;
	NSString* spec_id;
	NSString* spec_value;
	NSString* spec_alias;
	NSString* imgurl;
}
@property(nonatomic,retain) NSString* productid;
@property(nonatomic,retain) NSString* spec_id;
@property(nonatomic,retain) NSString* spec_value;
@property(nonatomic,retain) NSString* spec_alias;
@property(nonatomic,retain) NSString* imgurl;
@end
