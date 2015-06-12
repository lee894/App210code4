//
//  SuitListSuitListModel.h
//
//  Created by malan  on 14-4-23
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SuitListSuitlist.h"
#import "LBaseModel.h"

@interface SuitListSuitListModel : LBaseModel <NSCoding>

@property (nonatomic, retain) NSArray *suitlist;
@property (nonatomic, retain) NSString *response;

@property (nonatomic, assign) int requestTag;
@property (retain, nonatomic) NSString *errorMessage;

+ (SuitListSuitListModel *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
