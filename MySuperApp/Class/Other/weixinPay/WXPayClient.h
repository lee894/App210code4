//
//  WXPayClient.h
//  WechatPayDemo
//
//  Created by Alvin on 3/22/14.
//  Copyright (c) 2014 Alvin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"

@interface WXPayClient : NSObject
{
    NSString *money;
    NSString *oderid;

}
+ (instancetype)shareInstance;

- (void)payProductwithorderid:(NSString*)aorderid Money:(NSString*)amoney;



@end
