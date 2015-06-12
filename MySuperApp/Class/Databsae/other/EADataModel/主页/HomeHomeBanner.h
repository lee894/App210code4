//
//  HomeHomeBanner.h
//
//  Created by malan  on 14-4-12
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface HomeHomeBanner : NSObject <NSCoding>

@property (nonatomic, retain) NSString *homeBannerIdentifier;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *pic;
@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) NSString *nexttitle;
@property (nonatomic, retain) NSString *typeArgu;

+ (HomeHomeBanner *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
