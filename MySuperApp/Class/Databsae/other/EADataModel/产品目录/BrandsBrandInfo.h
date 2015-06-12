//
//  BrandsBrandInfo.h
//
//  Created by malan  on 14-4-13
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface BrandsBrandInfo : NSObject <NSCoding>

@property (nonatomic, retain) NSString *memo;
@property (nonatomic, retain) NSString *logo;

+ (BrandsBrandInfo *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
