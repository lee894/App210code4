//
//  BranddetailBranddetailModel.h
//
//  Created by malan  on 14-4-16
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BranddetailBrandDetail.h"
#import "LBaseModel.h"


@interface BranddetailBranddetailModel : LBaseModel <NSCoding>

@property (nonatomic, retain) NSArray *brandDetail;
@property (nonatomic, retain) NSString *response;

@property (nonatomic, assign) NSInteger requestTag;
@property (retain, nonatomic) NSString *errorMessage;

+ (BranddetailBranddetailModel *)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
