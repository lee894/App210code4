//
//  MainMainInfo.h
//
//  Created by malan  on 14-4-22
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface MainMainInfo : NSObject <NSCoding>

@property (nonatomic, retain) NSString *nexttitle;
@property (nonatomic, retain) NSString *mainTitle;
@property (nonatomic, retain) NSString *mainInfoIdentifier;
@property (nonatomic, retain) NSString *imgPath;
@property (nonatomic, retain) NSString *typeArgu;
@property (nonatomic, retain) NSString *titleText;
@property (nonatomic, retain) NSString *type;

+ (MainMainInfo *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
