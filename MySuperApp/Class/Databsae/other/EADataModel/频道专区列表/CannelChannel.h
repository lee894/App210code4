//
//  CannelChannel.h
//
//  Created by malan  on 14-4-3
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CannelCategires.h"

@interface CannelChannel : NSObject <NSCoding>

@property (nonatomic, retain) NSString *pic;
@property (nonatomic, retain) CannelCategires *categires;
@property (nonatomic, retain) NSString *readme;

+ (CannelChannel *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
