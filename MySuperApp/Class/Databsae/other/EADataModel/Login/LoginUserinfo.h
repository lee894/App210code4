//
//  LoginUserinfo.h
//
//  Created by malan  on 14-4-8
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LoginUserinfo : NSObject <NSCoding>

@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *addressnum;
@property (nonatomic, retain) NSString *favoritenum;
@property (nonatomic, retain) NSString *ordernum;


+ (LoginUserinfo *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
