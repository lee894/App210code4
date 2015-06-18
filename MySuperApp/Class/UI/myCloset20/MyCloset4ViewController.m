//
//  MyCloset4ViewController.m
//  MyAimerApp
//
//  Created by yanglee on 15/5/27.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "MyCloset4ViewController.h"
#import "MyCloset5ViewController.h"
#import "MyCloset6ViewController.h"
#import "MyClosetListViewController.h"
#import "ZHPickView.h"

@interface MyCloset4ViewController ()<ZHPickViewDelegate>
{
    
    IBOutlet UIButton* btn1;
    IBOutlet UIButton* btn2;
    IBOutlet UIButton* btn3;

    NSInteger selectIndex;


}
@end

@implementation MyCloset4ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self setTitle:@"私人衣橱4"];
    [self createBackBtnWithType:0];

}



- (IBAction)typeSelectAction:(id)sender {
    UIButton *btn = (UIButton*)sender;
    btn.selected = YES;
    
    selectIndex = btn.tag;
    
    if (btn.tag == 1) {
        //支持自定义数组：  女  文胸
        //NSArray *array=@[@[@"1",@"小明",@"aa"],@[@"2",@"大黄",@"bb"],@[@"3",@"企鹅",@"cc"]];
        NSArray *array=@[@[@"A65",@"B65",@"C65",@"A70",@"B70",@"C70",@"D70",@"E70",@"F70",@"A75",@"B75",@"C75",@"D75",@"E75",@"F75",@"A80",@"B80",@"C80",@"D80",@"E80",@"F80",@"A85",@"B85",@"C85",@"D85",@"E85",@"F85",@"A90",@"B90",@"C90",@"D90",@"E90",@"F90",@"A100",@"B100",@"C100",@"D100",@"E100",@"F100"]];
        ZHPickView* _pickview=[[ZHPickView alloc] initPickviewWithArray:array isHaveNavControler:NO];
        _pickview.delegate = self;
        [_pickview show];
    }
    else if (btn.tag == 2) {
        //支持自定义数组： 女  底裤
        NSArray *array=@[@[@"64",@"70",@"76",@"82",@"90",@"95",@"100",@"110",@"155",@"160",@"165",@"170",@"175"]];
        ZHPickView* _pickview=[[ZHPickView alloc] initPickviewWithArray:array isHaveNavControler:NO];
        _pickview.delegate = self;
        [_pickview show];
    }
    else if (btn.tag == 3) {
        //支持自定义数组：女睡衣
        NSArray *array=@[@[@"155",@"160",@"165",@"170",@"175",@"180"]];
        ZHPickView* _pickview=[[ZHPickView alloc] initPickviewWithArray:array isHaveNavControler:NO];
        _pickview.delegate = self;
        [_pickview show];
    }
}

-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{
    
    if (selectIndex==1) {
        [btn1 setTitle:[NSString stringWithFormat:@"文胸尺码 (%@)",resultString] forState:UIControlStateNormal];
    }
    
    if (selectIndex==2) {
        [btn2 setTitle:[NSString stringWithFormat:@"底裤尺码 (%@)",resultString] forState:UIControlStateNormal];
    }
    
    if (selectIndex==3) {
        [btn3 setTitle:[NSString stringWithFormat:@"睡衣尺码 (%@)",resultString] forState:UIControlStateNormal];
    }
}




//选择更换频次
- (IBAction)slectPerAction:(id)sender {

    MyCloset5ViewController *clv2 = [[MyCloset5ViewController alloc] initWithNibName:@"MyCloset5ViewController" bundle:nil];
    [self.navigationController pushViewController:clv2 animated:YES];
    
}


//不知道尺码
- (IBAction)dontKnowSizeAction:(id)sender {
    
    MyCloset6ViewController *clv2 = [[MyCloset6ViewController alloc] initWithNibName:@"MyCloset6ViewController" bundle:nil];
    [self.navigationController pushViewController:clv2 animated:YES];
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
