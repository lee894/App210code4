//
//  LookCheckLookCheckModel.m
//
//  Created by malan  on 14-4-5
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "LookCheckLookCheckModel.h"



@interface LookCheckLookCheckModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LookCheckLookCheckModel

@synthesize details = _details;


@synthesize requestTag;
@synthesize errorMessage,response;

+ (LookCheckLookCheckModel *)modelObjectWithDictionary:(NSDictionary *)dict
{
    LookCheckLookCheckModel *instance = [[LookCheckLookCheckModel alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        self.delivery_type = [self objectOrNilForKey:@"delivery_type" fromDictionary:dict];
            self.details = [LookCheckDetails modelObjectWithDictionary:[dict objectForKey:@"details"]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.details dictionaryRepresentation] forKey:@"details"];

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

    self.details = [aDecoder decodeObjectForKey:@"details"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_details forKey:@"details"];
}

@end
