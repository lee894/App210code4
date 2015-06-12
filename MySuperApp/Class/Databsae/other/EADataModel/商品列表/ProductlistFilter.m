//
//  ProductlistFilter.m
//
//  Created by malan  on 14-4-26
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "ProductlistFilter.h"
#import "Items.h"


@interface ProductlistFilter ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ProductlistFilter

@synthesize group = _group;
@synthesize title = _title;
@synthesize items = _items;
@synthesize type = _type;
@synthesize typeid = _typeid;


+ (ProductlistFilter *)modelObjectWithDictionary:(NSDictionary *)dict
{
    ProductlistFilter *instance = [[ProductlistFilter alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.group = [[dict objectForKey:@"group"] doubleValue];
            self.title = [self objectOrNilForKey:@"title" fromDictionary:dict];
    NSObject *receivedItems = [dict objectForKey:@"items"];
    NSMutableArray *parsedItems = [NSMutableArray array];
    if ([receivedItems isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedItems) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedItems addObject:[Items modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedItems isKindOfClass:[NSDictionary class]]) {
       [parsedItems addObject:[Items modelObjectWithDictionary:(NSDictionary *)receivedItems]];
    }

    self.items = [NSArray arrayWithArray:parsedItems];
            self.type = [self objectOrNilForKey:@"type" fromDictionary:dict];
            self.typeid = [[dict objectForKey:@"typeid"] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.group] forKey:@"group"];
    [mutableDict setValue:self.title forKey:@"title"];
NSMutableArray *tempArrayForItems = [NSMutableArray array];
    for (NSObject *subArrayObject in self.items) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForItems addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForItems addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForItems] forKey:@"items"];
    [mutableDict setValue:self.type forKey:@"type"];
    [mutableDict setValue:[NSNumber numberWithDouble:self.typeid] forKey:@"typeid"];

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

    self.group = [aDecoder decodeDoubleForKey:@"group"];
    self.title = [aDecoder decodeObjectForKey:@"title"];
    self.items = [aDecoder decodeObjectForKey:@"items"];
    self.type = [aDecoder decodeObjectForKey:@"type"];
    self.typeid = [aDecoder decodeDoubleForKey:@"typeid"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_group forKey:@"group"];
    [aCoder encodeObject:_title forKey:@"title"];
    [aCoder encodeObject:_items forKey:@"items"];
    [aCoder encodeObject:_type forKey:@"type"];
    [aCoder encodeDouble:_typeid forKey:@"typeid"];
}


@end
