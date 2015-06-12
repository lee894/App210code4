//
//  MyCloset5ViewController.m
//  MyAimerApp
//
//  Created by yanglee on 15/5/27.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "MyCloset5ViewController.h"
#import "MyClosetListViewController.h"
#import "ZHPickView.h"

@interface MyCloset5ViewController ()<ZHPickViewDelegate>
{
    IBOutlet UIButton *btn1;
    IBOutlet UIButton *btn2;
    
    int selectIndex;
}
@end

@implementation MyCloset5ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setTitle:@"私人衣橱5"];
    [self createBackBtnWithType:0];
    
    // Do any additional setup after loading the view from its nib.
}



- (IBAction)typeSelectAction:(id)sender {
    UIButton *btn = (UIButton*)sender;
    btn.selected = YES;
    
    selectIndex = btn.tag;
    
    if (btn.tag == 1) {
        //支持自定义数组：
        NSArray *array=@[@[@"每周更换",@"每月更换",@"每三个月更换",@"半年更换",@"一年更换",@"不换"]];
        ZHPickView* _pickview=[[ZHPickView alloc] initPickviewWithArray:array isHaveNavControler:NO];
        _pickview.delegate = self;
        [_pickview show];
    }
    else if (btn.tag == 2) {
        //支持自定义数组：
        NSArray *array=@[@[@"每周更换",@"每月更换",@"每三个月更换",@"半年更换",@"一年更换",@"不换"]];
        ZHPickView* _pickview=[[ZHPickView alloc] initPickviewWithArray:array isHaveNavControler:NO];
        _pickview.delegate = self;
        [_pickview show];
    }

}

-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{
    
    if (selectIndex==1) {
        [btn1 setTitle:[NSString stringWithFormat:@"文胸 (%@)",resultString] forState:UIControlStateNormal];
    }
    
    if (selectIndex==2) {
        [btn2 setTitle:[NSString stringWithFormat:@"底裤 (%@)",resultString] forState:UIControlStateNormal];
    }

}




- (IBAction)gotoClosetListAction:(id)sender {
    
    MyClosetListViewController *lstvc = [[MyClosetListViewController alloc] initWithNibName:@"MyClosetListViewController" bundle:nil];
    [self.navigationController pushViewController:lstvc animated:YES];
    
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
