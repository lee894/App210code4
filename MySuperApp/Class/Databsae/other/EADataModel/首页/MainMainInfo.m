//
//  MainMainInfo.m
//
//  Created by malan  on 14-4-22
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "MainMainInfo.h"


@interface MainMainInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MainMainInfo

@synthesize nexttitle = _nexttitle;
@synthesize mainTitle = _mainTitle;
@synthesize mainInfoIdentifier = _mainInfoIdentifier;
@synthesize imgPath = _imgPath;
@synthesize typeArgu = _typeArgu;
@synthesize titleText = _titleText;
@synthesize type = _type;


+ (MainMainInfo *)modelObjectWithDictionary:(NSDictionary *)dict
{
    MainMainInfo *instance = [[MainMainInfo alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.nexttitle = [self objectOrNilForKey:@"nexttitle" fromDictionary:dict];
            self.mainTitle = [self objectOrNilForKey:@"main_title" fromDictionary:dict];
            self.mainInfoIdentifier = [self objectOrNilForKey:@"id" fromDictionary:dict];
            self.imgPath = [self objectOrNilForKey:@"img_path" fromDictionary:dict];
            self.typeArgu = [self objectOrNilForKey:@"type_argu" fromDictionary:dict];
            self.titleText = [self objectOrNilForKey:@"title_text" fromDictionary:dict];
            self.type = [self objectOrNilForKey:@"type" fromDictionary:dict];
    }
    return self;
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.nexttitle forKey:@"nexttitle"];
    [mutableDict setValue:self.mainTitle forKey:@"main_title"];
    [mutableDict setValue:self.mainInfoIdentifier forKey:@"id"];
    [mutableDict setValue:self.imgPath forKey:@"img_path"];
    [mutableDict setValue:self.typeArgu forKey:@"type_argu"];
    [mutableDict setValue:self.titleText forKey:@"title_text"];
    [mutableDict setValue:self.type forKey:@"type"];


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

    self.nexttitle = [aDecoder decodeObjectForKey:@"nexttitle"];
    self.mainTitle = [aDecoder decodeObjectForKey:@"mainTitle"];
    self.mainInfoIdentifier = [aDecoder decodeObjectForKey:@"mainInfoIdentifier"];
    self.imgPath = [aDecoder decodeObjectForKey:@"imgPath"];
    self.typeArgu = [aDecoder decodeObjectForKey:@"typeArgu"];
    self.titleText = [aDecoder decodeObjectForKey:@"titleText"];
    self.type = [aDecoder decodeObjectForKey:@"type"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_nexttitle forKey:@"nexttitle"];
    [aCoder encodeObject:_mainTitle forKey:@"mainTitle"];
    [aCoder encodeObject:_mainInfoIdentifier forKey:@"mainInfoIdentifier"];
    [aCoder encodeObject:_imgPath forKey:@"imgPath"];
    [aCoder encodeObject:_typeArgu forKey:@"typeArgu"];
    [aCoder encodeObject:_titleText forKey:@"titleText"];
    [aCoder encodeObject:_type forKey:@"type"];
}


@end
