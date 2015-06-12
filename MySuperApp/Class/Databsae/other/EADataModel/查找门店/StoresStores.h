//
//  StoresStores.h
//
//  Created by malan  on 14-4-27
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface StoresStores : NSObject <NSCoding>

@property (nonatomic, retain) NSString *storeid;
@property (nonatomic, retain) NSString *promotion_message;
@property (nonatomic, retain) NSString *created;
@property (nonatomic, retain) NSString *update_time;
@property (nonatomic, retain) NSString *business_hours;
@property (nonatomic, retain) NSString *distance;


@property (nonatomic, retain) NSString *storeGpslng;
@property (nonatomic, retain) NSString *storeAddress;
@property (nonatomic, retain) NSString *storeTel;
@property (nonatomic, retain) NSString *storesIdentifier;
@property (nonatomic, retain) NSString *storeGpslat;
@property (nonatomic, retain) NSString *filePath;
@property (nonatomic, retain) NSString *storeName;
@property (nonatomic, retain) id brand;
@property (nonatomic, retain) NSString *is_favorite;

+ (StoresStores *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
