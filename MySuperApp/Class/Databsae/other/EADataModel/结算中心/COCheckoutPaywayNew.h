//
//  COCheckoutPaywayNew.h
//
//  Created by malan  on 14-4-7
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface COCheckoutPaywayNew : NSObject <NSCoding>

@property (nonatomic, assign) double checkoutPaywayNewIdentifier;
@property (nonatomic, retain) NSString *desc;

+ (COCheckoutPaywayNew *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
