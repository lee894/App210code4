//
//  ZixunZixunZixunInfoModel.m
//
//  Created by malan  on 14-4-16
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "ZixunZixunZixunInfoModel.h"


NSString *const kZixunZixunZixunInfoModelBackground = @"background";
NSString *const kZixunZixunZixunInfoModelZixunInfo = @"zixun_info";
NSString *const kZixunZixunZixunInfoModelResponse = @"response";


@interface ZixunZixunZixunInfoModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZixunZixunZixunInfoModel

@synthesize background = _background;
@synthesize zixunInfo = _zixunInfo;
@synthesize response = _response;

@synthesize requestTag;
@synthesize errorMessage;


+ (ZixunZixunZixunInfoModel *)modelObjectWithDictionary:(NSDictionary *)dict
{
    ZixunZixunZixunInfoModel *instance = [[ZixunZixunZixunInfoModel alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.background = [self objectOrNilForKey:kZixunZixunZixunInfoModelBackground fromDictionary:dict];
    NSObject *receivedZixunZixunInfo = [dict objectForKey:kZixunZixunZixunInfoModelZixunInfo];
    NSMutableArray *parsedZixunZixunInfo = [NSMutableArray array];
    if ([receivedZixunZixunInfo isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedZixunZixunInfo) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedZixunZixunInfo addObject:[ZixunZixunInfo modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedZixunZixunInfo isKindOfClass:[NSDictionary class]]) {
       [parsedZixunZixunInfo addObject:[ZixunZixunInfo modelObjectWithDictionary:(NSDictionary *)receivedZixunZixunInfo]];
    }

    self.zixunInfo = [NSArray arrayWithArray:parsedZixunZixunInfo];
            self.response = [self objectOrNilForKey:kZixunZixunZixunInfoModelResponse fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.background forKey:kZixunZixunZixunInfoModelBackground];
NSMutableArray *tempArrayForZixunInfo = [NSMutableArray array];
    for (NSObject *subArrayObject in self.zixunInfo) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForZixunInfo addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForZixunInfo addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForZixunInfo] forKey:@"kZixunZixunZixunInfoModelZixunInfo"];
    [mutableDict setValue:self.response forKey:kZixunZixunZixunInfoModelResponse];

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

    self.background = [aDecoder decodeObjectForKey:kZixunZixunZixunInfoModelBackground];
    self.zixunInfo = [aDecoder decodeObjectForKey:kZixunZixunZixunInfoModelZixunInfo];
    self.response = [aDecoder decodeObjectForKey:kZixunZixunZixunInfoModelResponse];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_background forKey:kZixunZixunZixunInfoModelBackground];
    [aCoder encodeObject:_zixunInfo forKey:kZixunZixunZixunInfoModelZixunInfo];
    [aCoder encodeObject:_response forKey:kZixunZixunZixunInfoModelResponse];
}


@end
