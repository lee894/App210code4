//
//  NewFavParser.h
//  MyAimerApp
//
//  Created by yanglee on 15/4/25.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "BaseParser.h"
#import "NewFavInfo.h"

@interface NewFavParser : BaseParser

-(NewFavInfo *)parseNewFavStoreInfo:(NSDictionary*)dic;
-(NewFavInfo *)parseNewFavMaginzeInfo:(NSDictionary*)dic;


@end
