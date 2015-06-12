//
//  AssessAssessModel.m
//
//  Created by malan  on 14-4-4
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "AssessAssessModel.h"



@interface AssessAssessModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation AssessAssessModel

@synthesize number = _number;
@synthesize userName = _userName;
@synthesize detail = _detail;


@synthesize requestTag;
@synthesize errorMessage,response;

+ (AssessAssessModel *)modelObjectWithDictionary:(NSDictionary *)dict
{
    AssessAssessModel *instance = [[AssessAssessModel alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.number = [[dict objectForKey:@"number"] intValue];
            self.userName = [self objectOrNilForKey:@"user_name" fromDictionary:dict];
    NSObject *receivedAssessDetail = [dict objectForKey:@"detail"];
    NSMutableArray *parsedAssessDetail = [NSMutableArray array];
    if ([receivedAssessDetail isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedAssessDetail) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedAssessDetail addObject:[AssessDetail modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedAssessDetail isKindOfClass:[NSDictionary class]]) {
       [parsedAssessDetail addObject:[AssessDetail modelObjectWithDictionary:(NSDictionary *)receivedAssessDetail]];
    }

    self.detail = [NSArray arrayWithArray:parsedAssessDetail];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{//[NSString stringWithFormat:@"%d",self.number]
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithInt:self.number] forKey:@"number"];
    [mutableDict setValue:self.userName forKey:@"user_name"];
NSMutableArray *tempArrayForDetail = [NSMutableArray array];
    for (NSObject *subArrayObject in self.detail) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForDetail addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForDetail addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForDetail] forKey:@"detail"];

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
    self.userName = [aDecoder decodeObjectForKey:@"userName"];
    self.detail = [aDecoder decodeObjectForKey:@"detail"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_number forKey:@"number"];
    [aCoder encodeObject:_userName forKey:@"userName"];
    [aCoder encodeObject:_detail forKey:@"detail"];
}


@end
