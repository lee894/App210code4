//
//  SuitListSuitlist.h
//
//  Created by malan  on 14-4-23
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface SuitListSuitlist : NSObject <NSCoding>

@property (nonatomic, retain) NSString *image_file_path;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *price;
@property (nonatomic, retain) NSString *suitid;
@property (nonatomic, retain) NSString *mkt_price;
@property (nonatomic, retain) NSString *pic;


+ (SuitListSuitlist *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
