//
//  FavoriteFavoritePic.m
//
//  Created by malan  on 14-4-19
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "FavoriteFavoritePic.h"


@interface FavoriteFavoritePic ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation FavoriteFavoritePic

@synthesize productid = _productid;
@synthesize pic = _pic;
@synthesize name = _name;
@synthesize price = _price;

@synthesize image_file_path = _image_file_path;


+ (FavoriteFavoritePic *)modelObjectWithDictionary:(NSDictionary *)dict
{
    FavoriteFavoritePic *instance = [[FavoriteFavoritePic alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.productid = [self objectOrNilForKey:@"productid" fromDictionary:dict];
            self.pic = [self objectOrNilForKey:@"pic" fromDictionary:dict];
            self.name = [self objectOrNilForKey:@"name" fromDictionary:dict];
            self.price = [self objectOrNilForKey:@"price" fromDictionary:dict];
            self.image_file_path = [self objectOrNilForKey:@"image_file_path" fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.productid forKey:@"productid"];
    [mutableDict setValue:self.pic forKey:@"pic"];
    [mutableDict setValue:self.name forKey:@"name"];
    [mutableDict setValue:self.price forKey:@"price"];
    [mutableDict setValue:self.image_file_path forKey:@"image_file_path"];


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

    self.productid = [aDecoder decodeObjectForKey:@"productid"];
    self.pic = [aDecoder decodeObjectForKey:@"pic"];
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.price = [aDecoder decodeObjectForKey:@"price"];
    self.image_file_path = [aDecoder decodeObjectForKey:@"image_file_path"];

    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_productid forKey:@"productid"];
    [aCoder encodeObject:_pic forKey:@"pic"];
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_price forKey:@"price"];
    [aCoder encodeObject:_image_file_path forKey:@"image_file_path"];

}

@end
