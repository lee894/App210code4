//
//  GetscouponModel.h
//
//  Created by malan  on 14-4-1
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBaseModel.h"


@interface GetscouponModel : LBaseModel <NSCoding>

@property (nonatomic, retain) NSArray *coupon;
@property (nonatomic, retain) NSString *response;

@property (nonatomic, assign) NSInteger requestTag;
@property (retain, nonatomic) NSString *errorMessage;

+ (GetscouponModel *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
