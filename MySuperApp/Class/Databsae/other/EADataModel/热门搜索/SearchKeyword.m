//
//  SearchKeyword.m
//
//  Created by malan  on 14-4-22
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "SearchKeyword.h"


@interface SearchKeyword ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SearchKeyword




+ (SearchKeyword *)modelObjectWithDictionary:(NSDictionary *)dict
{
    SearchKeyword *instance = [[SearchKeyword alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        
        
        self.dic = dict;
        
            self.ten = [self objectOrNilForKey:@"10" fromDictionary:dict];
            self.tow = [self objectOrNilForKey:@"2" fromDictionary:dict];
            self.three = [self objectOrNilForKey:@"3" fromDictionary:dict];
            self.eleven = [self objectOrNilForKey:@"11" fromDictionary:dict];
            self.four = [self objectOrNilForKey:@"4" fromDictionary:dict];
            self.five = [self objectOrNilForKey:@"5" fromDictionary:dict];
            self.twelve = [self objectOrNilForKey:@"12" fromDictionary:dict];
            self.six = [self objectOrNilForKey:@"6" fromDictionary:dict];
            self.seven = [self objectOrNilForKey:@"7" fromDictionary:dict];
            self.eight = [self objectOrNilForKey:@"8" fromDictionary:dict];
            self.one = [self objectOrNilForKey:@"1" fromDictionary:dict];
            self.nine = [self objectOrNilForKey:@"9" fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.ten forKey:@"10"];
    [mutableDict setValue:self.tow forKey:@"2"];
    [mutableDict setValue:self.three forKey:@"3"];
    [mutableDict setValue:self.eleven forKey:@"11"];
    [mutableDict setValue:self.four forKey:@"4"];
    [mutableDict setValue:self.five forKey:@"5"];
    [mutableDict setValue:self.twelve forKey:@"12"];
    [mutableDict setValue:self.six forKey:@"6"];
    [mutableDict setValue:self.seven forKey:@"7"];
    [mutableDict setValue:self.eight forKey:@"8"];
    [mutableDict setValue:self.one forKey:@"1"];
    [mutableDict setValue:self.nine forKey:@"9"];

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

    self.ten = [aDecoder decodeObjectForKey:@"10"];
    self.tow = [aDecoder decodeObjectForKey:@"2"];
    self.three = [aDecoder decodeObjectForKey:@"3"];
    self.eleven = [aDecoder decodeObjectForKey:@"11"];
    self.four = [aDecoder decodeObjectForKey:@"4"];
    self.five = [aDecoder decodeObjectForKey:@"5"];
    self.twelve = [aDecoder decodeObjectForKey:@"12"];
    self.six = [aDecoder decodeObjectForKey:@"6"];
    self.seven = [aDecoder decodeObjectForKey:@"7"];
    self.eight = [aDecoder decodeObjectForKey:@"8"];
    self.one = [aDecoder decodeObjectForKey:@"1"];
    self.nine = [aDecoder decodeObjectForKey:@"9"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_ten forKey:@"10"];
    [aCoder encodeObject:_tow forKey:@"2"];
    [aCoder encodeObject:_three forKey:@"3"];
    [aCoder encodeObject:_eleven forKey:@"11"];
    [aCoder encodeObject:_four forKey:@"4"];
    [aCoder encodeObject:_five forKey:@"5"];
    [aCoder encodeObject:_twelve forKey:@"12"];
    [aCoder encodeObject:_six forKey:@"6"];
    [aCoder encodeObject:_seven forKey:@"7"];
    [aCoder encodeObject:_eight forKey:@"8"];
    [aCoder encodeObject:_one forKey:@"1"];
    [aCoder encodeObject:_nine forKey:@"9"];
}


@end
