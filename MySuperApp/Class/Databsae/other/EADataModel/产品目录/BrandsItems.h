//
//  BrandsItems.h
//
//  Created by malan  on 14-4-13
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface BrandsItems : NSObject <NSCoding>

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *value;


+ (BrandsItems *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
