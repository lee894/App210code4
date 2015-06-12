//
//  CategoriesPictext.m
//
//  Created by malan  on 14-4-26
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "CategoriesPictext.h"


@interface CategoriesPictext ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CategoriesPictext

@synthesize parentId = _parentId;
@synthesize categoriesPictextIdentifier = _categoriesPictextIdentifier;
@synthesize title = _title;
@synthesize pic = _pic;
@synthesize isleafnode = _isleafnode;
@synthesize english = _english;


+ (CategoriesPictext *)modelObjectWithDictionary:(NSDictionary *)dict
{

    CategoriesPictext *instance = [[CategoriesPictext alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.parentId = [self objectOrNilForKey:@"parent_id" fromDictionary:dict];
            self.categoriesPictextIdentifier = [self objectOrNilForKey:@"id" fromDictionary:dict];
            self.title = [self objectOrNilForKey:@"title" fromDictionary:dict];
            self.pic = [self objectOrNilForKey:@"pic" fromDictionary:dict];
            self.isleafnode = [self objectOrNilForKey:@"isleafnode" fromDictionary:dict];
            self.english = [self objectOrNilForKey:@"english" fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.parentId forKey:@"parent_id"];
    [mutableDict setValue:self.categoriesPictextIdentifier forKey:@"id"];
    [mutableDict setValue:self.title forKey:@"title"];
    [mutableDict setValue:self.pic forKey:@"pic"];
    [mutableDict setValue:self.isleafnode forKey:@"isleafnode"];
    [mutableDict setValue:self.english forKey:@"english"];

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

    self.parentId = [aDecoder decodeObjectForKey:@"parentId"];
    self.categoriesPictextIdentifier = [aDecoder decodeObjectForKey:@"categoriesPictextIdentifier"];
    self.title = [aDecoder decodeObjectForKey:@"title"];
    self.pic = [aDecoder decodeObjectForKey:@"pic"];
    self.isleafnode = [aDecoder decodeObjectForKey:@"isleafnode"];
    self.english = [aDecoder decodeObjectForKey:@"english"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_parentId forKey:@"parentId"];
    [aCoder encodeObject:_categoriesPictextIdentifier forKey:@"categoriesPictextIdentifier"];
    [aCoder encodeObject:_title forKey:@"title"];
    [aCoder encodeObject:_pic forKey:@"pic"];
    [aCoder encodeObject:_isleafnode forKey:@"isleafnode"];
    [aCoder encodeObject:_english forKey:@"english"];
}


@end
