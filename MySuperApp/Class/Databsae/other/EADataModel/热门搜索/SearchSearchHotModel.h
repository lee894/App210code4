//
//  SearchSearchHotModel.h
//
//  Created by malan  on 14-4-22
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchKeyword.h"
#import "LBaseModel.h"


@interface SearchSearchHotModel : LBaseModel <NSCoding>

@property (nonatomic, retain) NSArray *keyword;
@property (nonatomic, retain) NSString *response;

@property (nonatomic, assign) NSInteger requestTag;
@property (retain, nonatomic) NSString *errorMessage;

+ (SearchSearchHotModel *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
