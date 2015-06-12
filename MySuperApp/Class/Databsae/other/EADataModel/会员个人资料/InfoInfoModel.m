//
//  InfoInfoModel.m
//
//  Created by malan  on 14-4-29
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "InfoInfoModel.h"


@interface InfoInfoModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation InfoInfoModel

@synthesize brasize = _brasize;
@synthesize akSex2 = _akSex2;
@synthesize birthday = _birthday;
@synthesize position = _position;
@synthesize zipcode = _zipcode;
@synthesize underpants = _underpants;
@synthesize nickname = _nickname;
@synthesize child1Birthday = _child1Birthday;
@synthesize eduLevelArr = _eduLevelArr;
@synthesize brasizes = _brasizes;
@synthesize realname = _realname;
@synthesize akName2 = _akName2;
@synthesize gender = _gender;
@synthesize profession = _profession;
@synthesize email = _email;
@synthesize underpant = _underpant;
@synthesize mobile = _mobile;
@synthesize clothsizes = _clothsizes;
@synthesize marriageArr = _marriageArr;
@synthesize clothsize = _clothsize;
@synthesize validScore = _validScore;
@synthesize akSex1 = _akSex1;
@synthesize childHeight = _childHeight;
@synthesize income = _income;
@synthesize childBirthday = _childBirthday;
@synthesize address = _address;
@synthesize akName1 = _akName1;

@synthesize requestTag;
@synthesize errorMessage;
@synthesize response;


+ (InfoInfoModel *)modelObjectWithDictionary:(NSDictionary *)dict
{
    InfoInfoModel *instance = [[InfoInfoModel alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.brasize = [self objectOrNilForKey:@"brasize" fromDictionary:dict];
            self.akSex2 = [self objectOrNilForKey:@"ak_sex_2" fromDictionary:dict];
            self.birthday = [self objectOrNilForKey:@"birthday" fromDictionary:dict];
            self.position = [self objectOrNilForKey:@"position" fromDictionary:dict];
            self.zipcode = [self objectOrNilForKey:@"zipcode" fromDictionary:dict];
            self.underpants = [self objectOrNilForKey:@"underpants" fromDictionary:dict];
            self.nickname = [self objectOrNilForKey:@"nickname" fromDictionary:dict];
            self.child1Birthday = [self objectOrNilForKey:@"child1_birthday" fromDictionary:dict];
            self.eduLevelArr = [self objectOrNilForKey:@"edu_level_arr" fromDictionary:dict];
            self.brasizes = [self objectOrNilForKey:@"brasizes" fromDictionary:dict];
            self.realname = [self objectOrNilForKey:@"realname" fromDictionary:dict];
            self.akName2 = [self objectOrNilForKey:@"ak_name_2" fromDictionary:dict];
            self.gender = [self objectOrNilForKey:@"gender" fromDictionary:dict];
            self.profession = [self objectOrNilForKey:@"profession" fromDictionary:dict];
            self.email = [self objectOrNilForKey:@"email" fromDictionary:dict];
            self.underpant = [self objectOrNilForKey:@"underpant" fromDictionary:dict];
            self.mobile = [self objectOrNilForKey:@"mobile" fromDictionary:dict];
            self.clothsizes = [self objectOrNilForKey:@"clothsizes" fromDictionary:dict];
            self.marriageArr = [self objectOrNilForKey:@"marriage_arr" fromDictionary:dict];
            self.clothsize = [self objectOrNilForKey:@"clothsize" fromDictionary:dict];
            self.validScore = [self objectOrNilForKey:@"valid_score" fromDictionary:dict];
            self.akSex1 = [self objectOrNilForKey:@"ak_sex_1" fromDictionary:dict];
            self.childHeight = [self objectOrNilForKey:@"child_height" fromDictionary:dict];
            self.child2_height = [self objectOrNilForKey:@"child1_height" fromDictionary:dict];
            self.income = [self objectOrNilForKey:@"income" fromDictionary:dict];
            self.childBirthday = [self objectOrNilForKey:@"child_birthday" fromDictionary:dict];
            self.address = [self objectOrNilForKey:@"address" fromDictionary:dict];
            self.akName1 = [self objectOrNilForKey:@"ak_name_1" fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.brasize forKey:@"brasize"];
    [mutableDict setValue:self.akSex2 forKey:@"ak_sex_2"];
    [mutableDict setValue:self.birthday forKey:@"birthday"];
NSMutableArray *tempArrayForPosition = [NSMutableArray array];
    for (NSObject *subArrayObject in self.position) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForPosition addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForPosition addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForPosition] forKey:@"position"];
    [mutableDict setValue:self.zipcode forKey:@"zipcode"];
    [mutableDict setValue:self.underpants forKey:@"underpants"];
    [mutableDict setValue:self.nickname forKey:@"nickname"];
    [mutableDict setValue:self.child1Birthday forKey:@"child1_birthday"];
NSMutableArray *tempArrayForEduLevelArr = [NSMutableArray array];
    for (NSObject *subArrayObject in self.eduLevelArr) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForEduLevelArr addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForEduLevelArr addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForEduLevelArr] forKey:@"edu_level_arr"];
NSMutableArray *tempArrayForBrasizes = [NSMutableArray array];
    for (NSObject *subArrayObject in self.brasizes) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForBrasizes addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForBrasizes addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForBrasizes] forKey:@"brasizes"];
    [mutableDict setValue:self.realname forKey:@"realname"];
    [mutableDict setValue:self.akName2 forKey:@"ak_name_2"];
    [mutableDict setValue:self.gender forKey:@"gender"];
    [mutableDict setValue:self.profession forKey:@"profession"];
    [mutableDict setValue:self.email forKey:@"email"];
