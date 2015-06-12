//
//  CannelCategoriesPictext.m
//
//  Created by malan  on 14-4-3
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "CannelCategoriesPictext.h"


@interface CannelCategoriesPictext ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CannelCategoriesPictext

@synthesize subCategories = _subCategories;
@synthesize categoriesPictextIdentifier = _categoriesPictextIdentifier;
@synthesize pic = _pic;
@synthesize title = _title;
@synthesize english = _english;
@synthesize parentId = _parentId;
@synthesize isleafnode = _isleafnode;


+ (CannelCategoriesPictext *)modelObjectWithDictionary:(NSDictionary *)dict
{
    CannelCategoriesPictext *instance = [[CannelCategoriesPictext alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.subCategories = [self objectOrNilForKey:@"sub_categories" fromDictionary:dict];
            self.categoriesPictextIdentifier = [self objectOrNilForKey:@"id" fromDictionary:dict];
            self.pic = [self objectOrNilForKey:@"pic" fromDictionary:dict];
            self.title = [self objectOrNilForKey:@"title" fromDictionary:dict];
            self.english = [self objectOrNilForKey:@"english" fromDictionary:dict];
            self.parentId = [self objectOrNilForKey:@"parent_id" fromDictionary:dict];
            self.isleafnode = [[dict objectForKey:@"isleafnode"] boolValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
NSMutableArray *tempArrayForSubCategories = [NSMutableArray array];
    for (NSObject *subArrayObject in self.subCategories) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForSubCategories addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForSubCategories addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForSubCategories] forKey:@"sub_categories"];
    [mutableDict setValue:self.categoriesPictextIdentifier forKey:@"id"];
    [mutableDict setValue:self.pic forKey:@"pic"];
    [mutableDict setValue:self.title forKey:@"title"];
    [mutableDict setValue:self.english forKey:@"english"];
    [mutableDict setValue:self.parentId forKey:@"parent_id"];
    [mutableDict setValue:[NSNumber numberWithBool:self.isleafnode] forKey:@"isleafnode"];

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

    self.subCategories = [aDecoder decodeObjectForKey:@"subCategories"];
    self.categoriesPictextIdentifier = [aDecoder decodeObjectForKey:@"categoriesPictextIdentifier"];
    self.pic = [aDecoder decodeObjectForKey:@"pic"];
    self.title = [aDecoder decodeObjectForKey:@"title"];
    self.english = [aDecoder decodeObjectForKey:@"english"];
    self.parentId = [aDecoder decodeObjectForKey:@"parentId"];
    self.isleafnode = [aDecoder decodeBoolForKey:@"isleafnode"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_subCategories forKey:@"subCategories"];
    [aCoder encodeObject:_categoriesPictextIdentifier forKey:@"categoriesPictextIdentifier"];
    [aCoder encodeObject:_pic forKey:@"pic"];
    [aCoder encodeObject:_title forKey:@"title"];
    [aCoder encodeObject:_english forKey:@"english"];
    [aCoder encodeObject:_parentId forKey:@"parentId"];
    [aCoder encodeBool:_isleafnode forKey:@"isleafnode"];
}

@end
