//
//  CategoriesPictext.h
//
//  Created by malan  on 14-4-26
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface CategoriesPictext : NSObject <NSCoding>
//-------- 谢贤辉 begin------//
//-------- 谢贤辉 end-------//
@property (nonatomic, retain) NSString *parentId;
@property (nonatomic, retain) NSString *categoriesPictextIdentifier;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *pic;
@property (nonatomic, retain) NSString *isleafnode;
@property (nonatomic, retain) NSString *english;

+ (CategoriesPictext *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
