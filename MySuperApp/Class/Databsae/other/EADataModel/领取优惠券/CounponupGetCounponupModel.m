//
//  CounponupGetCounponupModel.m
//
//  Created by malan  on 14-4-22
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "CounponupGetCounponupModel.h"


NSString *const kCounponupGetCounponupModelAmount = @"amount";
NSString *const kCounponupGetCounponupModelResponse = @"response";
NSString *const kCounponupGetCounponupModelGetmessage = @"getmessage";


@interface CounponupGetCounponupModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CounponupGetCounponupModel

@synthesize amount = _amount;
@synthesize response = _response;
@synthesize getmessage = _getmessage;

@synthesize requestTag;
@synthesize errorMessage;


+ (CounponupGetCounponupModel *)modelObjectWithDictionary:(NSDictionary *)dict
{
    CounponupGetCounponupModel *instance = [[CounponupGetCounponupModel alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.amount = [self objectOrNilForKey:kCounponupGetCounponupModelAmount fromDictionary:dict];
            self.response = [self objectOrNilForKey:kCounponupGetCounponupModelResponse fromDictionary:dict];
            self.getmessage = [self objectOrNilForKey:kCounponupGetCounponupModelGetmessage fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.amount forKey:kCounponupGetCounponupModelAmount];
    [mutableDict setValue:self.response forKey:kCounponupGetCounponupModelResponse];
    [mutableDict setValue:self.getmessage forKey:kCounponupGetCounponupModelGetmessage];

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

    self.amount = [aDecoder decodeObjectForKey:kCounponupGetCounponupModelAmount];
    self.response = [aDecoder decodeObjectForKey:kCounponupGetCounponupModelResponse];
    self.getmessage = [aDecoder decodeObjectForKey:kCounponupGetCounponupModelGetmessage];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_amount forKey:kCounponupGetCounponupModelAmount];
    [aCoder encodeObject:_response forKey:kCounponupGetCounponupModelResponse];
    [aCoder encodeObject:_getmessage forKey:kCounponupGetCounponupModelGetmessage];
}

@end
