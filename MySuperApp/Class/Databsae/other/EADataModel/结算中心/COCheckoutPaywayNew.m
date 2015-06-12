//
//  COCheckoutPaywayNew.m
//
//  Created by malan  on 14-4-7
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "COCheckoutPaywayNew.h"


@interface COCheckoutPaywayNew ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation COCheckoutPaywayNew

@synthesize checkoutPaywayNewIdentifier = _checkoutPaywayNewIdentifier;
@synthesize desc = _desc;


+ (COCheckoutPaywayNew *)modelObjectWithDictionary:(NSDictionary *)dict
{
    COCheckoutPaywayNew *instance = [[COCheckoutPaywayNew alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.checkoutPaywayNewIdentifier = [[dict objectForKey:@"id"] doubleValue];
            self.desc = [self objectOrNilForKey:@"desc" fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.checkoutPaywayNewIdentifier] forKey:@"id"];
    [mutableDict setValue:self.desc forKey:@"desc"];

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

    self.checkoutPaywayNewIdentifier = [aDecoder decodeDoubleForKey:@"checkoutPaywayNewIdentifier"];
    self.desc = [aDecoder decodeObjectForKey:@"desc"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_checkoutPaywayNewIdentifier forKey:@"checkoutPaywayNewIdentifier"];
    [aCoder encodeObject:_desc forKey:@"desc"];
}

@end
