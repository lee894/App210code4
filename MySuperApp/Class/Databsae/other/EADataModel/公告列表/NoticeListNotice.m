//
//  NoticeListNotice.m
//
//  Created by malan  on 14-4-26
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "NoticeListNotice.h"


@interface NoticeListNotice ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation NoticeListNotice

@synthesize noticeIdentifier = _noticeIdentifier;
@synthesize title = _title;
@synthesize introduction = _introduction;
@synthesize content = _content;
@synthesize time = _time;


+ (NoticeListNotice *)modelObjectWithDictionary:(NSDictionary *)dict
{
    NoticeListNotice *instance = [[NoticeListNotice alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.noticeIdentifier = [self objectOrNilForKey:@"id" fromDictionary:dict];
            self.title = [self objectOrNilForKey:@"title" fromDictionary:dict];
            self.introduction = [self objectOrNilForKey:@"introduction" fromDictionary:dict];
            self.content = [self objectOrNilForKey:@"content" fromDictionary:dict];
            self.time = [self objectOrNilForKey:@"time" fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.noticeIdentifier forKey:@"id"];
    [mutableDict setValue:self.title forKey:@"title"];
    [mutableDict setValue:self.introduction forKey:@"introduction"];
    [mutableDict setValue:self.content forKey:@"content"];
    [mutableDict setValue:self.time forKey:@"time"];

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

    self.noticeIdentifier = [aDecoder decodeObjectForKey:@"noticeIdentifier"];
    self.title = [aDecoder decodeObjectForKey:@"title"];
    self.introduction = [aDecoder decodeObjectForKey:@"introduction"];
    self.content = [aDecoder decodeObjectForKey:@"content"];
    self.time = [aDecoder decodeObjectForKey:@"time"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_noticeIdentifier forKey:@"noticeIdentifier"];
    [aCoder encodeObject:_title forKey:@"title"];
    [aCoder encodeObject:_introduction forKey:@"introduction"];
    [aCoder encodeObject:_content forKey:@"content"];
    [aCoder encodeObject:_time forKey:@"time"];
}


@end
