//
//  InfoInfoModel.h
//
//  Created by malan  on 14-4-29
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBaseModel.h"


@interface InfoInfoModel : LBaseModel <NSCoding>

@property (nonatomic, strong) NSString *brasize;
@property (nonatomic, strong) NSString *akSex2;
@property (nonatomic, strong) NSString *birthday;
@property (nonatomic, strong) NSArray *position;
@property (nonatomic, strong) NSString *zipcode;
@property (nonatomic, strong) NSString *underpants;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *child1Birthday;
@property (nonatomic, strong) NSArray *eduLevelArr;
@property (nonatomic, strong) NSArray *brasizes;
@property (nonatomic, strong) NSString *realname;
@property (nonatomic, strong) NSString * akName2;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, assign) NSString * profession;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSArray *underpant;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSArray *clothsizes;
@property (nonatomic, strong) NSArray *marriageArr;
@property (nonatomic, strong) NSString * clothsize;
@property (nonatomic, strong) NSString *validScore;
@property (nonatomic, strong) NSString *akSex1;
@property (nonatomic, strong) NSString * childHeight;
@property (nonatomic, strong) NSString *child2_height;
@property (nonatomic, strong) NSString *income;
@property (nonatomic, strong) NSString *childBirthday;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString * akName1;


@property (nonatomic, assign) int requestTag;
@property (retain, nonatomic) NSString *errorMessage;
@property (nonatomic, retain) NSString *response;


+ (InfoInfoModel *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
