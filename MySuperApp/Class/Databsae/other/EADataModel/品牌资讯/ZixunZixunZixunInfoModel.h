//
//  ZixunZixunZixunInfoModel.h
//
//  Created by malan  on 14-4-16
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBaseModel.h"
#import "ZixunZixunInfo.h"


@interface ZixunZixunZixunInfoModel : LBaseModel <NSCoding>

@property (nonatomic, retain) NSString *background;
@property (nonatomic, retain) NSArray *zixunInfo;
@property (nonatomic, retain) NSString *response;

@property (nonatomic, assign) NSInteger requestTag;
@property (retain, nonatomic) NSString *errorMessage;

+ (ZixunZixunZixunInfoModel *)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
