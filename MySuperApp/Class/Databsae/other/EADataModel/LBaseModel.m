//
//  LBaseModel.m
//  基类model，可以根据需要修改扩充
//
//  Created by lee on 14-4-4.
//  Copyright (c) 2014年 eastedge. All rights reserved.
//

#import "LBaseModel.h"

@implementation LBaseModel

@synthesize requestTag;

@synthesize errorMessage;
@synthesize responseDic;


-(id)init{

    if (self = [super init]) {        
    }
    return self;
}


#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}

+ (LBaseModel *)modelObjectWithDictionary:(NSDictionary *)dict {
    LBaseModel *instance = [[LBaseModel alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        self.response = [self objectOrNilForKey:@"response" fromDictionary:dict];
        
    }
    
    return self;
    
}

- (id)initWithResult:(NSString*)aResult
{
    self = [super init];
    if (self) {
        _response = aResult;
    }
    return self;
}

- (id)initWithResult:(NSString*)aResult requestTag:(NSInteger)aRequestTag andErrorMessage:(NSDictionary *)error
{
    self = [super init];
    if (self) {
        _response = aResult;
        self.requestTag = aRequestTag;
        if ([error isKindOfClass:[NSDictionary class]]) {
            errorMessage = [error objectForKey:@"text"];
        }
    }
    return self;
}

//
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.response forKey:@"response"];
    [encoder encodeObject:self.errorMessage forKey:@"error"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        self.response = [decoder decodeObjectForKey:@"response"];
        self.errorMessage = [decoder decodeObjectForKey:@"error"];
    }
    return self;
}

@end

