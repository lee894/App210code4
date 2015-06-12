//
//  NewHomeParser.h
//  MyAimerApp
//
//  Created by yanglee on 15/4/9.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "BaseParser.h"
#import "NewHomeInfo.h"


@interface NewHomeParser : BaseParser


-(NewHomeInfo *)parseNewHomeInfo:(NSDictionary*)dic;

@end
