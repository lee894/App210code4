//
//  SuitListSuitlist.m
//
//  Created by malan  on 14-4-23
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "SuitListSuitlist.h"


@interface SuitListSuitlist ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SuitListSuitlist

@synthesize image_file_path = _image_file_path;
@synthesize name = _name;
@synthesize price = _price;
@synthesize suitid = _suitid;
@synthesize mkt_price = _mkt_price;
@synthesize pic = _pic;

+ (SuitListSuitlist *)modelObjectWithDictionary:(NSDictionary *)dict
{
    SuitListSuitlist *instance = [[SuitListSuitlist alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.image_file_path = [self objectOrNilForKey:@"image_file_path" fromDictionary:dict];
            self.name = [self objectOrNilForKey:@"name" fromDictionary:dict];
            self.price = [self objectOrNilForKey:@"price" fromDictionary:dict];
            self.suitid = [self objectOrNilForKey:@"suitid" fromDictionary:dict];
            self.mkt_price = [self objectOrNilForKey:@"mkt_price" fromDictionary:dict];
        
        self.pic = [self objectOrNilForKey:@"pic" fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.image_file_path forKey:@"image_file_path"];
    [mutableDict setValue:self.name forKey:@"name"];
    [mutableDict setValue:self.price forKey:@"price"];
    [mutableDict setValue:self.suitid forKey:@"suitid"];
    [mutableDict setValue:self.mkt_price forKey:@"mkt_price"];

    [mutableDict setValue:self.pic forKey:@"pic"];

    
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

    self.image_file_path = [aDecoder decodeObjectForKey:@"imageFilePath"];
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.price = [aDecoder decodeObjectForKey:@"price"];
    self.suitid = [aDecoder decodeObjectForKey:@"suitid"];
    
    self.pic = [aDecoder decodeObjectForKey:@"pic"];

    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_image_file_path forKey:@"imageFilePath"];
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_price forKey:@"price"];
    [aCoder encodeObject:_suitid forKey:@"suitid"];
    
    [aCoder encodeObject:_pic forKey:@"pic"];

}



@end
