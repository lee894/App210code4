//
//  CannelCannelHomeModel.h
//
//  Created by malan  on 14-4-3
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBaseModel.h"
#import "CannelChannel.h"

@interface CannelCannelHomeModel : LBaseModel <NSCoding>

@property (nonatomic, retain) CannelChannel *channel;
@property (nonatomic, retain) NSString *response;

@property (nonatomic, assign) int requestTag;
@property (retain, nonatomic) NSString *errorMessage;

+ (CannelCannelHomeModel *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
