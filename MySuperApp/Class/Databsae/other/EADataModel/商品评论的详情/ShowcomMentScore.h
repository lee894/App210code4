//
//  ShowcomMentScore.h
//
//  Created by 昝驹  on 13-12-6
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ShowcomMentScore : NSObject <NSCoding>

@property (nonatomic, retain) NSString *chimaScore1;
@property (nonatomic, retain) NSString *waiguanScore;
@property (nonatomic, retain) NSString *chimaScore2;
@property (nonatomic, retain) NSString *chimaScore3;
@property (nonatomic, retain) NSString *zhaobeiScore1;
@property (nonatomic, retain) NSString *juScore1;
@property (nonatomic, retain) NSString *zongheScore;
@property (nonatomic, retain) NSString *zhaobeiScore2;
@property (nonatomic, retain) NSString *juScore2;
@property (nonatomic, retain) NSString *sushiduScore;
@property (nonatomic, retain) NSString *juScore3;
@property (nonatomic, retain) NSString *zhaobeiScore3;

+ (ShowcomMentScore *)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
