//
//  NogiftsModel.h
//  MySuperApp
//
//  Created by bonan on 14-4-28.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NogiftsItem.h"


@interface NogiftsModel : NSObject

@property (retain, nonatomic) NSString *promotion_name;
@property (retain, nonatomic) NSString *actionname;
@property (retain, nonatomic) NSString *promotion_id;
@property (nonatomic, assign) BOOL isSelect;
@property (retain, nonatomic) NSMutableArray *nogiftsItemArr;
@property (nonatomic, retain) NSString *strSelect;

@property (nonatomic, assign) NSInteger requestTag;
@property (retain, nonatomic) NSString *errorMessage;


+ (NogiftsModel *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
//- (NSDictionary *)dictionaryRepresentation;


@end
