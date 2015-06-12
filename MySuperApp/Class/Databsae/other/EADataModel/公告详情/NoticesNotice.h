//
//  NoticesNotice.h
//
//  Created by malan  on 14-4-15
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface NoticesNotice : NSObject <NSCoding>

@property (nonatomic, retain) NSString *noticeIdentifier;
@property (nonatomic, retain) NSString *content;
@property (nonatomic, retain) NSString *introduction;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *time;
@property (nonatomic, retain) NSString *imgUrl;

+ (NoticesNotice *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
