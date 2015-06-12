//
//  MainMainModel.h
//
//  Created by malan  on 14-4-22
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainMainInfo.h"
#import "LBaseModel.h"

@interface MainMainModel : LBaseModel <NSCoding>



@property (nonatomic, retain) NSArray *mainInfo;
@property (nonatomic, retain) NSString *response;
@property (nonatomic, retain) NSString *background;
@property (nonatomic, assign) NSInteger shopcartcount;

@property (nonatomic, assign) int requestTag;
@property (retain, nonatomic) NSString *errorMessage;

+ (MainMainModel *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;


@end
