//
//  BindBindModel.h
//
//  Created by malan  on 14-4-4
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBaseModel.h"



@interface BindBindModel : LBaseModel <NSCoding>

@property (nonatomic, retain) NSString *response;
@property (nonatomic, retain) NSString *returnProperty;

@property (nonatomic, assign) int requestTag;
@property (retain, nonatomic) NSString *errorMessage;

+ (BindBindModel *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
