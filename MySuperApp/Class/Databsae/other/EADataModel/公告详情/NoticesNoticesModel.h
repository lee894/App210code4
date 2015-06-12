//
//  NoticesNoticesModel.h
//
//  Created by malan  on 14-4-15
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NoticesNotice.h"
#import "LBaseModel.h"

@interface NoticesNoticesModel : LBaseModel <NSCoding>

@property (nonatomic, retain) NSString *response;
@property (nonatomic, retain) NSArray *notice;

@property (nonatomic, assign) int requestTag;
@property (retain, nonatomic) NSString *errorMessage;

+ (NoticesNoticesModel *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
