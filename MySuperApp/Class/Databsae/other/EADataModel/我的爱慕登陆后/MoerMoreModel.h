//
//  MoerMoreModel.h
//
//  Created by malan  on 14-4-15
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MoerMore.h"
#import "MoerUserinfo.h"
#import "LBaseModel.h"

@interface MoerMoreModel : LBaseModel <NSCoding>

@property (nonatomic, retain) NSString *response;
@property (nonatomic, assign) BOOL islogin;
@property (nonatomic, retain) NSArray *more;
@property (nonatomic, retain) MoerUserinfo *userinfo;


@property (nonatomic, assign) int requestTag;
@property (retain, nonatomic) NSString *errorMessage;

+ (MoerMoreModel *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
