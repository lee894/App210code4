//
//  BrandsProductlistFilter.h
//
//  Created by malan  on 14-4-13
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface BrandsProductlistFilter : NSObject <NSCoding>

@property (nonatomic, assign) int group;
@property (nonatomic, assign) int typeidd;

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSArray *items;
@property (nonatomic, retain) NSString *type;


//lee999是否展开
@property (nonatomic, assign) BOOL isOpenCell;



+ (BrandsProductlistFilter *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
