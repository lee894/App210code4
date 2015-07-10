//
//  VuserLoginVuserLoginModel.h
//
//  Created by malan  on 14-4-10
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBaseModel.h"


@interface VuserLoginVuserLoginModel : LBaseModel <NSCoding>

@property (nonatomic, retain) id res;
@property (nonatomic, retain) NSString *mobile;
@property (nonatomic, retain) NSString *response;


@property (nonatomic, assign) NSInteger requestTag;
@property (retain, nonatomic) NSString *errorMessage;

//lee999 新增字段
@property (retain, nonatomic) NSString *userssion;
//end

+ (VuserLoginVuserLoginModel *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
