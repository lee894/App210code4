//
//  BranddetailBrandDetail.h
//
//  Created by malan  on 14-4-16
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface BranddetailBrandDetail : NSObject <NSCoding>

@property (nonatomic, retain) NSString *productlistImg;
@property (nonatomic, retain) NSString *zixunImg;
@property (nonatomic, retain) NSString *brandName;
@property (nonatomic, retain) NSString *backgroundImg;
@property (nonatomic, retain) NSString *xinpinImg;

+ (BranddetailBrandDetail *)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
