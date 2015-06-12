//
//  BrandsTypes.m
//
//  Created by malan  on 14-4-13
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "BrandsTypes.h"


@interface BrandsTypes ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BrandsTypes

@synthesize nameType = _nameType;
@synthesize typeidd = _typeidd;


+ (BrandsTypes *)modelObjectWithDictionary:(NSDictionary *)dict
{
    BrandsTypes *instance = [[BrandsTypes alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.nameType = [self objectOrNilForKey:@"typename" fromDictionary:dict];
            self.typeidd= [[dict objectForKey:@"typeid"] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.nameType forKey:@"typename"];
    [mutableDict setValue:[NSNumber numberWithDouble:self.typeidd] forKey:@"typeid"];

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

    self.nameType = [aDecoder decodeObjectForKey:@"typename"];
    self.typeidd = [aDecoder decodeDoubleForKey:@"typeid"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_nameType forKey:@"typename"];
    [aCoder encodeDouble:_typeidd forKey:@"typeid"];
}

@end
