//
//  LookCheckDetails.h
//
//  Created by malan  on 14-4-5
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LookCheckDetails : NSObject <NSCoding>

@property (nonatomic, retain) NSArray *details;

+ (LookCheckDetails *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
