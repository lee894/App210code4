//
//  BrandsProductlistFilter.m
//
//  Created by malan  on 14-4-13
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "BrandsProductlistFilter.h"
#import "BrandsItems.h"


@interface BrandsProductlistFilter ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BrandsProductlistFilter

@synthesize group = _group;
@synthesize title = _title;
@synthesize items = _items;
@synthesize type = _type;
@synthesize typeidd = _typeidd;
@synthesize isOpenCell = _isOpenCell;


+ (BrandsProductlistFilter *)modelObjectWithDictionary:(NSDictionary *)dict
{
    BrandsProductlistFilter *instance = [[BrandsProductlistFilter alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        self.group = [[dict objectForKey:@"group"] intValue];
        self.title = [self objectOrNilForKey:@"title" fromDictionary:dict];
        NSObject *receivedBrandsItems = [dict objectForKey:@"items"];
        NSMutableArray *parsedBrandsItems = [NSMutableArray array];
        if ([receivedBrandsItems isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedBrandsItems) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedBrandsItems addObject:[BrandsItems modelObjectWithDictionary:item]];
                }
            }
        } else if ([receivedBrandsItems isKindOfClass:[NSDictionary class]]) {
            [parsedBrandsItems addObject:[BrandsItems modelObjectWithDictionary:(NSDictionary *)receivedBrandsItems]];
        }
        
        self.items = [NSArray arrayWithArray:parsedBrandsItems];
        self.type = [self objectOrNilForKey:@"type" fromDictionary:dict];
        self.typeidd = [[dict objectForKey:@"typeid"] intValue];
        
        
        self.isOpenCell = NO;
        
        
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
    [mutableDict setValue:[NSNumber numberWithDouble:self.typeidd] forKey:@"typeid"];

    [mutableDict setValue:NO forKey:@"isOpenCell"];

    
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
    self.typeidd = [aDecoder decodeDoubleForKey:@"typeid"];
    
    self.isOpenCell = [aDecoder decodeDoubleForKey:@"isOpenCell"];

    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_group forKey:@"group"];
    [aCoder encodeObject:_title forKey:@"title"];
    [aCoder encodeObject:_items forKey:@"items"];
    [aCoder encodeObject:_type forKey:@"type"];
    [aCoder encodeDouble:_typeidd forKey:@"typeid"];
    
    [aCoder encodeDouble:_isOpenCell forKey:@"isOpenCell"];

    
}

@end
