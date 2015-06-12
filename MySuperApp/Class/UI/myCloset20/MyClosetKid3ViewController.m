//
//  MyClosetNan2ViewController.m
//  MyAimerApp
//
//  Created by yanglee on 15/6/8.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "MyClosetKid3ViewController.h"
#import "MyClosetListViewController.h"
#import "ZHPickView.h"

@interface MyClosetKid3ViewController ()<ZHPickViewDelegate>
{
    IBOutlet UIButton* dibtn;
    IBOutlet UIButton* fubtn;
    
    int selectIndex;

    __weak IBOutlet UILabel *titleLab;

}
@end

@implementation MyClosetKid3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"私人衣橱"];
    [self createBackBtnWithType:0];
    [self NewHiddenTableBarwithAnimated:YES];
    
    if (self.itype == 1) {
        titleLab.text = @"请选女童的尺码";
    }else{
        titleLab.text = @"请选男童的尺码";
    }
    
    
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)typeSelectAction:(id)sender {
    UIButton *btn = (UIButton*)sender;
    btn.selected = YES;

    selectIndex = btn.tag;
    
    if (btn.tag == 1) {
        //支持自定义数组： 上衣
        NSArray *array=@[];
        if (self.itype == 1) {
            //nv
            array =   @[@[@"100/52",@"110/56",@"120/60",@"130/64",@"140/64",@"150/68",@"160/72",@"170/76"]];
        }else{
            //nan
            array =   @[@[@"100/52",@"110/56",@"120/60",@"130/64",@"140/68",@"150/72",@"160/76",@"170/80"]];
        }
       ZHPickView* _pickview=[[ZHPickView alloc] initPickviewWithArray:array isHaveNavControler:NO];
        _pickview.delegate = self;
        [_pickview show];
    }
   else if (btn.tag == 2) {
        //支持自定义数组： 底裤
       NSArray *array= @[];
       if (self.itype == 1) {
           //nv
           array =   @[@[@"100/47",@"110/50",@"120/53",@"130/56",@"140/55",@"150/58",@"160/61",@"170/64"]];

       }else{
       //nan
           array =   @[@[@"100/50",@"110/53",@"120/56",@"130/59",@"140/60",@"150/63",@"160/66",@"170/69"]];
       }
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

    MyClosetListViewController *vc = [[MyClosetListViewController alloc] initWithNibName:@"MyClosetListViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
    
    

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
