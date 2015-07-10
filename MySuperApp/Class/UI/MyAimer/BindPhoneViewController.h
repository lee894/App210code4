//
//  BindPhoneViewController.h
//  MySuperApp
//
//  Created by malan on 14-4-27.
//  Copyright (c) 2014年 aimer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBaseViewController.h"

@interface BindPhoneViewController : LBaseViewController <UITextFieldDelegate,ServiceDelegate>
{
    NSInteger count;
    MainpageServ *mainSer;
    
    IBOutlet UITextField *textFieldPhone;
    IBOutlet UITextField *textFieldCode;
    NSTimer *bindTimer;
    IBOutlet UIButton *buttonCode;
    IBOutlet UIButton *buttonBind;
    __weak IBOutlet UIView *myallView;
}

@property(nonatomic,assign)BOOL isHasBindPhone ; //是否已绑定手机


- (IBAction)getCode:(id)sender;//获取验证码
- (IBAction)bindPhone:(id)sender;//绑定手机
@end
