//
//  ShowcomMentRate.m
//
//  Created by 昝驹  on 13-12-6
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "ShowcomMentRate.h"


NSString *const kShowcomMentRateContent = @"content";
NSString *const kShowcomMentRateNickname = @"nickname";
NSString *const kShowcomMentRateCreated = @"created";


@interface ShowcomMentRate ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ShowcomMentRate

@synthesize content = _content;
@synthesize nickname = _nickname;
@synthesize created = _created;


+ (ShowcomMentRate *)modelObjectWithDictionary:(NSDictionary *)dict
{
    ShowcomMentRate *instance = [[ShowcomMentRate alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.content = [self objectOrNilForKey:kShowcomMentRateContent fromDictionary:dict];
            self.nickname = [self objectOrNilForKey:kShowcomMentRateNickname fromDictionary:dict];
            self.created = [self objectOrNilForKey:kShowcomMentRateCreated fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.content forKey:kShowcomMentRateContent];
    [mutableDict setValue:self.nickname forKey:kShowcomMentRateNickname];
    [mutableDict setValue:self.created forKey:kShowcomMentRateCreated];

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

    self.content = [aDecoder decodeObjectForKey:kShowcomMentRateContent];
    self.nickname = [aDecoder decodeObjectForKey:kShowcomMentRateNickname];
    self.created = [aDecoder decodeObjectForKey:kShowcomMentRateCreated];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_content forKey:kShowcomMentRateContent];
    [aCoder encodeObject:_nickname forKey:kShowcomMentRateNickname];
    [aCoder encodeObject:_created forKey:kShowcomMentRateCreated];
}

@end
