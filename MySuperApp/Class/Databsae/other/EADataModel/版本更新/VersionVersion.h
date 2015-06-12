//
//  VersionVersion.h
//
//  Created by malan  on 14-4-14
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface VersionVersion : NSObject <NSCoding>

@property (nonatomic, retain) NSString *ver;
@property (nonatomic, assign) BOOL newVer;
@property (nonatomic, retain) NSString *message;
@property (nonatomic, retain) NSString *url;
@property (nonatomic, assign) BOOL need;

+ (VersionVersion *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
