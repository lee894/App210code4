//
//  sdkCall.h
//  sdkDemo
//
//  Created by qqconnect on 13-3-29.
//  Copyright (c) 2014年 qqconnect. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/TencentOAuthObject.h>
#import <TencentOpenAPI/TencentApiInterface.h>
#import <TencentOpenAPI/TencentMessageObject.h>

#import "sdkDef.h"
#import "MYMacro.h"

@class TencentOAuth;


@interface sdkCall : NSObject
+ (sdkCall *)getinstance;
+ (void)resetSDK;

+ (void)showInvalidTokenOrOpenIDMessage;
@property (nonatomic, retain)TencentOAuth *oauth;
@property (nonatomic, retain)NSMutableArray* photos;
@property (nonatomic, retain)NSMutableArray* thumbPhotos;
@end
