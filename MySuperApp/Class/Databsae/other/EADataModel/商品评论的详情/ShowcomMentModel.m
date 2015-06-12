//
//  ShowcomMentModel.m
//
//  Created by 昝驹  on 13-12-6
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "ShowcomMentModel.h"



NSString *const kShowcomMentModelPage = @"page";
NSString *const kShowcomMentModelRate = @"rate";
NSString *const kShowcomMentModelScore = @"score";
NSString *const kShowcomMentModelRateCount = @"rate_count";
NSString *const kShowcomMentModelTypename = @"typename";
NSString *const kShowcomMentModelPageSize = @"page_size";


@interface ShowcomMentModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ShowcomMentModel

@synthesize page = _page;
@synthesize rate = _rate;
@synthesize score = _score;
@synthesize rateCount = _rateCount;
@synthesize type_name = _type_name;
@synthesize pageSize = _pageSize;


@synthesize requestTag;
@synthesize errorMessage,response;



+ (ShowcomMentModel *)modelObjectWithDictionary:(NSDictionary *)dict
{
    ShowcomMentModel *instance = [[ShowcomMentModel alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.page = [self objectOrNilForKey:kShowcomMentModelPage fromDictionary:dict];
    NSObject *receivedShowcomMentRate = [dict objectForKey:kShowcomMentModelRate];
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
            self.score = [ShowcomMentScore modelObjectWithDictionary:[dict objectForKey:kShowcomMentModelScore]];
            self.rateCount = [self objectOrNilForKey:kShowcomMentModelRateCount fromDictionary:dict];
            self.type_name = [self objectOrNilForKey:kShowcomMentModelTypename fromDictionary:dict];
            self.pageSize = [[self objectOrNilForKey:kShowcomMentModelPageSize fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.page forKey:kShowcomMentModelPage];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForRate] forKey:@"kShowcomMentModelRate"];
    [mutableDict setValue:[self.score dictionaryRepresentation] forKey:kShowcomMentModelScore];
    [mutableDict setValue:self.rateCount forKey:kShowcomMentModelRateCount];
    [mutableDict setValue:self.type_name forKey:kShowcomMentModelTypename];
    [mutableDict setValue:[NSNumber numberWithDouble:self.pageSize] forKey:kShowcomMentModelPageSize];

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

    self.page = [aDecoder decodeObjectForKey:kShowcomMentModelPage];
    self.rate = [aDecoder decodeObjectForKey:kShowcomMentModelRate];
    self.score = [aDecoder decodeObjectForKey:kShowcomMentModelScore];
    self.rateCount = [aDecoder decodeObjectForKey:kShowcomMentModelRateCount];
    self.type_name = [aDecoder decodeObjectForKey:kShowcomMentModelTypename];
    self.pageSize = [aDecoder decodeDoubleForKey:kShowcomMentModelPageSize];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_page forKey:kShowcomMentModelPage];
    [aCoder encodeObject:_rate forKey:kShowcomMentModelRate];
    [aCoder encodeObject:_score forKey:kShowcomMentModelScore];
    [aCoder encodeObject:_rateCount forKey:kShowcomMentModelRateCount];
    [aCoder encodeObject:_type_name forKey:kShowcomMentModelTypename];
    [aCoder encodeDouble:_pageSize forKey:kShowcomMentModelPageSize];
}


@end
