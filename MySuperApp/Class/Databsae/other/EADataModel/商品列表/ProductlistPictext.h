//
//  ProductlistPictext.h
//
//  Created by malan  on 14-4-26
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Price, Price1;

@interface ProductlistPictext : NSObject <NSCoding>

@property (nonatomic, retain) NSString *productlistPictextIdentifier;
@property (nonatomic, retain) NSString *pic;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) Price *price;
@property (nonatomic, retain) Price1 *price1;

+ (ProductlistPictext *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
