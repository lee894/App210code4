//
//  MagazineMagazineinfo.h
//
//  Created by malan  on 14-4-20
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface MagazineMagazineinfo : NSObject <NSCoding>

@property (nonatomic, retain) NSString *synopsisText;
@property (nonatomic, retain) NSString *titleText;
@property (nonatomic, retain) NSString *simgPath;
@property (nonatomic, retain) NSString *mainText;
@property (nonatomic, retain) NSString *imgPath;
@property (nonatomic, retain) NSString *shareUrl;

+ (MagazineMagazineinfo *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
