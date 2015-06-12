//
//  Usev6cardusev6cardModel.h
//
//  Created by malan  on 14-4-26
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LBaseModel.h"
@interface Usev6cardusev6cardModel : LBaseModel <NSCoding>

@property (nonatomic, retain) NSString *usev6cardID;



@property (nonatomic, assign) int requestTag;
@property (retain, nonatomic) NSString *errorMessage;
@property(nonatomic, retain)NSString *response;


+ (Usev6cardusev6cardModel *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
