//
//  BrandsTypes.h
//
//  Created by malan  on 14-4-13
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface BrandsTypes : NSObject <NSCoding>

@property (nonatomic, retain) NSString *nameType;
@property (nonatomic, assign) double typeidd;

+ (BrandsTypes *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
