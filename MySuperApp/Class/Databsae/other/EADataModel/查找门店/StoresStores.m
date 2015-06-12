//
//  StoresStores.m
//
//  Created by malan  on 14-4-27
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "StoresStores.h"


@interface StoresStores ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation StoresStores

@synthesize storeGpslng = _storeGpslng;
@synthesize storeAddress = _storeAddress;
@synthesize storeTel = _storeTel;
@synthesize storesIdentifier = _storesIdentifier;
@synthesize storeGpslat = _storeGpslat;
@synthesize filePath = _filePath;
@synthesize storeName = _storeName;
@synthesize brand = _brand;


@synthesize storeid;
@synthesize promotion_message;
@synthesize created;
@synthesize update_time;
@synthesize business_hours;
@synthesize distance;
@synthesize is_favorite;


+ (StoresStores *)modelObjectWithDictionary:(NSDictionary *)dict
{
    StoresStores *instance = [[StoresStores alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.storeGpslng = [self objectOrNilForKey:@"store_gpslng" fromDictionary:dict];
            self.storeAddress = [self objectOrNilForKey:@"store_address" fromDictionary:dict];
            self.storeTel = [self objectOrNilForKey:@"store_tel" fromDictionary:dict];
            self.storesIdentifier = [self objectOrNilForKey:@"id" fromDictionary:dict];
            self.storeGpslat = [self objectOrNilForKey:@"store_gpslat" fromDictionary:dict];
            self.filePath = [self objectOrNilForKey:@"file_path" fromDictionary:dict];
            self.storeName = [self objectOrNilForKey:@"store_name" fromDictionary:dict];
            self.brand = [self objectOrNilForKey:@"brand" fromDictionary:dict];

        
        self.storeid = [self objectOrNilForKey:@"id" fromDictionary:dict];
        self.promotion_message = [self objectOrNilForKey:@"promotion_message" fromDictionary:dict];
        self.created = [self objectOrNilForKey:@"created" fromDictionary:dict];
        self.update_time = [self objectOrNilForKey:@"update_time" fromDictionary:dict];
        self.business_hours = [self objectOrNilForKey:@"business_hours" fromDictionary:dict];
        self.distance = [self objectOrNilForKey:@"distance" fromDictionary:dict];
        self.is_favorite = [self objectOrNilForKey:@"is_favorite" fromDictionary:dict];


        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.storeGpslng forKey:@"store_gpslng"];
    [mutableDict setValue:self.storeAddress forKey:@"store_address"];
    [mutableDict setValue:self.storeTel forKey:@"store_tel"];
    [mutableDict setValue:self.storesIdentifier forKey:@"id"];
    [mutableDict setValue:self.storeGpslat forKey:@"store_gpslat"];
    [mutableDict setValue:self.filePath forKey:@"file_path"];
    [mutableDict setValue:self.storeName forKey:@"store_name"];
    [mutableDict setValue:self.brand forKey:@"brand"];
    
    
    [mutableDict setValue:self.storeid forKey:@"id"];
    [mutableDict setValue:self.promotion_message forKey:@"promotion_message"];
    [mutableDict setValue:self.created forKey:@"created"];
    [mutableDict setValue:self.update_time forKey:@"update_time"];
    [mutableDict setValue:self.business_hours forKey:@"business_hours"];
    [mutableDict setValue:self.distance forKey:@"distance"];
    [mutableDict setValue:self.is_favorite forKey:@"is_favorite"];

    
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

    self.storeGpslng = [aDecoder decodeObjectForKey:@"storeGpslng"];
    self.storeAddress = [aDecoder decodeObjectForKey:@"storeAddress"];
    self.storeTel = [aDecoder decodeObjectForKey:@"storeTel"];
    self.storesIdentifier = [aDecoder decodeObjectForKey:@"storesIdentifier"];
    self.storeGpslat = [aDecoder decodeObjectForKey:@"storeGpslat"];
    self.filePath = [aDecoder decodeObjectForKey:@"filePath"];
    self.storeName = [aDecoder decodeObjectForKey:@"storeName"];
    self.brand = [aDecoder decodeObjectForKey:@"brand"];
    
    self.storeid = [aDecoder decodeObjectForKey:@"storeid"];
    self.promotion_message = [aDecoder decodeObjectForKey:@"promotion_message"];
    self.created = [aDecoder decodeObjectForKey:@"created"];
    self.update_time = [aDecoder decodeObjectForKey:@"update_time"];
    self.business_hours = [aDecoder decodeObjectForKey:@"business_hours"];
    self.distance = [aDecoder decodeObjectForKey:@"distance"];
    self.is_favorite = [aDecoder decodeObjectForKey:@"is_favorite"];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_storeGpslng forKey:@"storeGpslng"];
    [aCoder encodeObject:_storeAddress forKey:@"storeAddress"];
    [aCoder encodeObject:_storeTel forKey:@"storeTel"];
    [aCoder encodeObject:_storesIdentifier forKey:@"storesIdentifier"];
    [aCoder encodeObject:_storeGpslat forKey:@"storeGpslat"];
    [aCoder encodeObject:_filePath forKey:@"filePath"];
    [aCoder encodeObject:_storeName forKey:@"storeName"];
    [aCoder encodeObject:_brand forKey:@"brand"];
    
    [aCoder encodeObject:storeid forKey:@"storeid"];
    [aCoder encodeObject:promotion_message forKey:@"promotion_message"];
    [aCoder encodeObject:created forKey:@"created"];
    [aCoder encodeObject:update_time forKey:@"update_time"];
    [aCoder encodeObject:update_time forKey:@"update_time"];
    [aCoder encodeObject:business_hours forKey:@"business_hours"];
    [aCoder encodeObject:distance forKey:@"distance"];

    [aCoder encodeObject:distance forKey:@"is_favorite"];
}

@end
