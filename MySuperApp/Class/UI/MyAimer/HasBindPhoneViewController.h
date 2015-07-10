//
//  HasBindPhoneViewController.h
//  MyAimerApp
//
//  Created by yanglee on 15/7/10.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "LBaseViewController.h"

@interface HasBindPhoneViewController : LBaseViewController
@property (weak, nonatomic) IBOutlet UILabel *showLab;
@property (nonatomic,strong) NSString *strLab;


- (IBAction)changePhone:(id)sender;

@end
