//
//  VersionVersion.m
//
//  Created by malan  on 14-4-14
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "VersionVersion.h"


@interface VersionVersion ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation VersionVersion

@synthesize ver = _ver;
@synthesize newVer = _newVer;
@synthesize message = _message;
@synthesize url = _url;
@synthesize need = _need;


+ (VersionVersion *)modelObjectWithDictionary:(NSDictionary *)dict
{
    VersionVersion *instance = [[VersionVersion alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.ver = [self objectOrNilForKey:@"ver" fromDictionary:dict];
            self.newVer = [[dict objectForKey:@"new"] boolValue];
            self.message = [self objectOrNilForKey:@"message" fromDictionary:dict];
            self.url = [self objectOrNilForKey:@"url" fromDictionary:dict];
            self.need = [[dict objectForKey:@"need"] boolValue];

    }
    
    return self;
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.ver forKey:@"ver"];
    [mutableDict setValue:[NSNumber numberWithBool:self.newVer] forKey:@"new"];
    [mutableDict setValue:self.message forKey:@"message"];
    [mutableDict setValue:self.url forKey:@"url"];
    [mutableDict setValue:[NSNumber numberWithBool:self.need] forKey:@"need"];

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

    self.ver = [aDecoder decodeObjectForKey:@"ver"];
    self.newVer= [aDecoder decodeBoolForKey:@"new"];
    self.message = [aDecoder decodeObjectForKey:@"message"];
    self.url = [aDecoder decodeObjectForKey:@"url"];
    self.need = [aDecoder decodeBoolForKey:@"need"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_ver forKey:@"ver"];
    [aCoder encodeBool:_newVer forKey:@"new"];
    [aCoder encodeObject:_message forKey:@"message"];
    [aCoder encodeObject:_url forKey:@"url"];
    [aCoder encodeBool:_need forKey:@"need"];
}


@end
