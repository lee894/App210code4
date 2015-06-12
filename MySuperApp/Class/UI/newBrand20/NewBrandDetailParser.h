//
//  NewBrandDetailParser.h
//  MyAimerApp
//
//  Created by yanglee on 15/4/26.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "BaseParser.h"
#import "NewBrandDetailInfo.h"

@interface NewBrandDetailParser : BaseParser

-(NewBrandDetailInfo *)parseBrandDetailInfo:(NSDictionary*)dic;


@end
