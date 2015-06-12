//
//  LCommentAlertView.h
//  paipaiiphone
//
//  Created by lee on 14-8-1.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "DSURLView.h"
@class LCommentAlertView;
typedef void(^IKnowBtnClickBlock)(LCommentAlertView *view);

@protocol MyAlertViewDelegate <NSObject>

@optional
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex withParam:(NSDictionary *)dict;
- (void)sendVerifyCode:(NSDictionary *)dict;

@end
@interface LCommentAlertView : UIView <UIAlertViewDelegate,DSURLViewDelegate>
{
    UIImageView* _blurView;
    
    DSURLView *urlView;
}
@property (nonatomic, assign) id<UIAlertViewDelegate> delegate;
@property (nonatomic, assign) id<MyAlertViewDelegate> mDelegate;
@property (nonatomic,assign) IKnowBtnClickBlock btnBlock;

+ (void)showMessage:(NSString *)msg target:(id)sender Tag:(NSInteger)tag;

- (id)initWithMessage:(NSString *)msg tag:(NSInteger)tag btns:(NSString*)string, ...NS_REQUIRES_NIL_TERMINATION;
- (id)initWithTitle:(NSString*)title tag:(NSInteger)tag view:(UIView*)view;
- (id)initWithTitle:(NSString*)title tag:(NSInteger)tag view:(UIView*)view btns:(NSString*)string, ... NS_REQUIRES_NIL_TERMINATION;
- (id)initWithTitle:(NSString*)title Message:(NSString *)msg tag:(NSInteger)tag btns:(NSString*)string, ...NS_REQUIRES_NIL_TERMINATION;
//+ (void)showMessage:(NSString *)msg target:(id)sender tag:(NSInteger)tag btns:(NSArray*)btns;

// 可修改：message，delegate
+ (void)showMessage:(NSString *)msg target:(id)sender;

// 可修改：title，message，delegate
+ (void)showTitle:(NSString *)title message:(NSString *)msg taget:(id)sender;

+ (void)showNetMessage:(NSString *)msg target:(id)sender;

-(void)show;

//10 17 xu
-(void)showActivityWithView:(UIView *)view;

// 10 22 xu
-(void)showCouponViewWithSum:(int)sum;

-(void)showConfirmReceiveTip;

//chark  add
//- (void)showCouponViewInWeiDian:(NSDictionary *)dict;
- (void)showAddVerifyCodeView:(NSDictionary *)dict;



@end
