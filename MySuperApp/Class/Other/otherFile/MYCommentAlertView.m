//
//  MYCommentAlertView.m
//  YKProduct
//
//  Created by yang.li on 11-10-19.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "MYCommentAlertView.h"
#import "SingletonState.h"

@implementation MYCommentAlertView

+ (void)showMessage:(NSString *)msg target:(id)sender{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"爱慕提示" 
                                                    message:msg 
                                                   delegate:sender 
                                          cancelButtonTitle:@"知道了" 
                                          otherButtonTitles:nil];
	[alert show];
}

+ (void)showTitle:(NSString *)title message:(NSString *)msg taget:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:msg 
                                                   delegate:sender 
                                          cancelButtonTitle:@"知道了" 
                                          otherButtonTitles:nil];
	[alert show];
}


+ (void)showNetMessage:(NSString *)msg target:(id)sender{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"爱慕提示" 
                                                    message:msg 
                                                   delegate:sender 
                                          cancelButtonTitle:@"知道了2222" 
                                        otherButtonTitles:nil];
    alert.tag = 11118;
	[alert show];
}
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//
//    if (alertView.tag == 11118) {
//        SingletonState *sing = [SingletonState sharedStateInstance];
//        [sing.rootTabBarController.navigationController popViewControllerAnimated:YES];
//    }
//}
+ (void)showMessage:(NSString *)msg target:(id)sender Tag:(NSInteger)tag{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"爱慕提示" 
                                                    message:msg 
                                                   delegate:sender 
                                          cancelButtonTitle:@"知道了" 
                                          otherButtonTitles:nil];
    alert.tag = tag;
	[alert show];
}

@end
