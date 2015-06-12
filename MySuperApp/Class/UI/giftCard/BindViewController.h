//
//  BindViewController.h
//  爱慕商场
//
//  Created by LEE on 14-7-31.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "LBaseViewController.h"

@interface BindViewController : LBaseViewController <UITextFieldDelegate,ServiceDelegate>
{
    MainpageServ *mainSer;
    
    IBOutlet UITextField *bindtextField;
    __weak IBOutlet UIView *myallview;
    
}

- (IBAction)btnBindClicked:(UIButton *)btn;//绑定

@end
