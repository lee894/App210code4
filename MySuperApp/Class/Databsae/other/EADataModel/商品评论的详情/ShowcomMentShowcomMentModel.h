//
//  ShowcomMentShowcomMentModel.h
//
//  Created by malan  on 14-4-9
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBaseModel.h"
#import "ShowcomMentScore.h"
#import "ShowcomMentRate.h"

@interface ShowcomMentShowcomMentModel : LBaseModel <NSCoding>

@property (nonatomic, retain) ShowcomMentScore *score;
@property (nonatomic, retain) NSArray *rate;


@property (nonatomic, assign) int requestTag;
@property (retain, nonatomic) NSString *errorMessage;
@property (nonatomic, retain) NSString *response;


+ (ShowcomMentShowcomMentModel *)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
