//
//  StoresStoresModel.h
//
//  Created by malan  on 14-4-27
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StoresStores.h"
#import "LBaseModel.h"


@interface StoresStoresModel : LBaseModel <NSCoding>

@property (nonatomic, retain) NSArray *stores;
@property (nonatomic, retain) NSString *response;

@property (nonatomic, assign) int requestTag;
@property (retain, nonatomic) NSString *errorMessage;

+ (StoresStoresModel *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
