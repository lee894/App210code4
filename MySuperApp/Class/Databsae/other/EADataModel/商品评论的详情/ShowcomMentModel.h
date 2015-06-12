//
//  ShowcomMentModel.h
//
//  Created by 昝驹  on 13-12-6
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBaseModel.h"
#import "ShowcomMentRate.h"
#import "ShowcomMentScore.h"

@interface ShowcomMentModel : LBaseModel <NSCoding>

@property (nonatomic, retain) NSString *page;
@property (nonatomic, retain) NSArray *rate;
@property (nonatomic, retain) ShowcomMentScore *score;
@property (nonatomic, retain) NSString *rateCount;
@property (nonatomic, retain) NSString *type_name;
@property (nonatomic, assign) double pageSize;

@property (nonatomic, assign) int requestTag;
@property (retain, nonatomic) NSString *errorMessage;
@property (nonatomic, retain) NSString *response;


+ (ShowcomMentModel *)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
