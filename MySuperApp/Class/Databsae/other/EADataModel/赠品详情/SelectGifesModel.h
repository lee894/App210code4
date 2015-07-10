//
//  SelectGifesModel.h
//  MySuperApp
//
//  Created by bonan on 14-4-28.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "LBaseModel.h"
#import "NogiftsModel.h"
#import "YKItem.h"
#import "YKSpecitem.h"
#import "YKGiftItem.h"

@interface SelectGifesModel : LBaseModel


@property (retain, nonatomic) NSMutableArray *gifts;
@property (retain, nonatomic) NSMutableArray *nogifts;
@property (nonatomic, assign) BOOL selected;


@property (nonatomic, assign) NSInteger requestTag;
@property (retain, nonatomic) NSString *errorMessage;
@property (nonatomic, retain) NSString *response;

+ (SelectGifesModel *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
