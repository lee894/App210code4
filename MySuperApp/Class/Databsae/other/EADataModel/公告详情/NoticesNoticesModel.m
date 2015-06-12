//
//  NoticesNoticesModel.m
//
//  Created by malan  on 14-4-15
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "NoticesNoticesModel.h"



@interface NoticesNoticesModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation NoticesNoticesModel

@synthesize response = _response;
@synthesize notice = _notice;

@synthesize requestTag;
@synthesize errorMessage;


+ (NoticesNoticesModel *)modelObjectWithDictionary:(NSDictionary *)dict
{
    NoticesNoticesModel *instance = [[NoticesNoticesModel alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.response = [self objectOrNilForKey:@"response" fromDictionary:dict];
    NSObject *receivedNoticesNotice = [dict objectForKey:@"notice"];
    NSMutableArray *parsedNoticesNotice = [NSMutableArray array];
    if ([receivedNoticesNotice isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedNoticesNotice) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedNoticesNotice addObject:[NoticesNotice modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedNoticesNotice isKindOfClass:[NSDictionary class]]) {
       [parsedNoticesNotice addObject:[NoticesNotice modelObjectWithDictionary:(NSDictionary *)receivedNoticesNotice]];
    }

    self.notice = [NSArray arrayWithArray:parsedNoticesNotice];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.response forKey:@"response"];
NSMutableArray *tempArrayForNotice = [NSMutableArray array];
    for (NSObject *subArrayObject in self.notice) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForNotice addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForNotice addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForNotice] forKey:@"notice"];

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

    self.response = [aDecoder decodeObjectForKey:@"response"];
    self.notice = [aDecoder decodeObjectForKey:@"notice"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_response forKey:@"response"];
    [aCoder encodeObject:_notice forKey:@"notice"];
}

@end
