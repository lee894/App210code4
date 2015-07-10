//
//  GetexchangescorerecordGetModel.h
//
//  Created by malan  on 14-4-27
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GetexchangescorerecordRecord.h"

#import "LBaseModel.h"
@interface GetexchangescorerecordGetModel : LBaseModel <NSCoding>

@property (nonatomic, retain) NSArray *record;
@property (nonatomic, retain) NSString *response;

@property (nonatomic, assign) NSInteger requestTag;
@property (retain, nonatomic) NSString *errorMessage;

+ (GetexchangescorerecordGetModel *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
