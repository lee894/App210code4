//
//  COCheckoutProductlist.m
//
//  Created by malan  on 14-4-7
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "COCheckoutProductlist.h"


@interface COCheckoutProductlist ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation COCheckoutProductlist

@synthesize number = _number;
@synthesize imgurl = _imgurl;
@synthesize color = _color;
@synthesize subtotal = _subtotal;
@synthesize price = _price;
@synthesize size = _size;
@synthesize type = _type;
@synthesize name = _name;
@synthesize productid = _productid;


+ (COCheckoutProductlist *)modelObjectWithDictionary:(NSDictionary *)dict
{
    COCheckoutProductlist *instance = [[COCheckoutProductlist alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.number = [[dict objectForKey:@"number"] doubleValue];
            self.imgurl = [self objectOrNilForKey:@"imgurl" fromDictionary:dict];
            self.color = [self objectOrNilForKey:@"color" fromDictionary:dict];
            self.subtotal = [self objectOrNilForKey:@"subtotal" fromDictionary:dict];
            self.price = [self objectOrNilForKey:@"price" fromDictionary:dict];
            self.size = [self objectOrNilForKey:@"size" fromDictionary:dict];
            self.type = [self objectOrNilForKey:@"type" fromDictionary:dict];
            self.name = [self objectOrNilForKey:@"name" fromDictionary:dict];
            self.productid = [self objectOrNilForKey:@"productid" fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.number] forKey:@"number"];
    [mutableDict setValue:self.imgurl forKey:@"imgurl"];
    [mutableDict setValue:self.color forKey:@"color"];
    [mutableDict setValue:self.subtotal forKey:@"subtotal"];
    [mutableDict setValue:self.price forKey:@"price"];
    [mutableDict setValue:self.size forKey:@"size"];
    [mutableDict setValue:self.type forKey:@"type"];
    [mutableDict setValue:self.name forKey:@"name"];
    [mutableDict setValue:self.productid forKey:@"productid"];

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

    self.number = [aDecoder decodeDoubleForKey:@"number"];
    self.imgurl = [aDecoder decodeObjectForKey:@"imgurl"];
    self.color = [aDecoder decodeObjectForKey:@"color"];
    self.subtotal = [aDecoder decodeObjectForKey:@"subtotal"];
    self.price = [aDecoder decodeObjectForKey:@"price"];
    self.size = [aDecoder decodeObjectForKey:@"size"];
    self.type = [aDecoder decodeObjectForKey:@"type"];
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.productid = [aDecoder decodeObjectForKey:@"productid"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_number forKey:@"number"];
    [aCoder encodeObject:_imgurl forKey:@"imgurl"];
    [aCoder encodeObject:_color forKey:@"color"];
    [aCoder encodeObject:_subtotal forKey:@"subtotal"];
    [aCoder encodeObject:_price forKey:@"price"];
    [aCoder encodeObject:_size forKey:@"size"];
    [aCoder encodeObject:_type forKey:@"type"];
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_productid forKey:@"productid"];
}

@end
