//
//  MagazineMagazineModel.h
//
//  Created by malan  on 14-4-20
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MagazineMagazineinfo.h"
#import "LBaseModel.h"

@interface MagazineMagazineModel : LBaseModel <NSCoding>

@property (nonatomic, retain) NSArray *magazineinfo;
@property (nonatomic, retain) NSString *response;
@property (nonatomic, retain) NSString *background;


@property (nonatomic, assign) NSInteger requestTag;
@property (retain, nonatomic) NSString *errorMessage;

+ (MagazineMagazineModel *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
