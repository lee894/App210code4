//
//  ChengeMyInfo.h
//  MySuperApp
//
//  Created by bonan on 14-4-9.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "LBaseModel.h"

@interface ChengeMyInfo : LBaseModel

@property (nonatomic, retain) NSString *res;
@property (nonatomic, retain) NSString *response;
@property (nonatomic, assign) NSInteger requestTag;
@property (retain, nonatomic) NSString *errorMessage;

+ (ChengeMyInfo *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;

@end
