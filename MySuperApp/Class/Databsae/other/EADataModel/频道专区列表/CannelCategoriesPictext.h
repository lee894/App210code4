//
//  CannelCategoriesPictext.h
//
//  Created by malan  on 14-4-3
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface CannelCategoriesPictext : NSObject <NSCoding>

@property (nonatomic, retain) NSArray *subCategories;
@property (nonatomic, retain) NSString *categoriesPictextIdentifier;
@property (nonatomic, retain) NSString *pic;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *english;
@property (nonatomic, retain) NSString *parentId;
@property (nonatomic, assign) BOOL isleafnode;

+ (CannelCategoriesPictext *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
