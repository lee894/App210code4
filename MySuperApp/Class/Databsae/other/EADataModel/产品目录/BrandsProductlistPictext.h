//
//  BrandsProductlistPictext.h
//
//  Created by malan  on 14-4-13
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BrandsPrice.h"
#import "BrandsPrice1.h"

@interface BrandsProductlistPictext : NSObject <NSCoding>

@property (nonatomic, retain) NSString *productlistPictextIdentifier;
@property (nonatomic, retain) NSString *pic;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) BrandsPrice *price;
@property (nonatomic, retain) BrandsPrice1 *price1;

@property (nonatomic, retain) NSString *image_file_path;


+ (BrandsProductlistPictext *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
