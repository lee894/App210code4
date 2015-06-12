//
//  BrandsWall.m
//
//  Created by malan  on 14-4-26
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "BrandsWall.h"


@interface BrandsWall ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BrandsWall

@synthesize name = _name;
@synthesize brandsWallIdentifier = _brandsWallIdentifier;
@synthesize pic = _pic;


+ (BrandsWall *)modelObjectWithDictionary:(NSDictionary *)dict
{
    BrandsWall *instance = [[BrandsWall alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.name = [self objectOrNilForKey:@"name" fromDictionary:dict];
            self.brandsWallIdentifier = [self objectOrNilForKey:@"id" fromDictionary:dict];
            self.pic = [self objectOrNilForKey:@"pic" fromDictionary:dict];
            self.alias = [self objectOrNilForKey:@"alias" fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.name forKey:@"name"];
    [mutableDict setValue:self.brandsWallIdentifier forKey:@"id"];
    [mutableDict setValue:self.pic forKey:@"pic"];
    [mutableDict setValue:self.alias forKey:@"alias"];
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

    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.brandsWallIdentifier = [aDecoder decodeObjectForKey:@"brandsWallIdentifier"];
    self.pic = [aDecoder decodeObjectForKey:@"pic"];
    self.alias = [aDecoder decodeObjectForKey:@"alias"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_brandsWallIdentifier forKey:@"brandsWallIdentifier"];
    [aCoder encodeObject:_pic forKey:@"pic"];
    [aCoder encodeObject:_alias forKey:@"alias"];
}


@end
