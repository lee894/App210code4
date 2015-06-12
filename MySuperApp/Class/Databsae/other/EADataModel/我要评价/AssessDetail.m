//
//  AssessDetail.m
//
//  Created by malan  on 14-4-4
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "AssessDetail.h"


@interface AssessDetail ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation AssessDetail

@synthesize goodsid = _goodsid;
@synthesize coId = _coId;
@synthesize productid = _productid;
@synthesize productName = _productName;
@synthesize imgfilePath = _imgfilePath;
@synthesize nametype = _nametype;

@synthesize product_color = _product_color;
@synthesize product_size = _product_size;


@synthesize sizeSelecttag;
@synthesize braSelecttag;
@synthesize degressSelecttag;
@synthesize userInput;


+ (AssessDetail *)modelObjectWithDictionary:(NSDictionary *)dict
{
    AssessDetail *instance = [[AssessDetail alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.goodsid = [self objectOrNilForKey:@"goodsid" fromDictionary:dict];
            self.coId = [self objectOrNilForKey:@"co_id" fromDictionary:dict];
            self.productid = [self objectOrNilForKey:@"productid" fromDictionary:dict];
            self.productName = [self objectOrNilForKey:@"product_name" fromDictionary:dict];
            self.imgfilePath = [self objectOrNilForKey:@"imgfile_path" fromDictionary:dict];
            self.nametype = [self objectOrNilForKey:@"typename" fromDictionary:dict];

        //lee999
        self.product_size = [self objectOrNilForKey:@"product_size" fromDictionary:dict];
        self.product_color = [self objectOrNilForKey:@"product_color" fromDictionary:dict];
        //end
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.goodsid forKey:@"goodsid"];
    [mutableDict setValue:self.coId forKey:@"co_id"];
    [mutableDict setValue:self.productid forKey:@"productid"];
    [mutableDict setValue:self.productName forKey:@"product_name"];
    [mutableDict setValue:self.imgfilePath forKey:@"imgfile_path"];
    [mutableDict setValue:self.nametype forKey:@"typename"];

    //lee999
    [mutableDict setValue:self.product_size forKey:@"product_size"];
    [mutableDict setValue:self.product_color forKey:@"product_color"];
    //end
    
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

    self.goodsid = [aDecoder decodeObjectForKey:@"goodsid"];
    self.coId = [aDecoder decodeObjectForKey:@"coId"];
    self.productid = [aDecoder decodeObjectForKey:@"productid"];
    self.productName = [aDecoder decodeObjectForKey:@"productName"];
    self.imgfilePath = [aDecoder decodeObjectForKey:@"imgfilePath"];
    self.nametype = [aDecoder decodeObjectForKey:@"typename"];
    
    //lee999
    self.product_size = [aDecoder decodeObjectForKey:@"product_size"];
    self.product_color = [aDecoder decodeObjectForKey:@"product_color"];
    //end
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_goodsid forKey:@"goodsid"];
    [aCoder encodeObject:_coId forKey:@"coId"];
    [aCoder encodeObject:_productid forKey:@"productid"];
    [aCoder encodeObject:_productName forKey:@"productName"];
    [aCoder encodeObject:_imgfilePath forKey:@"imgfilePath"];
    [aCoder encodeObject:_nametype forKey:@"typename"];
    
    //lee999
    [aCoder encodeObject:_product_size forKey:@"product_size"];
    [aCoder encodeObject:_product_color forKey:@"product_color"];
    //end
}

@end
