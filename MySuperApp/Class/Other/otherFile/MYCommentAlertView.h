//
//  MYCommentAlertView.h
//  YKProduct
//
//  Created by yang.li on 11-10-19.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MYCommentAlertView : NSObject<UIAlertViewDelegate>
+ (void)showMessage:(NSString *)msg target:(id)sender Tag:(NSInteger)tag;
// 可修改：message，delegate
+ (void)showMessage:(NSString *)msg target:(id)sender;

// 可修改：title，message，delegate
+ (void)showTitle:(NSString *)title message:(NSString *)msg taget:(id)sender;

+ (void)showNetMessage:(NSString *)msg target:(id)sender;
@end
