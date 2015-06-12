//
//  BrandsWall.h
//
//  Created by malan  on 14-4-26
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface BrandsWall : NSObject <NSCoding>

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *brandsWallIdentifier;
@property (nonatomic, retain) NSString *pic;
@property (nonatomic, retain) NSString *alias;

+ (BrandsWall *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
