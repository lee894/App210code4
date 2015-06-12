//
//  VersionVersionModel.m
//
//  Created by malan  on 14-4-14
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "VersionVersionModel.h"
#import "VersionVersion.h"
#import "VersionComment.h"


@interface VersionVersionModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation VersionVersionModel

@synthesize version = _version;
@synthesize response = _response;
@synthesize comment = _comment;

@synthesize requestTag;
@synthesize errorMessage;


+ (VersionVersionModel *)modelObjectWithDictionary:(NSDictionary *)dict
{
    VersionVersionModel *instance = [[VersionVersionModel alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.version = [VersionVersion modelObjectWithDictionary:[dict objectForKey:@"version"]];
            self.response = [self objectOrNilForKey:@"response" fromDictionary:dict];
            self.comment = [VersionComment modelObjectWithDictionary:[dict objectForKey:@"comment"]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.version dictionaryRepresentation] forKey:@"version"];
    [mutableDict setValue:self.response forKey:@"response"];
    [mutableDict setValue:[self.comment dictionaryRepresentation] forKey:@"comment"];

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

    self.version = [aDecoder decodeObjectForKey:@"version"];
    self.response = [aDecoder decodeObjectForKey:@"response"];
    self.comment = [aDecoder decodeObjectForKey:@"comment"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_version forKey:@"version"];
    [aCoder encodeObject:_response forKey:@"response"];
    [aCoder encodeObject:_comment forKey:@"comment"];
}


@end
