//
//  UpdatepwdupdatepwdModel.h
//
//  Created by malan  on 14-4-26
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LBaseModel.h"

@interface UpdatepwdupdatepwdModel : LBaseModel <NSCoding>

@property (nonatomic, retain) NSString *res;
@property (nonatomic, retain) NSString *response;

@property (nonatomic, assign) NSInteger requestTag;
@property (retain, nonatomic) NSString *errorMessage;

+ (UpdatepwdupdatepwdModel *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
