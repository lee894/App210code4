//
//  PromvePromveMobileModel.h
//
//  Created by malan  on 14-4-10
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LBaseModel.h"

@interface PromvePromveMobileModel :LBaseModel  <NSCoding>

@property (nonatomic, retain) NSString *content;
@property (nonatomic, retain) NSString *mobile;
@property (nonatomic, retain) NSString *response;


@property (nonatomic, assign) NSInteger requestTag;
@property (retain, nonatomic) NSString *errorMessage;

+ (PromvePromveMobileModel *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
