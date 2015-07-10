//
//  ScanModel.h
//  MySuperApp
//
//  Created by bonan on 14-4-12.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBaseModel.h"

@interface ScanModel : LBaseModel <NSCoding>

@property (nonatomic, retain) NSString *goodsId;
@property (nonatomic, retain) NSString *response;

@property (retain, nonatomic) NSString *errorMessage;
@property (nonatomic, assign) NSInteger requestTag; /*这个与相应的请求的tag是同步的*/



+ (ScanModel *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
