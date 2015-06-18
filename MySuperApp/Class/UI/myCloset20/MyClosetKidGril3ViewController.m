//
//  MyClosetNan2ViewController.m
//  MyAimerApp
//
//  Created by yanglee on 15/6/8.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "MyClosetKidGril3ViewController.h"
#import "ZHPickView.h"
#import "MyClosetListViewController.h"


@interface MyClosetKidGril3ViewController ()<ZHPickViewDelegate>
{
    IBOutlet UIButton* dibtn;
    IBOutlet UIButton* fubtn;
    IBOutlet UIButton* fubtn3;

    
    NSInteger selectIndex;


}
@end

@implementation MyClosetKidGril3ViewController

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
        //支持自定义数组：  女孩文胸
        NSArray *array=@[@[@"A65",@"B65",@"C65",@"A70",@"B70",@"C70",@"A75",@"B75",@"C75",@"A80",@"B80",@"C80",@"100",@"110",@"120",@"130",@"140",@"150",@"160",@"170"]];
       ZHPickView* _pickview=[[ZHPickView alloc] initPickviewWithArray:array isHaveNavControler:NO];
        _pickview.delegate = self;
        [_pickview show];
    }
   else if (btn.tag == 2) {
        //支持自定义数组： 女孩底裤
        NSArray *array=@[@[@[@"100",@"110",@"120",@"130",@"140",@"150",@"160",@"170"]]];
        ZHPickView* _pickview=[[ZHPickView alloc] initPickviewWithArray:array isHaveNavControler:NO];
       _pickview.delegate = self;
        [_pickview show];
    }
   else if (btn.tag == 3) {
       //支持自定义数组：女孩睡衣
       NSArray *array=@[@[@[@"100",@"110",@"120",@"130",@"140",@"150",@"160",@"170"]]];
       ZHPickView* _pickview=[[ZHPickView alloc] initPickviewWithArray:array isHaveNavControler:NO];
       _pickview.delegate = self;
       [_pickview show];
   }
}

-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{

    if (selectIndex==1) {
        [dibtn setTitle:[NSString stringWithFormat:@"文胸尺码 (%@)",resultString] forState:UIControlStateNormal];
    }
    
    if (selectIndex==2) {
        [fubtn setTitle:[NSString stringWithFormat:@"底裤尺码 (%@)",resultString] forState:UIControlStateNormal];
    }
    
    if (selectIndex==3) {
        [fubtn3 setTitle:[NSString stringWithFormat:@"睡衣尺码 (%@)",resultString] forState:UIControlStateNormal];
    }
}


- (IBAction)nextBtnAction:(id)sender {

    UIButton *btn = (UIButton*)sender;
    if (btn.tag == 1) {
        
        MyClosetListViewController *vc = [[MyClosetListViewController alloc] initWithNibName:@"MyClosetListViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{
    
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
