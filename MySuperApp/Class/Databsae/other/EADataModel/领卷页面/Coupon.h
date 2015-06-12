//
//  Coupon.h
//
//  Created by malan  on 14-4-1
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Coupon : NSObject <NSCoding>

@property (nonatomic, retain) NSString *couponIdentifier;
@property (nonatomic, retain) NSString *isRandom;
@property (nonatomic, retain) NSString *status;
@property (nonatomic, retain) NSString *name;

@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) NSString *startTime;
@property (nonatomic, retain) NSString *batchCode;
@property (nonatomic, retain) NSString *amount;
@property (nonatomic, retain) NSString *memo;
@property (nonatomic, retain) NSString *specialsFlag;
@property (nonatomic, retain) NSArray *propValues;
@property (nonatomic, retain) NSString *created;
@property (nonatomic, retain) NSString *endTime;
@property (nonatomic, retain) NSString *shopId;


@property (nonatomic, retain) NSString *couponinfo;


+ (Coupon *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
