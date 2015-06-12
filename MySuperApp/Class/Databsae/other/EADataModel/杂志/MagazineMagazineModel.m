//
//  MagazineMagazineModel.m
//
//  Created by malan  on 14-4-20
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "MagazineMagazineModel.h"



@interface MagazineMagazineModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MagazineMagazineModel

@synthesize magazineinfo = _magazineinfo;
@synthesize response = _response;
@synthesize background = _background;

@synthesize requestTag;
@synthesize errorMessage;


+ (MagazineMagazineModel *)modelObjectWithDictionary:(NSDictionary *)dict
{
    MagazineMagazineModel *instance = [[MagazineMagazineModel alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
    NSObject *receivedMagazineMagazineinfo = [dict objectForKey:@"magazineinfo"];
    NSMutableArray *parsedMagazineMagazineinfo = [NSMutableArray array];
    if ([receivedMagazineMagazineinfo isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedMagazineMagazineinfo) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedMagazineMagazineinfo addObject:[MagazineMagazineinfo modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedMagazineMagazineinfo isKindOfClass:[NSDictionary class]]) {
       [parsedMagazineMagazineinfo addObject:[MagazineMagazineinfo modelObjectWithDictionary:(NSDictionary *)receivedMagazineMagazineinfo]];
    }

    self.magazineinfo = [NSArray arrayWithArray:parsedMagazineMagazineinfo];
            self.response = [self objectOrNilForKey:@"response" fromDictionary:dict];
            self.background = [self objectOrNilForKey:@"background" fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
NSMutableArray *tempArrayForMagazineinfo = [NSMutableArray array];
    for (NSObject *subArrayObject in self.magazineinfo) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForMagazineinfo addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForMagazineinfo addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForMagazineinfo] forKey:@"magazineinfo"];
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

    self.magazineinfo = [aDecoder decodeObjectForKey:@"magazineinfo"];
    self.response = [aDecoder decodeObjectForKey:@"response"];
    self.background = [aDecoder decodeObjectForKey:@"background"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_magazineinfo forKey:@"magazineinfo"];
    [aCoder encodeObject:_response forKey:@"response"];
    [aCoder encodeObject:_background forKey:@"background"];
}


@end
