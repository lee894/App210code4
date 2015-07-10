//
//  AssessAssessModel.h
//
//  Created by malan  on 14-4-4
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AssessDetail.h"
#import "LBaseModel.h"

@interface AssessAssessModel : LBaseModel <NSCoding>

@property (nonatomic, assign) int number;
@property (nonatomic, retain) NSString *userName;
@property (nonatomic, retain) NSArray *detail;

@property (nonatomic, assign) NSInteger requestTag;
@property (retain, nonatomic) NSString *errorMessage;
@property (nonatomic, retain) NSString *response;

+ (AssessAssessModel *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
