//
//  ProductlistFilter.h
//
//  Created by malan  on 14-4-26
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ProductlistFilter : NSObject <NSCoding>

@property (nonatomic, assign) double group;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, assign) double typeid;

+ (ProductlistFilter *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
