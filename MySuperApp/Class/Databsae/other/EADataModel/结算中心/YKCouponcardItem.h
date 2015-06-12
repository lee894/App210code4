//
//  YKCouponcardItem.h
//  YKProduct
//
//  Created by caiting on 11-12-31.
//  Copyright 2011 yek. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface YKCouponcardItem : NSObject {
	NSString* code;
	NSString* stuatus;
	NSString* failtime;
	NSString* desc;
	NSString* title;
}
@property(nonatomic,retain) NSString* code;
@property(nonatomic,retain) NSString* stuatus;
@property(nonatomic,retain) NSString* failtime;
@property(nonatomic,retain) NSString* desc;
@property(nonatomic,retain) NSString* title;
@end
