//
//  ChangePwdViewController.h
//  MySuperApp
//
//  Created by malan on 14-3-26.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "LBaseViewController.h"

@interface ChangePwdViewController : LBaseViewController <ServiceDelegate,UITextFieldDelegate> {

    MainpageServ *mainSer;

    IBOutlet UITextField *oldPwdField;
    
    IBOutlet UITextField *newPwdField;
    
    IBOutlet UITextField *surePwdField;
    __weak IBOutlet UIView *myallView;
}

@end
