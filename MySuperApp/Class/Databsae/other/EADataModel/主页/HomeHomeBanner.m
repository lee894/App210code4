//
//  HomeHomeBanner.m
//
//  Created by malan  on 14-4-12
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "HomeHomeBanner.h"


@interface HomeHomeBanner ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation HomeHomeBanner

@synthesize homeBannerIdentifier = _homeBannerIdentifier;
@synthesize title = _title;
@synthesize pic = _pic;
@synthesize type = _type;
@synthesize nexttitle = _nexttitle;
@synthesize typeArgu = _typeArgu;


+ (HomeHomeBanner *)modelObjectWithDictionary:(NSDictionary *)dict
{
    HomeHomeBanner *instance = [[HomeHomeBanner alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.homeBannerIdentifier = [self objectOrNilForKey:@"id" fromDictionary:dict];
            self.title = [self objectOrNilForKey:@"title" fromDictionary:dict];
            self.pic = [self objectOrNilForKey:@"pic" fromDictionary:dict];
            self.type = [self objectOrNilForKey:@"type" fromDictionary:dict];
            self.nexttitle = [self objectOrNilForKey:@"nexttitle" fromDictionary:dict];
            self.typeArgu = [self objectOrNilForKey:@"type_argu" fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.homeBannerIdentifier forKey:@"id"];
    [mutableDict setValue:self.title forKey:@"title"];
    [mutableDict setValue:self.pic forKey:@"pic"];
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

    self.homeBannerIdentifier = [aDecoder decodeObjectForKey:@"homeBannerIdentifier"];
    self.title = [aDecoder decodeObjectForKey:@"title"];
    self.pic = [aDecoder decodeObjectForKey:@"pic"];
    self.type = [aDecoder decodeObjectForKey:@"type"];
    self.nexttitle = [aDecoder decodeObjectForKey:@"nexttitle"];
    self.typeArgu = [aDecoder decodeObjectForKey:@"typeArgu"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_homeBannerIdentifier forKey:@"homeBannerIdentifier"];
    [aCoder encodeObject:_title forKey:@"title"];
    [aCoder encodeObject:_pic forKey:@"pic"];
    [aCoder encodeObject:_type forKey:@"type"];
    [aCoder encodeObject:_nexttitle forKey:@"nexttitle"];
    [aCoder encodeObject:_typeArgu forKey:@"typeArgu"];
}


@end
