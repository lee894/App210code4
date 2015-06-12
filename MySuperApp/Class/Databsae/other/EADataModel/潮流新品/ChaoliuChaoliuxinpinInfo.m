//
//  ChaoliuChaoliuxinpinInfo.m
//
//  Created by malan  on 14-4-5
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "ChaoliuChaoliuxinpinInfo.h"


@interface ChaoliuChaoliuxinpinInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ChaoliuChaoliuxinpinInfo

@synthesize productId = _productId;
@synthesize width = _width;
@synthesize imgPath = _imgPath;
@synthesize height = _height;


+ (ChaoliuChaoliuxinpinInfo *)modelObjectWithDictionary:(NSDictionary *)dict
{
    ChaoliuChaoliuxinpinInfo *instance = [[ChaoliuChaoliuxinpinInfo alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        self.productId = [self objectOrNilForKey:@"product_id" fromDictionary:dict];
        self.width = [self objectOrNilForKey:@"width" fromDictionary:dict];
        self.imgPath = [self objectOrNilForKey:@"img_path" fromDictionary:dict];
        self.height = [self objectOrNilForKey:@"height" fromDictionary:dict];
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.productId forKey:@"product_id"];
    [mutableDict setValue:self.width forKey:@"width"];
    [mutableDict setValue:self.imgPath forKey:@"img_path"];
    [mutableDict setValue:self.height forKey:@"height"];
    
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
    
    self.productId = [aDecoder decodeObjectForKey:@"productId"];
    self.width = [aDecoder decodeObjectForKey:@"width"];
    self.imgPath = [aDecoder decodeObjectForKey:@"imgPath"];
    self.height = [aDecoder decodeObjectForKey:@"height"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:_productId forKey:@"productId"];
    [aCoder encodeObject:_width forKey:@"width"];
    [aCoder encodeObject:_imgPath forKey:@"imgPath"];
    [aCoder encodeObject:_height forKey:@"height"];
}


@end
