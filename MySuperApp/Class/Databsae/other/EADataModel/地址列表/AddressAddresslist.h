//
//  AddressAddresslist.h
//
//  Created by malan  on 14-4-15
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface AddressAddresslist : NSObject <NSCoding>

@property (nonatomic, retain) NSString *addresslistIdentifier;
@property (nonatomic, retain) NSString *phone;
@property (nonatomic, retain) NSString *countyId;
@property (nonatomic, retain) NSString *mobile;
@property (nonatomic, retain) NSString *province;
@property (nonatomic, retain) NSString *zipCode;
@property (nonatomic, retain) NSString *userId;
@property (nonatomic, retain) NSString *cityId;
@property (nonatomic, retain) NSString *address;
@property (nonatomic, retain) NSString *defaultFlag;
@property (nonatomic, retain) NSString *city;
@property (nonatomic, retain) NSString *userName;
@property (nonatomic, retain) NSString *county;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *provinceId;

+ (AddressAddresslist *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
