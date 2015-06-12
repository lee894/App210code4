//
//  ShowcomMentRate.h
//
//  Created by 昝驹  on 13-12-6
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ShowcomMentRate : NSObject <NSCoding>

@property (nonatomic, retain) NSString *content;
@property (nonatomic, retain) NSString *nickname;
@property (nonatomic, retain) NSString *created;

+ (ShowcomMentRate *)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
