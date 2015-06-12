//
//  HomeHomeModel.h
//
//  Created by malan  on 14-4-12
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeHomeTestBanner.h"
#import "HomeHomeBanner.h"
#import "LBaseModel.h"

@interface HomeHomeModel : LBaseModel <NSCoding>

@property (nonatomic, retain) NSArray *notice;
@property (nonatomic, retain) NSArray *homeTestBanner;
@property (nonatomic, retain) NSString *response;
@property (nonatomic, assign) double cartNum;
@property (nonatomic, retain) NSArray *homeBanner;

@property (nonatomic, assign) int requestTag;
@property (retain, nonatomic) NSString *errorMessage;

+ (HomeHomeModel *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
