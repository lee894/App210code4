//
//  ZixunZixunInfo.h
//
//  Created by malan  on 14-4-16
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ZixunZixunInfo : NSObject <NSCoding>

@property (nonatomic, retain) NSString *nexttitle;
@property (nonatomic, retain) NSString *mainTitle;
@property (nonatomic, retain) NSString *zixunInfoIdentifier;
@property (nonatomic, retain) NSString *imgPath;
@property (nonatomic, retain) NSString *typeArgu;
@property (nonatomic, retain) NSString *titleText;
@property (nonatomic, retain) NSString *type;

+ (ZixunZixunInfo *)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
