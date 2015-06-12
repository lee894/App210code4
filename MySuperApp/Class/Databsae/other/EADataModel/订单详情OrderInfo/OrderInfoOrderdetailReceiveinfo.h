//
//  OrderInfoOrderdetailReceiveinfo.h
//
//  Created by malan  on 14-4-19
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface OrderInfoOrderdetailReceiveinfo : NSObject <NSCoding>

@property (nonatomic, retain) NSString *detail;
@property (nonatomic, retain) NSString *area;
@property (nonatomic, retain) NSString *city;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *zipcode;
@property (nonatomic, assign) id email;
@property (nonatomic, retain) NSString *mobilephone;
@property (nonatomic, retain) NSString *telphone;
@property (nonatomic, retain) NSString *province;

+ (OrderInfoOrderdetailReceiveinfo *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
