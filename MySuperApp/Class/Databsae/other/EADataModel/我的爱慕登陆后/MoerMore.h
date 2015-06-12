//
//  MoerMore.h
//
//  Created by malan  on 14-4-15
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface MoerMore : NSObject <NSCoding>

@property (nonatomic, assign) double type;
@property (nonatomic, assign) double value;
@property (nonatomic, retain) NSString *title;

+ (MoerMore *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
