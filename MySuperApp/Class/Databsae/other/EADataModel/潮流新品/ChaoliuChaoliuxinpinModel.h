//
//  ChaoliuChaoliuxinpinModel.h
//
//  Created by malan  on 14-4-13
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChaoliuChaoliuxinpinInfo.h"
#import "LBaseModel.h"


@interface ChaoliuChaoliuxinpinModel : LBaseModel <NSCoding>

@property (nonatomic, retain) NSArray *chaoliuxinpinInfo;
@property (nonatomic, retain) NSString *response;
@property (nonatomic, retain) NSString *background;

@property (nonatomic, assign) NSInteger requestTag;
@property (retain, nonatomic) NSString *errorMessage;

+ (ChaoliuChaoliuxinpinModel *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
