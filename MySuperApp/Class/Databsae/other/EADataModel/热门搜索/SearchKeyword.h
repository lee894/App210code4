//
//  SearchKeyword.h
//
//  Created by malan  on 14-4-22
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface SearchKeyword : NSObject <NSCoding>

@property (nonatomic, retain) NSString *ten;
@property (nonatomic, retain) NSString *tow;
@property (nonatomic, retain) NSString *three;
@property (nonatomic, retain) NSString *eleven;
@property (nonatomic, retain) NSString *four;
@property (nonatomic, retain) NSString *five;
@property (nonatomic, retain) NSString *twelve;
@property (nonatomic, retain) NSString *six;
@property (nonatomic, retain) NSString *seven;
@property (nonatomic, retain) NSString *eight;
@property (nonatomic, retain) NSString *one;
@property (nonatomic, retain) NSString *nine;

@property (nonatomic, retain) NSDictionary *dic;

+ (SearchKeyword *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
