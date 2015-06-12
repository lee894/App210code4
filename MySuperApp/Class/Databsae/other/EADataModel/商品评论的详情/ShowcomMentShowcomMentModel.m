//
//  ShowcomMentShowcomMentModel.m
//
//  Created by malan  on 14-4-9
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "ShowcomMentShowcomMentModel.h"



NSString *const kShowcomMentShowcomMentModelScore = @"score";
NSString *const kShowcomMentShowcomMentModelRate = @"rate";


@interface ShowcomMentShowcomMentModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ShowcomMentShowcomMentModel

@synthesize score = _score;
@synthesize rate = _rate;

@synthesize requestTag;
@synthesize errorMessage;
@synthesize response;


+ (ShowcomMentShowcomMentModel *)modelObjectWithDictionary:(NSDictionary *)dict
{
    ShowcomMentShowcomMentModel *instance = [[ShowcomMentShowcomMentModel alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.score = [ShowcomMentScore modelObjectWithDictionary:[dict objectForKey:kShowcomMentShowcomMentModelScore]];
    NSObject *receivedShowcomMentRate = [dict objectForKey:kShowcomMentShowcomMentModelRate];
    NSMutableArray *parsedShowcomMentRate = [NSMutableArray array];
    if ([receivedShowcomMentRate isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedShowcomMentRate) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedShowcomMentRate addObject:[ShowcomMentRate modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedShowcomMentRate isKindOfClass:[NSDictionary class]]) {
       [parsedShowcomMentRate addObject:[ShowcomMentRate modelObjectWithDictionary:(NSDictionary *)receivedShowcomMentRate]];
    }

    self.rate = [NSArray arrayWithArray:parsedShowcomMentRate];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.score dictionaryRepresentation] forKey:kShowcomMentShowcomMentModelScore];
NSMutableArray *tempArrayForRate = [NSMutableArray array];
    for (NSObject *subArrayObject in self.rate) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForRate addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForRate addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForRate] forKey:@"kShowcomMentShowcomMentModelRate"];

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

    self.score = [aDecoder decodeObjectForKey:kShowcomMentShowcomMentModelScore];
    self.rate = [aDecoder decodeObjectForKey:kShowcomMentShowcomMentModelRate];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_score forKey:kShowcomMentShowcomMentModelScore];
    [aCoder encodeObject:_rate forKey:kShowcomMentShowcomMentModelRate];
}

@end
