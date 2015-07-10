//
//  AssessDetail.h
//
//  Created by malan  on 14-4-4
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface AssessDetail : NSObject <NSCoding>

@property (nonatomic, retain) NSString *goodsid;
@property (nonatomic, retain) NSString *coId;
@property (nonatomic, retain) NSString *productid;
@property (nonatomic, retain) NSString *productName;
@property (nonatomic, retain) NSString *imgfilePath;
@property (nonatomic, retain) NSString *nametype;

//lee999
@property (nonatomic, retain) NSString *product_size;
@property (nonatomic, retain) NSString *product_color;


@property (nonatomic, assign) NSInteger sizeSelecttag;
@property (nonatomic, assign) NSInteger braSelecttag;
@property (nonatomic, assign) NSInteger degressSelecttag;
@property (nonatomic, retain) NSString *userInput;
//end


+ (AssessDetail *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
