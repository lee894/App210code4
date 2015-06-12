//
//  ShowcomMentScore.m
//
//  Created by 昝驹  on 13-12-6
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "ShowcomMentScore.h"


NSString *const kShowcomMentScoreChimaScore1 = @"chimaScore1";
NSString *const kShowcomMentScoreWaiguanScore = @"waiguanScore";
NSString *const kShowcomMentScoreChimaScore2 = @"chimaScore2";
NSString *const kShowcomMentScoreChimaScore3 = @"chimaScore3";
NSString *const kShowcomMentScoreZhaobeiScore1 = @"zhaobeiScore1";
NSString *const kShowcomMentScoreJuScore1 = @"juScore1";
NSString *const kShowcomMentScoreZongheScore = @"zongheScore";
NSString *const kShowcomMentScoreZhaobeiScore2 = @"zhaobeiScore2";
NSString *const kShowcomMentScoreJuScore2 = @"juScore2";
NSString *const kShowcomMentScoreSushiduScore = @"sushiduScore";
NSString *const kShowcomMentScoreJuScore3 = @"juScore3";
NSString *const kShowcomMentScoreZhaobeiScore3 = @"zhaobeiScore3";


@interface ShowcomMentScore ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ShowcomMentScore

@synthesize chimaScore1 = _chimaScore1;
@synthesize waiguanScore = _waiguanScore;
@synthesize chimaScore2 = _chimaScore2;
@synthesize chimaScore3 = _chimaScore3;
@synthesize zhaobeiScore1 = _zhaobeiScore1;
@synthesize juScore1 = _juScore1;
@synthesize zongheScore = _zongheScore;
@synthesize zhaobeiScore2 = _zhaobeiScore2;
@synthesize juScore2 = _juScore2;
@synthesize sushiduScore = _sushiduScore;
@synthesize juScore3 = _juScore3;
@synthesize zhaobeiScore3 = _zhaobeiScore3;


+ (ShowcomMentScore *)modelObjectWithDictionary:(NSDictionary *)dict
{
    ShowcomMentScore *instance = [[ShowcomMentScore alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.chimaScore1 = [self objectOrNilForKey:kShowcomMentScoreChimaScore1 fromDictionary:dict];
            self.waiguanScore = [self objectOrNilForKey:kShowcomMentScoreWaiguanScore fromDictionary:dict];
            self.chimaScore2 = [self objectOrNilForKey:kShowcomMentScoreChimaScore2 fromDictionary:dict];
            self.chimaScore3 = [self objectOrNilForKey:kShowcomMentScoreChimaScore3 fromDictionary:dict];
            self.zhaobeiScore1 = [self objectOrNilForKey:kShowcomMentScoreZhaobeiScore1 fromDictionary:dict];
            self.juScore1 = [self objectOrNilForKey:kShowcomMentScoreJuScore1 fromDictionary:dict];
            self.zongheScore = [self objectOrNilForKey:kShowcomMentScoreZongheScore fromDictionary:dict];
            self.zhaobeiScore2 = [self objectOrNilForKey:kShowcomMentScoreZhaobeiScore2 fromDictionary:dict];
            self.juScore2 = [self objectOrNilForKey:kShowcomMentScoreJuScore2 fromDictionary:dict];
            self.sushiduScore = [self objectOrNilForKey:kShowcomMentScoreSushiduScore fromDictionary:dict];
            self.juScore3 = [self objectOrNilForKey:kShowcomMentScoreJuScore3 fromDictionary:dict];
            self.zhaobeiScore3 = [self objectOrNilForKey:kShowcomMentScoreZhaobeiScore3 fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.chimaScore1 forKey:kShowcomMentScoreChimaScore1];
    [mutableDict setValue:self.waiguanScore forKey:kShowcomMentScoreWaiguanScore];
    [mutableDict setValue:self.chimaScore2 forKey:kShowcomMentScoreChimaScore2];
    [mutableDict setValue:self.chimaScore3 forKey:kShowcomMentScoreChimaScore3];
    [mutableDict setValue:self.zhaobeiScore1 forKey:kShowcomMentScoreZhaobeiScore1];
    [mutableDict setValue:self.juScore1 forKey:kShowcomMentScoreJuScore1];
    [mutableDict setValue:self.zongheScore forKey:kShowcomMentScoreZongheScore];
    [mutableDict setValue:self.zhaobeiScore2 forKey:kShowcomMentScoreZhaobeiScore2];
    [mutableDict setValue:self.juScore2 forKey:kShowcomMentScoreJuScore2];
    [mutableDict setValue:self.sushiduScore forKey:kShowcomMentScoreSushiduScore];
    [mutableDict setValue:self.juScore3 forKey:kShowcomMentScoreJuScore3];
    [mutableDict setValue:self.zhaobeiScore3 forKey:kShowcomMentScoreZhaobeiScore3];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.chimaScore1 = [aDecoder decodeObjectForKey:kShowcomMentScoreChimaScore1];
    self.waiguanScore = [aDecoder decodeObjectForKey:kShowcomMentScoreWaiguanScore];
    self.chimaScore2 = [aDecoder decodeObjectForKey:kShowcomMentScoreChimaScore2];
    self.chimaScore3 = [aDecoder decodeObjectForKey:kShowcomMentScoreChimaScore3];
    self.zhaobeiScore1 = [aDecoder decodeObjectForKey:kShowcomMentScoreZhaobeiScore1];
    self.juScore1 = [aDecoder decodeObjectForKey:kShowcomMentScoreJuScore1];
    self.zongheScore = [aDecoder decodeObjectForKey:kShowcomMentScoreZongheScore];
    self.zhaobeiScore2 = [aDecoder decodeObjectForKey:kShowcomMentScoreZhaobeiScore2];
    self.juScore2 = [aDecoder decodeObjectForKey:kShowcomMentScoreJuScore2];
    self.sushiduScore = [aDecoder decodeObjectForKey:kShowcomMentScoreSushiduScore];
    self.juScore3 = [aDecoder decodeObjectForKey:kShowcomMentScoreJuScore3];
    self.zhaobeiScore3 = [aDecoder decodeObjectForKey:kShowcomMentScoreZhaobeiScore3];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_chimaScore1 forKey:kShowcomMentScoreChimaScore1];
    [aCoder encodeObject:_waiguanScore forKey:kShowcomMentScoreWaiguanScore];
    [aCoder encodeObject:_chimaScore2 forKey:kShowcomMentScoreChimaScore2];
    [aCoder encodeObject:_chimaScore3 forKey:kShowcomMentScoreChimaScore3];
    [aCoder encodeObject:_zhaobeiScore1 forKey:kShowcomMentScoreZhaobeiScore1];
    [aCoder encodeObject:_juScore1 forKey:kShowcomMentScoreJuScore1];
    [aCoder encodeObject:_zongheScore forKey:kShowcomMentScoreZongheScore];
    [aCoder encodeObject:_zhaobeiScore2 forKey:kShowcomMentScoreZhaobeiScore2];
    [aCoder encodeObject:_juScore2 forKey:kShowcomMentScoreJuScore2];
    [aCoder encodeObject:_sushiduScore forKey:kShowcomMentScoreSushiduScore];
    [aCoder encodeObject:_juScore3 forKey:kShowcomMentScoreJuScore3];
    [aCoder encodeObject:_zhaobeiScore3 forKey:kShowcomMentScoreZhaobeiScore3];
}

@end
