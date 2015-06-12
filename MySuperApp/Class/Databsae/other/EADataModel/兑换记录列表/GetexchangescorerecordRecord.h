//
//  GetexchangescorerecordRecord.h
//
//  Created by malan  on 14-4-27
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface GetexchangescorerecordRecord : NSObject <NSCoding>

@property (nonatomic, retain) NSString *recordIdentifier;
@property (nonatomic, retain) NSString *scoreSource;
@property (nonatomic, retain) NSString *userChangeScore;
@property (nonatomic, retain) NSString *cardId;
@property (nonatomic, retain) NSString *userType;
@property (nonatomic, retain) NSString *userId;
@property (nonatomic, retain) NSString *createTime;
@property (nonatomic, retain) NSString *userChangeTicket;

+ (GetexchangescorerecordRecord *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
