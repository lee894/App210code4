//
//  ResetpassupResetpassupModel.m
//
//  Created by malan  on 14-4-30
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "ResetpassupResetpassupModel.h"


@interface ResetpassupResetpassupModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ResetpassupResetpassupModel

@synthesize response = _response;
@synthesize returnProperty = _returnProperty;


@synthesize requestTag;
@synthesize errorMessage;

+ (ResetpassupResetpassupModel *)modelObjectWithDictionary:(NSDictionary *)dict
{
    ResetpassupResetpassupModel *instance = [[ResetpassupResetpassupModel alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.response = [self objectOrNilForKey:@"response" fromDictionary:dict];
            self.returnProperty = [self objectOrNilForKey:@"return" fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.response forKey:@"response"];
    [mutableDict setValue:self.returnProperty forKey:@"return"];

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
    self.returnProperty = [aDecoder decodeObjectForKey:@"returnProperty"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_response forKey:@"response"];
    [aCoder encodeObject:_returnProperty forKey:@"returnProperty"];
}


@end
