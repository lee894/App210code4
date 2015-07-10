//
//  VersionVersionModel.h
//
//  Created by malan  on 14-4-14
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBaseModel.h"

#import "VersionVersion.h"
#import "VersionComment.h"

@interface VersionVersionModel : LBaseModel <NSCoding>

@property (nonatomic, retain) VersionVersion *version;
@property (nonatomic, retain) NSString *response;
@property (nonatomic, retain) VersionComment *comment;

@property (nonatomic, assign) NSInteger requestTag;
@property (retain, nonatomic) NSString *errorMessage;

+ (VersionVersionModel *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
