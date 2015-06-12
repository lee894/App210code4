//
//  NoticesNotice.m
//
//  Created by malan  on 14-4-15
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "NoticesNotice.h"


@interface NoticesNotice ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation NoticesNotice

@synthesize noticeIdentifier = _noticeIdentifier;
@synthesize content = _content;
@synthesize introduction = _introduction;
@synthesize title = _title;
@synthesize time = _time;
@synthesize imgUrl = _imgUrl;


+ (NoticesNotice *)modelObjectWithDictionary:(NSDictionary *)dict
{
    NoticesNotice *instance = [[NoticesNotice alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.noticeIdentifier = [self objectOrNilForKey:@"id" fromDictionary:dict];
            self.content = [self objectOrNilForKey:@"content" fromDictionary:dict];
            self.introduction = [self objectOrNilForKey:@"introduction" fromDictionary:dict];
            self.title = [self objectOrNilForKey:@"title" fromDictionary:dict];
            self.time = [self objectOrNilForKey:@"time" fromDictionary:dict];
            self.imgUrl = [self objectOrNilForKey:@"img_url" fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.noticeIdentifier forKey:@"id"];
    [mutableDict setValue:self.content forKey:@"content"];
    [mutableDict setValue:self.introduction forKey:@"introduction"];
    [mutableDict setValue:self.title forKey:@"title"];
    [mutableDict setValue:self.time forKey:@"time"];
    [mutableDict setValue:self.imgUrl forKey:@"img_url"];

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
    self.content = [aDecoder decodeObjectForKey:@"content"];
    self.introduction = [aDecoder decodeObjectForKey:@"introduction"];
    self.title = [aDecoder decodeObjectForKey:@"title"];
    self.time = [aDecoder decodeObjectForKey:@"time"];
    self.imgUrl = [aDecoder decodeObjectForKey:@"imgUrl"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_noticeIdentifier forKey:@"noticeIdentifier"];
    [aCoder encodeObject:_content forKey:@"content"];
    [aCoder encodeObject:_introduction forKey:@"introduction"];
    [aCoder encodeObject:_title forKey:@"title"];
    [aCoder encodeObject:_time forKey:@"time"];
    [aCoder encodeObject:_imgUrl forKey:@"imgUrl"];
}


@end
