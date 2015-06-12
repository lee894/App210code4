//
//  LookCheckLookCheckModel.h
//
//  Created by malan  on 14-4-5
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LookCheckDetails.h"
#import "LBaseModel.h"


@interface LookCheckLookCheckModel : LBaseModel <NSCoding>

@property (nonatomic, retain) LookCheckDetails *details;
@property (nonatomic, retain) NSString *delivery_type;

@property (nonatomic, assign) int requestTag;
@property (retain, nonatomic) NSString *errorMessage;
@property (nonatomic, retain) NSString *response;

+ (LookCheckLookCheckModel *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
