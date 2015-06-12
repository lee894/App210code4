//
//  MyCloset6ViewController.m
//  MyAimerApp
//
//  Created by yanglee on 15/5/28.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "MyCloset6ViewController.h"

@interface MyCloset6ViewController ()

@end

@implementation MyCloset6ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"私人衣橱6"];
    [self createBackBtnWithType:0];
    
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)gotoBackAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
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
