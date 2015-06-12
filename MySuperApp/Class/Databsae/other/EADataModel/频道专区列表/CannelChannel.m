//
//  CannelChannel.m
//
//  Created by malan  on 14-4-3
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "CannelChannel.h"


@interface CannelChannel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CannelChannel

@synthesize pic = _pic;
@synthesize categires = _categires;
@synthesize readme = _readme;


+ (CannelChannel *)modelObjectWithDictionary:(NSDictionary *)dict
{
    CannelChannel *instance = [[CannelChannel alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.pic = [self objectOrNilForKey:@"pic" fromDictionary:dict];
            self.categires = [CannelCategires modelObjectWithDictionary:[dict objectForKey:@"categires"]];
            self.readme = [self objectOrNilForKey:@"readme" fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.pic forKey:@"pic"];
    [mutableDict setValue:[self.categires dictionaryRepresentation] forKey:@"categires"];
    [mutableDict setValue:self.readme forKey:@"readme"];

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

    self.pic = [aDecoder decodeObjectForKey:@"pic"];
    self.categires = [aDecoder decodeObjectForKey:@"categires"];
    self.readme = [aDecoder decodeObjectForKey:@"readme"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_pic forKey:@"pic"];
    [aCoder encodeObject:_categires forKey:@"categires"];
    [aCoder encodeObject:_readme forKey:@"readme"];
}

@end
