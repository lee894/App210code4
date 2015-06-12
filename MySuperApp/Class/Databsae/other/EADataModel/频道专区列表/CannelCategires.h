//
//  CannelCategires.h
//
//  Created by malan  on 14-4-3
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CannelCategoriesPictext.h"



@interface CannelCategires : NSObject <NSCoding>

@property (nonatomic, retain) NSArray *categoriesPictext;
@property (nonatomic, retain) NSString *response;

+ (CannelCategires *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
