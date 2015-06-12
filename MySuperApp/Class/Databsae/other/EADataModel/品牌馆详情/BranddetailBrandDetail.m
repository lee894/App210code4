//
//  BranddetailBrandDetail.m
//
//  Created by malan  on 14-4-16
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "BranddetailBrandDetail.h"


NSString *const kBranddetailBrandDetailProductlistImg = @"productlist_img";
NSString *const kBranddetailBrandDetailZixunImg = @"zixun_img";
NSString *const kBranddetailBrandDetailBrandName = @"brand_name";
NSString *const kBranddetailBrandDetailBackgroundImg = @"background_img";
NSString *const kBranddetailBrandDetailXinpinImg = @"xinpin_img";


@interface BranddetailBrandDetail ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BranddetailBrandDetail

@synthesize productlistImg = _productlistImg;
@synthesize zixunImg = _zixunImg;
@synthesize brandName = _brandName;
@synthesize backgroundImg = _backgroundImg;
@synthesize xinpinImg = _xinpinImg;


+ (BranddetailBrandDetail *)modelObjectWithDictionary:(NSDictionary *)dict
{
    BranddetailBrandDetail *instance = [[BranddetailBrandDetail alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.productlistImg = [self objectOrNilForKey:kBranddetailBrandDetailProductlistImg fromDictionary:dict];
            self.zixunImg = [self objectOrNilForKey:kBranddetailBrandDetailZixunImg fromDictionary:dict];
            self.brandName = [self objectOrNilForKey:kBranddetailBrandDetailBrandName fromDictionary:dict];
            self.backgroundImg = [self objectOrNilForKey:kBranddetailBrandDetailBackgroundImg fromDictionary:dict];
            self.xinpinImg = [self objectOrNilForKey:kBranddetailBrandDetailXinpinImg fromDictionary:dict];
        
    }
    return self;
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.productlistImg forKey:kBranddetailBrandDetailProductlistImg];
    [mutableDict setValue:self.zixunImg forKey:kBranddetailBrandDetailZixunImg];
    [mutableDict setValue:self.brandName forKey:kBranddetailBrandDetailBrandName];
    [mutableDict setValue:self.backgroundImg forKey:kBranddetailBrandDetailBackgroundImg];
    [mutableDict setValue:self.xinpinImg forKey:kBranddetailBrandDetailXinpinImg];

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

    self.productlistImg = [aDecoder decodeObjectForKey:kBranddetailBrandDetailProductlistImg];
    self.zixunImg = [aDecoder decodeObjectForKey:kBranddetailBrandDetailZixunImg];
    self.brandName = [aDecoder decodeObjectForKey:kBranddetailBrandDetailBrandName];
    self.backgroundImg = [aDecoder decodeObjectForKey:kBranddetailBrandDetailBackgroundImg];
    self.xinpinImg = [aDecoder decodeObjectForKey:kBranddetailBrandDetailXinpinImg];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_productlistImg forKey:kBranddetailBrandDetailProductlistImg];
    [aCoder encodeObject:_zixunImg forKey:kBranddetailBrandDetailZixunImg];
    [aCoder encodeObject:_brandName forKey:kBranddetailBrandDetailBrandName];
    [aCoder encodeObject:_backgroundImg forKey:kBranddetailBrandDetailBackgroundImg];
    [aCoder encodeObject:_xinpinImg forKey:kBranddetailBrandDetailXinpinImg];
}

@end
