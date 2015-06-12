//
//  ProductlistPictext.m
//
//  Created by malan  on 14-4-26
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "ProductlistPictext.h"
#import "Price.h"
#import "Price1.h"


@interface ProductlistPictext ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ProductlistPictext

@synthesize productlistPictextIdentifier = _productlistPictextIdentifier;
@synthesize pic = _pic;
@synthesize name = _name;
@synthesize price = _price;
@synthesize price1 = _price1;


+ (ProductlistPictext *)modelObjectWithDictionary:(NSDictionary *)dict
{
    ProductlistPictext *instance = [[ProductlistPictext alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.productlistPictextIdentifier = [self objectOrNilForKey:@"id" fromDictionary:dict];
            self.pic = [self objectOrNilForKey:@"pic" fromDictionary:dict];
            self.name = [self objectOrNilForKey:@"name" fromDictionary:dict];
            self.price = [Price modelObjectWithDictionary:[dict objectForKey:@"price"]];
            self.price1 = [Price1 modelObjectWithDictionary:[dict objectForKey:@"price1"]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.productlistPictextIdentifier forKey:@"id"];
    [mutableDict setValue:self.pic forKey:@"pic"];
    [mutableDict setValue:self.name forKey:@"name"];
    [mutableDict setValue:[self.price dictionaryRepresentation] forKey:@"price"];
    [mutableDict setValue:[self.price1 dictionaryRepresentation] forKey:@"price1"];

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

    self.productlistPictextIdentifier = [aDecoder decodeObjectForKey:@"productlistPictextIdentifier"];
    self.pic = [aDecoder decodeObjectForKey:@"pic"];
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.price = [aDecoder decodeObjectForKey:@"price"];
    self.price1 = [aDecoder decodeObjectForKey:@"price1"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_productlistPictextIdentifier forKey:@"productlistPictextIdentifier"];
    [aCoder encodeObject:_pic forKey:@"pic"];
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_price forKey:@"price"];
    [aCoder encodeObject:_price1 forKey:@"price1"];
}


@end
