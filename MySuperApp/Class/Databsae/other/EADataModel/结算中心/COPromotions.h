//
//  COPromotions.h
//
//  Created by malan  on 14-4-7
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface COPromotions : NSObject <NSCoding>

@property (nonatomic, retain) NSArray *price;
@property (nonatomic, retain) NSArray *exempt;

+ (COPromotions *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
