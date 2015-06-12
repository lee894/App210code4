//
//  HomeHomeTestBanner.m
//
//  Created by malan  on 14-4-12
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "HomeHomeTestBanner.h"


@interface HomeHomeTestBanner ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation HomeHomeTestBanner

@synthesize homeTestBannerIdentifier = _homeTestBannerIdentifier;
@synthesize title = _title;
@synthesize newpic = _newpic;
@synthesize type = _type;
@synthesize nexttitle = _nexttitle;
@synthesize typeArgu = _typeArgu;


+ (HomeHomeTestBanner *)modelObjectWithDictionary:(NSDictionary *)dict
{
    HomeHomeTestBanner *instance = [[HomeHomeTestBanner alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.homeTestBannerIdentifier = [self objectOrNilForKey:@"id" fromDictionary:dict];
            self.title = [self objectOrNilForKey:@"title" fromDictionary:dict];
            self.newpic = [self objectOrNilForKey:@"newpic" fromDictionary:dict];
            self.type = [self objectOrNilForKey:@"type" fromDictionary:dict];
            self.nexttitle = [self objectOrNilForKey:@"nexttitle" fromDictionary:dict];
            self.typeArgu = [self objectOrNilForKey:@"type_argu" fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.homeTestBannerIdentifier forKey:@"id"];
    [mutableDict setValue:self.title forKey:@"title"];
    [mutableDict setValue:self.newpic forKey:@"newpic"];
    [mutableDict setValue:self.type forKey:@"type"];
    [mutableDict setValue:self.nexttitle forKey:@"nexttitle"];
    [mutableDict setValue:self.typeArgu forKey:@"type_argu"];

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

    self.homeTestBannerIdentifier = [aDecoder decodeObjectForKey:@"homeTestBannerIdentifier"];
    self.title = [aDecoder decodeObjectForKey:@"title"];
    self.newpic = [aDecoder decodeObjectForKey:@"newpic"];
    self.type = [aDecoder decodeObjectForKey:@"type"];
    self.nexttitle = [aDecoder decodeObjectForKey:@"nexttitle"];
    self.typeArgu = [aDecoder decodeObjectForKey:@"typeArgu"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_homeTestBannerIdentifier forKey:@"homeTestBannerIdentifier"];
    [aCoder encodeObject:_title forKey:@"title"];
    [aCoder encodeObject:_type forKey:@"type"];
    [aCoder encodeObject:_newpic forKey:@"newpic"];
    [aCoder encodeObject:_nexttitle forKey:@"nexttitle"];
    [aCoder encodeObject:_typeArgu forKey:@"typeArgu"];
}


@end
