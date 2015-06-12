//
//  ChaoliuChaoliuxinpinModel.m
//
//  Created by malan  on 14-4-13
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "ChaoliuChaoliuxinpinModel.h"


@interface ChaoliuChaoliuxinpinModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ChaoliuChaoliuxinpinModel

@synthesize chaoliuxinpinInfo = _chaoliuxinpinInfo;
@synthesize response = _response;
@synthesize background = _background;


@synthesize requestTag;
@synthesize errorMessage;

+ (ChaoliuChaoliuxinpinModel *)modelObjectWithDictionary:(NSDictionary *)dict
{
    ChaoliuChaoliuxinpinModel *instance = [[ChaoliuChaoliuxinpinModel alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        self.response = [self objectOrNilForKey:@"response" fromDictionary:dict];
        self.background = [self objectOrNilForKey:@"background" fromDictionary:dict];
    NSObject *receivedChaoliuChaoliuxinpinInfo = [dict objectForKey:@"chaoliuxinpin_info"];
    NSMutableArray *parsedChaoliuChaoliuxinpinInfo = [NSMutableArray array];
    if ([receivedChaoliuChaoliuxinpinInfo isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedChaoliuChaoliuxinpinInfo) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedChaoliuChaoliuxinpinInfo addObject:[ChaoliuChaoliuxinpinInfo modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedChaoliuChaoliuxinpinInfo isKindOfClass:[NSDictionary class]]) {
       [parsedChaoliuChaoliuxinpinInfo addObject:[ChaoliuChaoliuxinpinInfo modelObjectWithDictionary:(NSDictionary *)receivedChaoliuChaoliuxinpinInfo]];
    }

    self.chaoliuxinpinInfo = [NSArray arrayWithArray:parsedChaoliuChaoliuxinpinInfo];
    

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
NSMutableArray *tempArrayForChaoliuxinpinInfo = [NSMutableArray array];
    for (NSObject *subArrayObject in self.chaoliuxinpinInfo) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForChaoliuxinpinInfo addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForChaoliuxinpinInfo addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForChaoliuxinpinInfo] forKey:@"chaoliuxinpin_info"];
    [mutableDict setValue:self.response forKey:@"response"];
    [mutableDict setValue:self.background forKey:@"background"];

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

    self.chaoliuxinpinInfo = [aDecoder decodeObjectForKey:@"chaoliuxinpinInfo"];
    self.response = [aDecoder decodeObjectForKey:@"response"];
    self.background = [aDecoder decodeObjectForKey:@"background"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_chaoliuxinpinInfo forKey:@"chaoliuxinpinInfo"];
    [aCoder encodeObject:_response forKey:@"response"];
    [aCoder encodeObject:_background forKey:@"background"];
}

@end
