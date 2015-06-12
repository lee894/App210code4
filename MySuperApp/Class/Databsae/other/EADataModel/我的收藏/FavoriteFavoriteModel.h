//
//  FavoriteFavoriteModel.h
//
//  Created by malan  on 14-4-19
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FavoriteFavoritePic.h"
#import "LBaseModel.h"

@interface FavoriteFavoriteModel : LBaseModel <NSCoding>

@property (nonatomic, assign) double currentPage;
@property (nonatomic, retain) NSMutableArray *favoritePic;
@property (nonatomic, retain) NSString *recordCount;
@property (nonatomic, retain) NSString *response;
@property (nonatomic, assign) double pageCount;

@property (nonatomic, assign) int requestTag;
@property (retain, nonatomic) NSString *errorMessage;

+ (FavoriteFavoriteModel *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
