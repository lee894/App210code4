//
//  HasBindPhoneViewController.m
//  MyAimerApp
//
//  Created by yanglee on 15/7/10.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "HasBindPhoneViewController.h"
#import "BindPhoneViewController.h"

@interface HasBindPhoneViewController ()

@end

@implementation HasBindPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createBackBtnWithType:0];
    self.title = @"已绑定手机";
    [self NewHiddenTableBarwithAnimated:YES];

    
    self.showLab.text = self.strLab;
    
}


- (IBAction)changePhone:(id)sender {
    
    BindPhoneViewController *tempBindPhone = [[BindPhoneViewController alloc] initWithNibName:@"BindPhoneViewController" bundle:nil];
    tempBindPhone.isHasBindPhone = YES;
    [self.navigationController  pushViewController:tempBindPhone animated:YES];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
