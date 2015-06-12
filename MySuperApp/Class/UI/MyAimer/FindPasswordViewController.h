//
//  FindPasswordViewController.h
//  MySuperApp
//
//  Created by malan on 14-3-27.
//  Copyright (c) 2014年 aimer. All rights reserved.
//

#import "LBaseViewController.h"

@interface FindPasswordViewController : LBaseViewController <UITextFieldDelegate,ServiceDelegate>
{
    
    MainpageServ *mainSer;
    IBOutlet UITextField *textFieldCode;//验证码
    IBOutlet UITextField *textFieldNew;//新密码
    IBOutlet UITextField *textFieldComfirmNew;//确认新密码
    
    IBOutlet UILabel *labelTitle;//导航的label；
    
    IBOutlet UILabel *labelPhone;
    IBOutlet UILabel *labelCount;
    
    NSTimer *timerCode;

    __weak IBOutlet UIView *myallView;
}

@property (nonatomic, retain) NSString *topic;
@property (nonatomic, retain) NSString *phoneNum;
@property (nonatomic, retain) NSString *userID;
@property (nonatomic, assign) BOOL isFind;//是否从找回密码进入

- (IBAction)submit:(id)sender;//提交
@end
