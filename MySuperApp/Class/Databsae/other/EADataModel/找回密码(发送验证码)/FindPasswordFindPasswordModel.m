//
//  FindPasswordFindPasswordModel.m
//
//  Created by malan  on 14-4-29
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "FindPasswordFindPasswordModel.h"


@interface FindPasswordFindPasswordModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation FindPasswordFindPasswordModel

@synthesize content = _content;
@synthesize mobilenum = _mobilenum;
@synthesize type = _type;
@synthesize userId = _userId;


@synthesize requestTag;
@synthesize errorMessage;

+ (FindPasswordFindPasswordModel *)modelObjectWithDictionary:(NSDictionary *)dict
{
    FindPasswordFindPasswordModel *instance = [[FindPasswordFindPasswordModel alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.content = [self objectOrNilForKey:@"content" fromDictionary:dict];
            self.mobilenum = [self objectOrNilForKey:@"mobilenum" fromDictionary:dict];
            self.type = [self objectOrNilForKey:@"type" fromDictionary:dict];
            self.userId = [self objectOrNilForKey:@"user_id" fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.content forKey:@"content"];
    [mutableDict setValue:self.mobilenum forKey:@"mobilenum"];
    [mutableDict setValue:self.type forKey:@"type"];
    [mutableDict setValue:self.userId forKey:@"user_id"];

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

    self.content = [aDecoder decodeObjectForKey:@"content"];
    self.mobilenum = [aDecoder decodeObjectForKey:@"mobilenum"];
    self.type = [aDecoder decodeObjectForKey:@"type"];
    self.userId = [aDecoder decodeObjectForKey:@"userId"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_content forKey:@"content"];
    [aCoder encodeObject:_mobilenum forKey:@"mobilenum"];
    [aCoder encodeObject:_type forKey:@"type"];
    [aCoder encodeObject:_userId forKey:@"userId"];
}


@end
