//
//  COCheckoutCouponcard.h
//
//  Created by malan  on 14-4-7
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface COCheckoutCouponcard : NSObject <NSCoding>

@property (nonatomic, retain) NSString *desc;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *code;

+ (COCheckoutCouponcard *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
