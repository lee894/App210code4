//
//  YKGiftItem.h
//  YKProduct
//
//  Created by caiting on 12-1-10.
//  Copyright 2012 yek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YKGiftItem : NSObject {
	NSString* productname;
	NSString* imageurl;
	NSString* price;
	NSString* goodsid;
	NSString* promotion_id;
	NSMutableArray* colorArray;
	NSMutableArray* sizeArray;
	NSMutableArray* idArray;
}
@property(nonatomic,retain) NSString* productname;
@property(nonatomic,retain) NSString* imageurl;
@property(nonatomic,retain) NSString* price;

@property(nonatomic,retain) NSMutableArray* colorArray;
@property(nonatomic,retain) NSMutableArray* sizeArray;
@property(nonatomic,retain) NSMutableArray* idArray;

@property(nonatomic,retain) NSString* goodsid;
@property(nonatomic,retain) NSString* promotion_id;
@property (nonatomic, retain) NSString *colorNameStr;
@property (nonatomic, retain) NSString *sizeNameStr;
@property (nonatomic, assign) BOOL isSelect;


@end
