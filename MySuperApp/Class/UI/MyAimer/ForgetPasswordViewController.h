//
//  ForgetPasswordViewController.h
//  MySuperApp
//
//  Created by LEE on 14-7-29.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBaseViewController.h"

@interface ForgetPasswordViewController : LBaseViewController <UITextFieldDelegate,ServiceDelegate>
{
    MainpageServ *mainSer;
    UITextField *textFieldAccount;
    
    __weak IBOutlet UIView *myallView;
    
}


- (IBAction)verification:(id)sender;//验证
@end
