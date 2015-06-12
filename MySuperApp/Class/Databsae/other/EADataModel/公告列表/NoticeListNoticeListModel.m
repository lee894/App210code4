//
//  NoticeListNoticeListModel.m
//
//  Created by malan  on 14-4-26
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "NoticeListNoticeListModel.h"

@interface NoticeListNoticeListModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation NoticeListNoticeListModel

@synthesize response = _response;
@synthesize notice = _notice;

@synthesize requestTag;
@synthesize errorMessage;


+ (NoticeListNoticeListModel *)modelObjectWithDictionary:(NSDictionary *)dict
{
    NoticeListNoticeListModel *instance = [[NoticeListNoticeListModel alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.response = [self objectOrNilForKey:@"response" fromDictionary:dict];
    NSObject *receivedNoticeListNotice = [dict objectForKey:@"notice"];
    NSMutableArray *parsedNoticeListNotice = [NSMutableArray array];
    if ([receivedNoticeListNotice isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedNoticeListNotice) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedNoticeListNotice addObject:[NoticeListNotice modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedNoticeListNotice isKindOfClass:[NSDictionary class]]) {
       [parsedNoticeListNotice addObject:[NoticeListNotice modelObjectWithDictionary:(NSDictionary *)receivedNoticeListNotice]];
    }

    self.notice = [NSArray arrayWithArray:parsedNoticeListNotice];

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
