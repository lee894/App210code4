//
//  NewMaginzeParser.m
//  MyAimerApp
//
//  Created by yanglee on 15/4/12.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "NewMaginzeParser.h"

@implementation NewMaginzeParser


-(NewMaginzeListInfo *)parseMaginzeListInfo:(NSDictionary*)dic{
    
    dicClassNames = @{@"topkey" : @"NewMaginzeListInfo",
                      @"magazinelist" : @"NewMaginzeData"};
    return [self parseDic:dic byKey:@"topkey"];
}


-(NewMaginzeDetailInfo *)parseMaginzeDetailInfo:(NSDictionary*)dic{

    dicClassNames = @{@"topkey" : @"NewMaginzeDetailInfo",
                      @"magazine_info_a" : @"NewMaginzeDetailInfoA",
//                      @"pic_file_path" : @"NewMaginzeData",
                      @"goods_info" : @"NewMaginzeDetailProduct",
                      @"magazine_info_b" : @"NewMaginzeDetailInfoB",
                      @"info_index" : @"NewMaginzeDetailInfo_dataB",
                      @"info_content" : @"NewMaginzeDetailInfo_dataB",
                      @"info_footer" : @"NewMaginzeDetailInfo_dataB",
                      };
    return [self parseDic:dic byKey:@"topkey"];
}


@end
