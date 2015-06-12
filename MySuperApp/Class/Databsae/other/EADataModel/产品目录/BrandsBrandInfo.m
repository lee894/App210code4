//
//  BrandsBrandInfo.m
//
//  Created by malan  on 14-4-13
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "BrandsBrandInfo.h"


@interface BrandsBrandInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BrandsBrandInfo

@synthesize memo = _memo;
@synthesize logo = _logo;


+ (BrandsBrandInfo *)modelObjectWithDictionary:(NSDictionary *)dict
{
    BrandsBrandInfo *instance = [[BrandsBrandInfo alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.memo = [self objectOrNilForKey:@"memo" fromDictionary:dict];
            self.logo = [self objectOrNilForKey:@"logo" fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.memo forKey:@"memo"];
    [mutableDict setValue:self.logo forKey:@"logo"];

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

    self.memo = [aDecoder decodeObjectForKey:@"memo"];
    self.logo = [aDecoder decodeObjectForKey:@"logo"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_memo forKey:@"memo"];
    [aCoder encodeObject:_logo forKey:@"logo"];
}

@end
