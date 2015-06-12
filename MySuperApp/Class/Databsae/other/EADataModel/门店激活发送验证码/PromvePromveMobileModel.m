//
//  PromvePromveMobileModel.m
//
//  Created by malan  on 14-4-10
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "PromvePromveMobileModel.h"


@interface PromvePromveMobileModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PromvePromveMobileModel

@synthesize content = _content;
@synthesize mobile = _mobile;
@synthesize response = _response;

@synthesize requestTag;
@synthesize errorMessage;


+ (PromvePromveMobileModel *)modelObjectWithDictionary:(NSDictionary *)dict
{
    PromvePromveMobileModel *instance = [[PromvePromveMobileModel alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.content = [self objectOrNilForKey:@"content" fromDictionary:dict];
            self.mobile = [self objectOrNilForKey:@"mobile" fromDictionary:dict];
            self.response = [self objectOrNilForKey:@"response" fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.content forKey:@"content"];
    [mutableDict setValue:self.mobile forKey:@"mobile"];
    [mutableDict setValue:self.response forKey:@"response"];

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

    self.content = [aDecoder decodeObjectForKey:@"content"];
    self.mobile = [aDecoder decodeObjectForKey:@"mobile"];
    self.response = [aDecoder decodeObjectForKey:@"response"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_content forKey:@"content"];
    [aCoder encodeObject:_mobile forKey:@"mobile"];
    [aCoder encodeObject:_response forKey:@"response"];
}

@end
