//
//  MyCloset3ViewController.m
//  MyAimerApp
//
//  Created by yanglee on 15/5/27.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "MyCloset3ViewController.h"
#import "MyCloset4ViewController.h"
#import "MyCloset5ViewController.h"


@interface MyCloset3ViewController ()
{
   IBOutlet UIButton *btn1;
   IBOutlet UIButton *btn2;
   IBOutlet UIButton *btn3;

}
@end

@implementation MyCloset3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setTitle:@"私人衣橱"];
    [self createBackBtnWithType:0];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)typeAction:(id)sender{

    UIButton *btn = (UIButton*)sender;
    if (btn.tag == 1) {
        btn1.selected = YES;
        btn2.selected = NO;
        btn3.selected = NO;
        
    }else if (btn.tag == 2){
        
        btn1.selected = NO;
        btn2.selected = YES;
        btn3.selected = NO;
    }else{
        
        btn1.selected = NO;
        btn2.selected = NO;
        btn3.selected = YES;
    }
    
    
}


- (IBAction)nextBtnAction:(id)sender{
    
    
    MyCloset4ViewController *clv2 = [[MyCloset4ViewController alloc] initWithNibName:@"MyCloset4ViewController" bundle:nil];
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
