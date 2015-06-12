//
//  QQLogin.h
//  Ceshi
//
//  Created by 昝驹 on 13-12-25.
//  Copyright (c) 2014年 xie xianhui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sdkDef.h"
#import "sdkCall.h"

typedef  void (^GetQQuserInfoDic) (NSDictionary *infoDic); ///声明块


@interface QQLogin : NSObject {

}

- (id)init:(GetQQuserInfoDic)getInfoDic;

- (void)loginSuccessed:(NSNotification *)notify;

@property (nonatomic, copy) GetQQuserInfoDic getQQinfo;


@end
