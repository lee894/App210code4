//
//  LoginViewController.h
//  MySuperApp
//
//  Created by LEE on 14-4-12.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "LBaseViewController.h"

@interface LoginViewController : LBaseViewController

@property (retain, nonatomic)  NSString *titleLabelstr;

@property (retain, nonatomic) IBOutlet UILabel *successLabel;
- (IBAction)login:(id)sender;//登录
@end
