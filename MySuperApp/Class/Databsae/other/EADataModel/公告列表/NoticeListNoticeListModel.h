//
//  NoticeListNoticeListModel.h
//
//  Created by malan  on 14-4-26
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NoticeListNotice.h"
#import "LBaseModel.h"


@interface NoticeListNoticeListModel : LBaseModel <NSCoding>

@property (nonatomic, retain) NSString *response;
@property (nonatomic, retain) NSArray *notice;

@property (nonatomic, assign) int requestTag;
@property (retain, nonatomic) NSString *errorMessage;

+ (NoticeListNoticeListModel *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
