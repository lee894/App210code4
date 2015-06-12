//
//  COPrice.h
//
//  Created by malan  on 14-4-7
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface COPrice : NSObject <NSCoding>

@property (nonatomic, assign) id promotionName;
@property (nonatomic, assign) id bn;
@property (nonatomic, assign) double countMax;
@property (nonatomic, retain) NSString *adjustPrice;
@property (nonatomic, retain) NSString *memo;
@property (nonatomic, assign) id suitId;
@property (nonatomic, assign) id giftBn;
@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) NSString *promotionId;
@property (nonatomic, assign) double giftNumber;

+ (COPrice *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
