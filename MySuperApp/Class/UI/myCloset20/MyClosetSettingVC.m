//
//  MyClosetSettingVC.m
//  MyAimerApp
//
//  Created by yanglee on 15/7/2.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "MyClosetSettingVC.h"
#import "MyCloset1ViewController.h"
#import "MyButton.h"

@interface MyClosetSettingVC ()

@end

@implementation MyClosetSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"私人衣橱";
    [self createBackBtnWithType:0];
    
    
    
    MyButton *sortbtn = [MyButton buttonWithType:UIButtonTypeCustom];
    [sortbtn setFrame:CGRectMake(30 ,100, ScreenWidth-60, 40)];
    [sortbtn addTarget:self action:@selector(addpeopleAction:) forControlEvents:UIControlEventTouchUpInside];
    [sortbtn setTitle:@"增加成员" forState:UIControlStateNormal];
    [sortbtn setTitleColor:[UIColor colorWithHexString:@"#888888"] forState:UIControlStateNormal];
    [sortbtn setTitleColor:[UIColor colorWithHexString:@"#c8002c"] forState:UIControlStateSelected];
    [sortbtn setBackgroundImage:[UIImage imageNamed:@"sryc_laber_class_big_normal.png"] forState:UIControlStateNormal];
    [sortbtn setBackgroundImage:[UIImage imageNamed:@"sryc_laber_class_big_select.png"] forState:UIControlStateSelected];
    [sortbtn setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:sortbtn];
    
    
    MyButton *sortbtn2 = [MyButton buttonWithType:UIButtonTypeCustom];
    [sortbtn2 setFrame:CGRectMake(30 ,170, ScreenWidth-60, 40)];
    [sortbtn2 addTarget:self action:@selector(changeStyleAction:) forControlEvents:UIControlEventTouchUpInside];
    [sortbtn2 setTitle:@"改变风格" forState:UIControlStateNormal];
    [sortbtn2 setTitleColor:[UIColor colorWithHexString:@"#888888"] forState:UIControlStateNormal];
    [sortbtn2 setTitleColor:[UIColor colorWithHexString:@"#c8002c"] forState:UIControlStateSelected];
    
    [sortbtn2 setBackgroundImage:[UIImage imageNamed:@"sryc_laber_class_big_normal.png"] forState:UIControlStateNormal];
    [sortbtn2 setBackgroundImage:[UIImage imageNamed:@"sryc_laber_class_big_select.png"] forState:UIControlStateSelected];
    [sortbtn2 setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:sortbtn2];
    

}


- (IBAction)addpeopleAction:(id)sender {
    
    MyCloset1ViewController *vc1 = [[MyCloset1ViewController alloc] initWithNibName:@"MyCloset1ViewController" bundle:nil];
    vc1.isaddPeople = YES;
    vc1.strselecttype  =self.strselecttype;
    [self.navigationController pushViewController:vc1 animated:YES];
}

- (IBAction)changeStyleAction:(id)sender {
    
    MyCloset1ViewController *vc1 = [[MyCloset1ViewController alloc] initWithNibName:@"MyCloset1ViewController" bundle:nil];
    vc1.isaddPeople = NO;
    vc1.strselecttype  =self.strselecttype;
    [self.navigationController pushViewController:vc1 animated:YES];
    
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
