//
//  VersionComment.h
//
//  Created by malan  on 14-4-14
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface VersionComment : NSObject <NSCoding>

@property (nonatomic, assign) BOOL flag;
@property (nonatomic, retain) NSString *url;

+ (VersionComment *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
