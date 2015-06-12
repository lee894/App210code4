//
//  MyCloset2ViewController.m
//  MyAimerApp
//
//  Created by yanglee on 15/5/27.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "MyCloset2ViewController.h"
#import "MyCloset3ViewController.h"


@interface MyCloset2ViewController ()
{
    __weak IBOutlet UILabel *title2Lab;

}
@end

@implementation MyCloset2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setTitle:@"私人衣橱2"];
    [self createBackBtnWithType:0];
    
    if (self.selectType == 2) {
    title2Lab.text = @"您是哪种魅力男人？";
    }
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)typeBtnAction:(id)sender{
 
    UIButton*btn = (UIButton*)sender;
    btn.selected = !btn.selected;
}


- (IBAction)nextBtnAction:(id)sender{
    
    MyCloset3ViewController *clv2 = [[MyCloset3ViewController alloc] initWithNibName:@"MyCloset3ViewController" bundle:nil];
    [self.navigationController pushViewController:clv2 animated:YES];
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
