//
//  ResetpassupResetpassupModel.h
//
//  Created by malan  on 14-4-30
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBaseModel.h"


@interface ResetpassupResetpassupModel : LBaseModel <NSCoding>

@property (nonatomic, retain) NSString *response;
@property (nonatomic, retain) NSString *returnProperty;


@property (nonatomic, assign) NSInteger requestTag;
@property (retain, nonatomic) NSString *errorMessage;

+ (ResetpassupResetpassupModel *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