NSMutableArray *tempArrayForUnderpant = [NSMutableArray array];
    for (NSObject *subArrayObject in self.underpant) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForUnderpant addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForUnderpant addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForUnderpant] forKey:@"underpant"];
    [mutableDict setValue:self.mobile forKey:@"mobile"];
NSMutableArray *tempArrayForClothsizes = [NSMutableArray array];
    for (NSObject *subArrayObject in self.clothsizes) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForClothsizes addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForClothsizes addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForClothsizes] forKey:@"clothsizes"];
NSMutableArray *tempArrayForMarriageArr = [NSMutableArray array];
    for (NSObject *subArrayObject in self.marriageArr) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForMarriageArr addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForMarriageArr addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForMarriageArr] forKey:@"marriage_arr"];
    [mutableDict setValue:self.clothsize forKey:@"clothsize"];
    [mutableDict setValue:self.validScore forKey:@"valid_score"];
    [mutableDict setValue:self.akSex1 forKey:@"ak_sex_1"];
    [mutableDict setValue:self.childHeight forKey:@"child_height"];
    [mutableDict setValue:self.income forKey:@"income"];
    [mutableDict setValue:self.childBirthday forKey:@"child_birthday"];
    [mutableDict setValue:self.address forKey:@"address"];
    [mutableDict setValue:self.akName1 forKey:@"ak_name_1"];

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

    self.brasize = [aDecoder decodeObjectForKey:@"brasize"];
    self.akSex2 = [aDecoder decodeObjectForKey:@"akSex2"];
    self.birthday = [aDecoder decodeObjectForKey:@"birthday"];
    self.position = [aDecoder decodeObjectForKey:@"position"];
    self.zipcode = [aDecoder decodeObjectForKey:@"zipcode"];
    self.underpants = [aDecoder decodeObjectForKey:@"underpants"];
    self.nickname = [aDecoder decodeObjectForKey:@"nickname"];
    self.child1Birthday = [aDecoder decodeObjectForKey:@"child1Birthday"];
    self.eduLevelArr = [aDecoder decodeObjectForKey:@"eduLevelArr"];
    self.brasizes = [aDecoder decodeObjectForKey:@"brasizes"];
    self.realname = [aDecoder decodeObjectForKey:@"realname"];
    self.akName2 = [aDecoder decodeObjectForKey:@"akName2"];
    self.gender = [aDecoder decodeObjectForKey:@"gender"];
    self.profession = [aDecoder decodeObjectForKey:@"profession"];
    self.email = [aDecoder decodeObjectForKey:@"email"];
    self.underpant = [aDecoder decodeObjectForKey:@"underpant"];
    self.mobile = [aDecoder decodeObjectForKey:@"mobile"];
    self.clothsizes = [aDecoder decodeObjectForKey:@"clothsizes"];
    self.marriageArr = [aDecoder decodeObjectForKey:@"marriageArr"];
    self.clothsize = [aDecoder decodeObjectForKey:@"clothsize"];
    self.validScore = [aDecoder decodeObjectForKey:@"validScore"];
    self.akSex1 = [aDecoder decodeObjectForKey:@"akSex1"];
    self.childHeight = [aDecoder decodeObjectForKey:@"childHeight"];
    self.income = [aDecoder decodeObjectForKey:@"income"];
    self.childBirthday = [aDecoder decodeObjectForKey:@"childBirthday"];
    self.address = [aDecoder decodeObjectForKey:@"address"];
    self.akName1 = [aDecoder decodeObjectForKey:@"akName1"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_brasize forKey:@"brasize"];
    [aCoder encodeObject:_akSex2 forKey:@"akSex2"];
    [aCoder encodeObject:_birthday forKey:@"birthday"];
    [aCoder encodeObject:_position forKey:@"position"];
    [aCoder encodeObject:_zipcode forKey:@"zipcode"];
    [aCoder encodeObject:_underpants forKey:@"underpants"];
    [aCoder encodeObject:_nickname forKey:@"nickname"];
    [aCoder encodeObject:_child1Birthday forKey:@"child1Birthday"];
    [aCoder encodeObject:_eduLevelArr forKey:@"eduLevelArr"];
    [aCoder encodeObject:_brasizes forKey:@"brasizes"];
    [aCoder encodeObject:_realname forKey:@"realname"];
    [aCoder encodeObject:_akName2 forKey:@"akName2"];
    [aCoder encodeObject:_gender forKey:@"gender"];
    [aCoder encodeObject:_profession forKey:@"profession"];
    [aCoder encodeObject:_email forKey:@"email"];
    [aCoder encodeObject:_underpant forKey:@"underpant"];
    [aCoder encodeObject:_mobile forKey:@"mobile"];
    [aCoder encodeObject:_clothsizes forKey:@"clothsizes"];
    [aCoder encodeObject:_marriageArr forKey:@"marriageArr"];
    [aCoder encodeObject:_clothsize forKey:@"clothsize"];
    [aCoder encodeObject:_validScore forKey:@"validScore"];
    [aCoder encodeObject:_akSex1 forKey:@"akSex1"];
    [aCoder encodeObject:_childHeight forKey:@"childHeight"];
    [aCoder encodeObject:_income forKey:@"income"];
    [aCoder encodeObject:_childBirthday forKey:@"childBirthday"];
    [aCoder encodeObject:_address forKey:@"address"];
    [aCoder encodeObject:_akName1 forKey:@"akName1"];
}


@end
