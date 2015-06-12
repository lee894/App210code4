//
//  LoadingHUD.h
//  paipaiiphone
//
//  Created by 蒋博男 on 14-10-20.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingHUD : UIView
+(void)startLoadingwithtext:(NSString*)text;
+(void)stopLoading;
@end
