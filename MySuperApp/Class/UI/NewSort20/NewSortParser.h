//
//  NewSortParser.h
//  MyAimerApp
//
//  Created by yanglee on 15/4/15.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "BaseParser.h"
#import "NewSortInfo.h"

@interface NewSortParser : BaseParser

-(NewSortInfo *)parseNewHomeInfo:(NSDictionary*)dic;


@end
