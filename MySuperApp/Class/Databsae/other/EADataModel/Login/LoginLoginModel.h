//
//  LoginLoginModel.h
//
//  Created by malan  on 14-4-8
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginMore.h"
#import "LoginUserinfo.h"
#import "LBaseModel.h"

@interface LoginLoginModel : LBaseModel <NSCoding>

@property (nonatomic, retain) NSString *userssion;
@property (nonatomic, retain) NSString *userid;
@property (nonatomic, retain) NSString *response;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSArray *more;
@property (nonatomic, retain) NSString *vip;
@property (nonatomic, retain) LoginUserinfo *userinfo;
@property (nonatomic, assign) double shopcartcount;


@property (nonatomic, retain) NSString *userfaceurl;

@property (nonatomic, assign) NSInteger requestTag;
@property (retain, nonatomic) NSString *errorMessage;


+ (LoginLoginModel *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
