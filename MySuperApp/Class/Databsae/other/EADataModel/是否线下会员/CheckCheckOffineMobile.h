//
//  CheckCheckOffineMobile.h
//
//  Created by malan  on 14-4-9
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LBaseModel.h"

@interface CheckCheckOffineMobile : LBaseModel <NSCoding>

@property (nonatomic, retain) NSString *offline;
@property (nonatomic, retain) NSString *response;

@property (nonatomic, assign) int requestTag;
@property (retain, nonatomic) NSString *errorMessage;

+ (CheckCheckOffineMobile *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
