//
//  GetexchangescorerecordRecord.m
//
//  Created by malan  on 14-4-27
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "GetexchangescorerecordRecord.h"


@interface GetexchangescorerecordRecord ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation GetexchangescorerecordRecord

@synthesize recordIdentifier = _recordIdentifier;
@synthesize scoreSource = _scoreSource;
@synthesize userChangeScore = _userChangeScore;
@synthesize cardId = _cardId;
@synthesize userType = _userType;
@synthesize userId = _userId;
@synthesize createTime = _createTime;
@synthesize userChangeTicket = _userChangeTicket;


+ (GetexchangescorerecordRecord *)modelObjectWithDictionary:(NSDictionary *)dict
{
    GetexchangescorerecordRecord *instance = [[GetexchangescorerecordRecord alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.recordIdentifier = [self objectOrNilForKey:@"id" fromDictionary:dict];
            self.scoreSource = [self objectOrNilForKey:@"score_source" fromDictionary:dict];
            self.userChangeScore = [self objectOrNilForKey:@"user_change_score" fromDictionary:dict];
            self.cardId = [self objectOrNilForKey:@"card_id" fromDictionary:dict];
            self.userType = [self objectOrNilForKey:@"user_type" fromDictionary:dict];
            self.userId = [self objectOrNilForKey:@"user_id" fromDictionary:dict];
            self.createTime = [self objectOrNilForKey:@"create_time" fromDictionary:dict];
            self.userChangeTicket = [self objectOrNilForKey:@"user_change_ticket" fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.recordIdentifier forKey:@"id"];
    [mutableDict setValue:self.scoreSource forKey:@"score_source"];
    [mutableDict setValue:self.userChangeScore forKey:@"user_change_score"];
    [mutableDict setValue:self.cardId forKey:@"card_id"];
    [mutableDict setValue:self.userType forKey:@"user_type"];
    [mutableDict setValue:self.userId forKey:@"user_id"];
    [mutableDict setValue:self.createTime forKey:@"create_time"];
    [mutableDict setValue:self.userChangeTicket forKey:@"user_change_ticket"];

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

    self.recordIdentifier = [aDecoder decodeObjectForKey:@"recordIdentifier"];
    self.scoreSource = [aDecoder decodeObjectForKey:@"scoreSource"];
    self.userChangeScore = [aDecoder decodeObjectForKey:@"userChangeScore"];
    self.cardId = [aDecoder decodeObjectForKey:@"cardId"];
    self.userType = [aDecoder decodeObjectForKey:@"userType"];
    self.userId = [aDecoder decodeObjectForKey:@"userId"];
    self.createTime = [aDecoder decodeObjectForKey:@"createTime"];
    self.userChangeTicket = [aDecoder decodeObjectForKey:@"userChangeTicket"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_recordIdentifier forKey:@"recordIdentifier"];
    [aCoder encodeObject:_scoreSource forKey:@"scoreSource"];
    [aCoder encodeObject:_userChangeScore forKey:@"userChangeScore"];
    [aCoder encodeObject:_cardId forKey:@"cardId"];
    [aCoder encodeObject:_userType forKey:@"userType"];
    [aCoder encodeObject:_userId forKey:@"userId"];
    [aCoder encodeObject:_createTime forKey:@"createTime"];
    [aCoder encodeObject:_userChangeTicket forKey:@"userChangeTicket"];
}


@end
