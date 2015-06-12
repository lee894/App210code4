//
//  ChaoliuChaoliuxinpinInfo.h
//
//  Created by malan  on 14-4-13
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ChaoliuChaoliuxinpinInfo : NSObject <NSCoding>

@property (nonatomic, retain) NSString *productId;
@property (nonatomic, retain) NSString *width;
@property (nonatomic, retain) NSString *imgPath;
@property (nonatomic, retain) NSString *height;

+ (ChaoliuChaoliuxinpinInfo *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
