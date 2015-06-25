//
//  YKItem.h
//  YKProduct
//
//  Created by caiting on 11-12-26.
//  Copyright 2011 yek. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface YKItem : NSObject {
	NSString* productid;
	NSString* goodsid;
	NSString* type;
	NSString* name;
	NSString* price;
	NSString* subtotal;
	NSString* color;
	NSString* size;
	NSString* number;
	NSString* imgurl;
    
    NSString* isSollection;
    
    NSString* strsave;
    NSString* strdiscountprice;
	NSArray * arrSuit;
	NSString* value;//借用一下item类

    NSString* stock;    //是否有货标识，字符串形式
    
}
@property(nonatomic,retain) NSString* strsave;
@property(nonatomic,retain) NSString* strdiscountprice;
@property(nonatomic,retain) NSArray * arrSuit;

@property(nonatomic,retain) NSString* productid;
@property(nonatomic,retain) NSString* type;
@property(nonatomic,retain) NSString* name;
@property(nonatomic,retain) NSString* price;
@property(nonatomic,retain) NSString* goodsid;
@property(nonatomic,retain) NSString* subtotal;
@property(nonatomic,retain) NSString* color;
@property(nonatomic,retain) NSString* size;
@property(nonatomic,retain) NSString* number;
@property(nonatomic,retain) NSString* imgurl;
@property (nonatomic, assign) NSInteger count;
@property(nonatomic,retain) NSString* value;
@property (nonatomic, assign) NSInteger score;
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, retain) NSString* uk;


@property(nonatomic,retain) NSString* isSollection;

//lee999recode
//@property (nonatomic, assign) BOOL rate_flag;

@property(nonatomic,retain) NSString* stock;

@property (nonatomic, retain) NSString *bn;

@end
