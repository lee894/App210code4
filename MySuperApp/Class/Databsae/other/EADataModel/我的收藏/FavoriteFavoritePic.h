//
//  FavoriteFavoritePic.h
//
//  Created by malan  on 14-4-19
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface FavoriteFavoritePic : NSObject <NSCoding>

@property (nonatomic, retain) NSString *productid;
@property (nonatomic, retain) NSString *pic;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *price;

@property (nonatomic, retain) NSString *image_file_path;


+ (FavoriteFavoritePic *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
