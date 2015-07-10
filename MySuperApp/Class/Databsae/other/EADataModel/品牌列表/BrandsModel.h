//
//  BrandsModel.h
//
//  Created by malan  on 14-4-26
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BrandsWall.h"
#import "LBaseModel.h"

@interface BrandsModel : LBaseModel <NSCoding>

@property (nonatomic, strong) NSString *response;
@property (nonatomic, strong) NSArray *brandsWall;

@property (nonatomic, assign) NSInteger requestTag;
@property (retain, nonatomic) NSString *errorMessage;

+ (BrandsModel *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
