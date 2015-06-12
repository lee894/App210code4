//
//  COCheckoutConsigneeinfo.h
//
//  Created by malan  on 14-4-7
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface COCheckoutConsigneeinfo : NSObject <NSCoding>

@property (nonatomic, retain) NSString *mobile;
@property (nonatomic, retain) NSString *county;
@property (nonatomic, retain) NSString *phone;
@property (nonatomic, retain) NSString *checkoutConsigneeinfoIdentifier;
@property (nonatomic, retain) NSString *city;
@property (nonatomic, retain) NSString *zipCode;
@property (nonatomic, retain) NSString *address;
@property (nonatomic, retain) NSString *defaultFlag;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *userName;
@property (nonatomic, retain) NSString *province;

+ (COCheckoutConsigneeinfo *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
