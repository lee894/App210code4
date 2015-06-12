//
//  CouponcardListCheckoutCouponcard.h
//
//  Created by malan  on 14-4-26
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface CouponcardListCheckoutCouponcard : NSObject <NSCoding>

@property (nonatomic, retain) NSString *stuatus;
@property (nonatomic, retain) NSString *failtime;
@property (nonatomic, retain) NSString *code;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *desc;

+ (CouponcardListCheckoutCouponcard *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
