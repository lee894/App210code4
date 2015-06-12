//
//  SBPublicAlert.h
/**
 version:1.0
 系统的UIAlertView
 第三方的MBProgressHUD
 
 */
//  Created by bonan on 13-6-23.
//  Copyright (c) 2014年 xie xianhui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface SBPublicAlert : NSObject


//-----------------提示框
//获取提示框单例
+ (MBProgressHUD *)getMBProgress;

//显示提示框　　states为YES代表没有活动指示器　　　为NO代表有活动指示器
+ (void)showMBProgressHUD:(NSString *)showMessage
             andWhereView:(UIView *)view
                   states:(BOOL)states;

//显示提示框　　只显示文字， theTime后消失
+ (void)showMBProgressHUD:(NSString *)showMessage
             andWhereView:(UIView *)view
               hiddenTime:(CGFloat)theTime;
//显示提示框　　只显示文字， theTime后消失
+ (void)showMBProgressHUDTextOnly:(NSString *)showMessage
                     andWhereView:(UIView *)view
                       hiddenTime:(CGFloat)theTime;

//更换提示框的文字  isSuccess为YES代表成功，显示成功的图片　　为NO则相反
+ (void)hideYESMBprogressHUDcontent:(NSString *)showMessage
                          isSuccess:(BOOL)states
                         hiddenTime:(CGFloat)theTime;

//隐藏提示框
+ (void)hideMBprogressHUD:(UIView *)view;

//提示系统的alert  只有一个确定按钮
+ (void)showAlertTitle:(NSString*)title
               Message:(NSString *)showMessage;

//返回一个alert对象 系统的alert 设置delegate，title，message，btn,tag 只传两个一个确定一个取消
+ (UIAlertView *)showWithReturnAlertTitle:(NSString *)theTitleStr
                                  Message:(NSString *)theMessageStr
                                 delegate:(id)delegate
                                      tag:(NSInteger)tag
                             cancelButton:(NSString *)theCancelBtnStr
                        sureButtonTitles:(NSString *)theSureBtnStr;

//系统的alert 设置delegate，title，message，btn,tag  只传两个一个确定一个取消
+ (void)showAlertTitle:(NSString *)theTitleStr
               Message:(NSString *)theMessageStr
              delegate:(id)delegate
                   tag:(NSInteger)tag
          cancelButton:(NSString *)theCancelBtnStr
      sureButtonTitles:(NSString *)theSureBtnStr;


//返回一个alert对象 系统的alert 设置delegate，title，message，btn,tag 可以传多个按钮
+ (UIAlertView *)showWithReturnAlertTitle:(NSString *)theTitleStr
                                  Message:(NSString *)theMessageStr
                                 delegate:(id)delegate
                                      tag:(NSInteger)tag
                             cancelButton:(NSString *)theCancelBtnStr
                        otherButtonTitles:(NSArray *)theOtherBtnArr;

//系统的alert 设置delegate，title，message，btn,tag  可以传多个按钮
+ (void)showAlertTitle:(NSString *)theTitleStr
               Message:(NSString *)theMessageStr
              delegate:(id)delegate
                   tag:(NSInteger)tag
          cancelButton:(NSString *)theCancelBtnStr
     otherButtonTitles:(NSArray *)theOtherBtnArr;

@end
