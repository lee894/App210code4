//
//  MyClosetNan2ViewController.m
//  MyAimerApp
//
//  Created by yanglee on 15/6/8.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "MyClosetKid2ViewController.h"
#import "MyClosetNan3ViewController.h"
#import "MyClosetKid3ViewController.h"
#import "MyClosetKidGril3ViewController.h"

@interface MyClosetKid2ViewController ()
{
    __weak IBOutlet UIButton *girlBtn;
    __weak IBOutlet UIButton *littleGrilBtn;
    __weak IBOutlet UIButton *littleBoyBtn;
    
    int selectIndex;
}
@end

@implementation MyClosetKid2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"私人衣橱"];
    [self createBackBtnWithType:0];
    [self NewHiddenTableBarwithAnimated:YES];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)typeSelectAction:(id)sender {
    UIButton *btn = (UIButton*)sender;
//    btn.selected = !btn.selected;

    if (btn.tag == 1) {
        
        girlBtn.selected = YES;
        littleGrilBtn.selected = NO;
        littleBoyBtn.selected = NO;
    }else if (btn.tag == 2) {
        girlBtn.selected = NO;
        littleGrilBtn.selected = YES;
        littleBoyBtn.selected = NO;
    }else if (btn.tag == 3) {
        girlBtn.selected = NO;
        littleGrilBtn.selected = NO;
        littleBoyBtn.selected = YES;
    }
    
    selectIndex = btn.tag;
}



- (IBAction)nextBtnAction:(id)sender {
    
    if (selectIndex == 0) {
        [MYCommentAlertView showMessage:@"您还未选择" target:nil];
        return;
    }
    
    if (selectIndex == 1) {
        //12岁以上
        MyClosetKidGril3ViewController *nan3vc = [[MyClosetKidGril3ViewController alloc] initWithNibName:@"MyClosetKidGril3ViewController" bundle:nil];
        [self.navigationController pushViewController:nan3vc animated:YES];
        
    }else{
    
        MyClosetKid3ViewController *nan3vc = [[MyClosetKid3ViewController alloc] initWithNibName:@"MyClosetKid3ViewController" bundle:nil];
        nan3vc.itype = selectIndex-1;
        [self.navigationController pushViewController:nan3vc animated:YES];
    }
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
