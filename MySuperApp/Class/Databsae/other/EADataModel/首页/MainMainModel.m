//
//  MainMainModel.m
//
//  Created by malan  on 14-4-22
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "MainMainModel.h"



@interface MainMainModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MainMainModel

@synthesize mainInfo = _mainInfo;
@synthesize response = _response;
@synthesize background = _background;

@synthesize requestTag;
@synthesize errorMessage;


+ (MainMainModel *)modelObjectWithDictionary:(NSDictionary *)dict
{
    MainMainModel *instance = [[MainMainModel alloc] initWithDictionary:dict];
    return instance;
}


- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
    NSObject *receivedMainMainInfo = [dict objectForKey:@"main_info"];
    NSMutableArray *parsedMainMainInfo = [NSMutableArray array];
    if ([receivedMainMainInfo isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedMainMainInfo) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedMainMainInfo addObject:[MainMainInfo modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedMainMainInfo isKindOfClass:[NSDictionary class]]) {
       [parsedMainMainInfo addObject:[MainMainInfo modelObjectWithDictionary:(NSDictionary *)receivedMainMainInfo]];
    }

    self.mainInfo = [NSArray arrayWithArray:parsedMainMainInfo];
            self.response = [self objectOrNilForKey:@"response" fromDictionary:dict];
            self.background = [self objectOrNilForKey:@"background" fromDictionary:dict];
        self.shopcartcount = [[self objectOrNilForKey:@"shopcartcount" fromDictionary:dict] intValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
NSMutableArray *tempArrayForMainInfo = [NSMutableArray array];
    for (NSObject *subArrayObject in self.mainInfo) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForMainInfo addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForMainInfo addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForMainInfo] forKey:@"main_info"];
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

    self.mainInfo = [aDecoder decodeObjectForKey:@"mainInfo"];
    self.response = [aDecoder decodeObjectForKey:@"response"];
    self.background = [aDecoder decodeObjectForKey:@"background"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_mainInfo forKey:@"mainInfo"];
    [aCoder encodeObject:_response forKey:@"response"];
    [aCoder encodeObject:_background forKey:@"background"];
}


@end
