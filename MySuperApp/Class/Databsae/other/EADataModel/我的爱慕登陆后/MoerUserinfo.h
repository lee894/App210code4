//
//  MoerUserinfo.h
//
//  Created by malan  on 14-4-15
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface MoerUserinfo : NSObject <NSCoding>

@property (nonatomic, retain) NSString *isbind;
@property (nonatomic, retain) NSString *validScore;
@property (nonatomic, retain) NSString *ordernum;
@property (nonatomic, assign) double shopcartcount;
@property (nonatomic, retain) NSString *orderCount;
@property (nonatomic, assign) double norates;
@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *nodispose;
@property (nonatomic, retain) NSString *addressnum;
@property (nonatomic, retain) NSString *ordcancel;
@property (nonatomic, retain) NSString *favoritenum;
@property (nonatomic, retain) NSString *userface;


+ (MoerUserinfo *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
