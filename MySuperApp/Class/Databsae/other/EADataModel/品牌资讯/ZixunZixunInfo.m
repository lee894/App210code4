//
//  ZixunZixunInfo.m
//
//  Created by malan  on 14-4-16
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "ZixunZixunInfo.h"


NSString *const kZixunZixunInfoNexttitle = @"nexttitle";
NSString *const kZixunZixunInfoMainTitle = @"main_title";
NSString *const kZixunZixunInfoId = @"id";
NSString *const kZixunZixunInfoImgPath = @"img_path";
NSString *const kZixunZixunInfoTypeArgu = @"type_argu";
NSString *const kZixunZixunInfoTitleText = @"title_text";
NSString *const kZixunZixunInfoType = @"type";


@interface ZixunZixunInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZixunZixunInfo

@synthesize nexttitle = _nexttitle;
@synthesize mainTitle = _mainTitle;
@synthesize zixunInfoIdentifier = _zixunInfoIdentifier;
@synthesize imgPath = _imgPath;
@synthesize typeArgu = _typeArgu;
@synthesize titleText = _titleText;
@synthesize type = _type;



+ (ZixunZixunInfo *)modelObjectWithDictionary:(NSDictionary *)dict
{
    ZixunZixunInfo *instance = [[ZixunZixunInfo alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.nexttitle = [self objectOrNilForKey:kZixunZixunInfoNexttitle fromDictionary:dict];
            self.mainTitle = [self objectOrNilForKey:kZixunZixunInfoMainTitle fromDictionary:dict];
            self.zixunInfoIdentifier = [self objectOrNilForKey:kZixunZixunInfoId fromDictionary:dict];
            self.imgPath = [self objectOrNilForKey:kZixunZixunInfoImgPath fromDictionary:dict];
            self.typeArgu = [self objectOrNilForKey:kZixunZixunInfoTypeArgu fromDictionary:dict];
            self.titleText = [self objectOrNilForKey:kZixunZixunInfoTitleText fromDictionary:dict];
            self.type = [self objectOrNilForKey:kZixunZixunInfoType fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.nexttitle forKey:kZixunZixunInfoNexttitle];
    [mutableDict setValue:self.mainTitle forKey:kZixunZixunInfoMainTitle];
    [mutableDict setValue:self.zixunInfoIdentifier forKey:kZixunZixunInfoId];
    [mutableDict setValue:self.imgPath forKey:kZixunZixunInfoImgPath];
    [mutableDict setValue:self.typeArgu forKey:kZixunZixunInfoTypeArgu];
    [mutableDict setValue:self.titleText forKey:kZixunZixunInfoTitleText];
    [mutableDict setValue:self.type forKey:kZixunZixunInfoType];

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

    self.nexttitle = [aDecoder decodeObjectForKey:kZixunZixunInfoNexttitle];
    self.mainTitle = [aDecoder decodeObjectForKey:kZixunZixunInfoMainTitle];
    self.zixunInfoIdentifier = [aDecoder decodeObjectForKey:kZixunZixunInfoId];
    self.imgPath = [aDecoder decodeObjectForKey:kZixunZixunInfoImgPath];
    self.typeArgu = [aDecoder decodeObjectForKey:kZixunZixunInfoTypeArgu];
    self.titleText = [aDecoder decodeObjectForKey:kZixunZixunInfoTitleText];
    self.type = [aDecoder decodeObjectForKey:kZixunZixunInfoType];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_nexttitle forKey:kZixunZixunInfoNexttitle];
    [aCoder encodeObject:_mainTitle forKey:kZixunZixunInfoMainTitle];
    [aCoder encodeObject:_zixunInfoIdentifier forKey:kZixunZixunInfoId];
    [aCoder encodeObject:_imgPath forKey:kZixunZixunInfoImgPath];
    [aCoder encodeObject:_typeArgu forKey:kZixunZixunInfoTypeArgu];
    [aCoder encodeObject:_titleText forKey:kZixunZixunInfoTitleText];
    [aCoder encodeObject:_type forKey:kZixunZixunInfoType];
}


@end
