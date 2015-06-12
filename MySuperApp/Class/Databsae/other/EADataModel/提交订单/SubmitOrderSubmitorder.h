//
//  SubmitOrderSubmitorder.h
//
//  Created by malan  on 14-4-4
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SubmitOrderPrice.h"

@interface SubmitOrderSubmitorder : NSObject <NSCoding>

@property (nonatomic, retain) SubmitOrderPrice *price;

+ (SubmitOrderSubmitorder *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
