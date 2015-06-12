//
//  COCheckoutProductlist.h
//
//  Created by malan  on 14-4-7
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface COCheckoutProductlist : NSObject <NSCoding>

@property (nonatomic, assign) double number;
@property (nonatomic, retain) NSString *imgurl;
@property (nonatomic, retain) NSString *color;
@property (nonatomic, retain) NSString *subtotal;
@property (nonatomic, retain) NSString *price;
@property (nonatomic, retain) NSString *size;
@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *productid;


+ (COCheckoutProductlist *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
