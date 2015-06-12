//
//  AddressAddressLIstModel.h
//
//  Created by malan  on 14-4-15
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddressAddresslist.h"
#import "LBaseModel.h"

@interface AddressAdd : LBaseModel

@property (nonatomic, retain) NSString *response;
@property (nonatomic, assign) int requestTag;
@property (retain, nonatomic) NSString *errorMessage;

+ (AddressAdd *)modelObjectWithDictionary:(NSDictionary *)dict;

- (id)initWithDictionary:(NSDictionary *)dict;

@end


@interface AddressAddressLIstModel : LBaseModel <NSCoding>

@property (nonatomic, assign) double currentPage;
@property (nonatomic, retain) NSString *recordCount;
@property (nonatomic, retain) NSString *response;
@property (nonatomic, assign) double pageCount;
@property (nonatomic, retain) NSMutableArray *addresslist;

@property (nonatomic, assign) int requestTag;
@property (retain, nonatomic) NSString *errorMessage;

+ (AddressAddressLIstModel *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
