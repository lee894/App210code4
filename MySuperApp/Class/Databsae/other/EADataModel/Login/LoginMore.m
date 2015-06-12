//
//  LoginMore.m
//
//  Created by malan  on 14-4-8
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "LoginMore.h"


@interface LoginMore ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LoginMore

@synthesize type = _type;
@synthesize value = _value;
@synthesize title = _title;


+ (LoginMore *)modelObjectWithDictionary:(NSDictionary *)dict
{
    LoginMore *instance = [[LoginMore alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.type = [[dict objectForKey:@"type"] doubleValue];
            self.value = [[dict objectForKey:@"value"] doubleValue];
            self.title = [self objectOrNilForKey:@"title" fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.type] forKey:@"type"];
    [mutableDict setValue:[NSNumber numberWithDouble:self.value] forKey:@"value"];
    [mutableDict setValue:self.title forKey:@"title"];

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

    self.type = [aDecoder decodeDoubleForKey:@"type"];
    self.value = [aDecoder decodeDoubleForKey:@"value"];
    self.title = [aDecoder decodeObjectForKey:@"title"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_type forKey:@"type"];
    [aCoder encodeDouble:_value forKey:@"value"];
    [aCoder encodeObject:_title forKey:@"title"];
}

@end
