//
//  FindPasswordFindPasswordModel.h
//
//  Created by malan  on 14-4-29
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBaseModel.h"


@interface FindPasswordFindPasswordModel :LBaseModel  <NSCoding>

@property (nonatomic, retain) NSString *content;
@property (nonatomic, retain) NSString *mobilenum;
@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) NSString *userId;


@property (nonatomic, assign) int requestTag;
@property (retain, nonatomic) NSString *errorMessage;

+ (FindPasswordFindPasswordModel *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
