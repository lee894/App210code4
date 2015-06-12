//
//  LoginMore.h
//
//  Created by malan  on 14-4-8
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LoginMore : NSObject <NSCoding>

@property (nonatomic, assign) double type;
@property (nonatomic, assign) double value;
@property (nonatomic, retain) NSString *title;

+ (LoginMore *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
