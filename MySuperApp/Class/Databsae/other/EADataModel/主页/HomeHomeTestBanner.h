//
//  HomeHomeTestBanner.h
//
//  Created by malan  on 14-4-12
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface HomeHomeTestBanner : NSObject <NSCoding>

@property (nonatomic, retain) NSString *homeTestBannerIdentifier;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *newpic;
@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) NSString *nexttitle;
@property (nonatomic, retain) NSString *typeArgu;

+ (HomeHomeTestBanner *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
