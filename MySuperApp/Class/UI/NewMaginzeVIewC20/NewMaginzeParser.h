//
//  NewMaginzeParser.h
//  MyAimerApp
//
//  Created by yanglee on 15/4/12.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "BaseParser.h"
#import "NewMaginzeListInfo.h"

@interface NewMaginzeParser : BaseParser

-(NewMaginzeListInfo *)parseMaginzeListInfo:(NSDictionary*)dic;



-(NewMaginzeDetailInfo *)parseMaginzeDetailInfo:(NSDictionary*)dic;


@end
