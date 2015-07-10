//
//  CounponupGetCounponupModel.h
//
//  Created by malan  on 14-4-22
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBaseModel.h"


@interface CounponupGetCounponupModel : LBaseModel <NSCoding>

@property (nonatomic, retain) NSString *amount;
@property (nonatomic, retain) NSString *response;
@property (nonatomic, retain) NSString *getmessage;


@property (nonatomic, assign) NSInteger requestTag;
@property (retain, nonatomic) NSString *errorMessage;


+ (CounponupGetCounponupModel *)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
