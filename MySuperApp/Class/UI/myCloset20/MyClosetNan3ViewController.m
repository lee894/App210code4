//
//  MyClosetNan2ViewController.m
//  MyAimerApp
//
//  Created by yanglee on 15/6/8.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "MyClosetNan3ViewController.h"
#import "MyClosetListViewController.h"
#import "ZHPickView.h"

@interface MyClosetNan3ViewController ()<ZHPickViewDelegate>
{
    IBOutlet UIButton* dibtn;
    IBOutlet UIButton* fubtn;
    
    int selectIndex;


}
@end

@implementation MyClosetNan3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"私人衣橱"];
    [self createBackBtnWithType:0];
    [self NewHiddenTableBarwithAnimated:YES];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)typeSelectAction:(id)sender {
    UIButton *btn = (UIButton*)sender;
    btn.selected = YES;

    selectIndex = btn.tag;
    
    if (btn.tag == 1) {
        //支持自定义数组： 男  内裤
        //NSArray *array=@[@[@"1",@"小明",@"aa"],@[@"2",@"大黄",@"bb"],@[@"3",@"企鹅",@"cc"]];
        NSArray *array=@[@[@"165/80(S）",@"170/85（M)",@"175/90（L）",@"180/95（XL）",@"185/100（XXL）",@"190/105（XXXL）"]];
       ZHPickView* _pickview=[[ZHPickView alloc] initPickviewWithArray:array isHaveNavControler:NO];
        _pickview.delegate = self;
        [_pickview show];
    }
   else if (btn.tag == 2) {
        //支持自定义数组：
        //NSArray *array=@[@[@"1",@"小明",@"aa"],@[@"2",@"大黄",@"bb"],@[@"3",@"企鹅",@"cc"]];
        NSArray *array=@[@[@"165/90（S）",@"170/95（M）",@"175/100（L）",@"180/105（XL）",@"185/110（XXL）",@"190/115(XXXL)"]];
        ZHPickView* _pickview=[[ZHPickView alloc] initPickviewWithArray:array isHaveNavControler:NO];
       _pickview.delegate = self;
        [_pickview show];
    }
}

-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{

    if (selectIndex==1) {
        [dibtn setTitle:[NSString stringWithFormat:@"底裤尺码 (%@)",resultString] forState:UIControlStateNormal];
    }
    
    if (selectIndex==2) {
        [fubtn setTitle:[NSString stringWithFormat:@"家居服尺码 (%@)",resultString] forState:UIControlStateNormal];
    }
}


- (IBAction)nextBtnAction:(id)sender {
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
