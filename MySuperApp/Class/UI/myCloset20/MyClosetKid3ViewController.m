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

@interface MyClosetKid3ViewController ()<ZHPickViewDelegate,ServiceDelegate>
{
    IBOutlet UIButton* dibtn;
    IBOutlet UIButton* fubtn;
    
    NSInteger selectIndex;
    
    NSString *str1;
    NSString *str2;
    MainpageServ *mainSev;
    __weak IBOutlet UILabel *titleLab;
    
    NSMutableArray *arr_selectSize;
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
    
    
    arr_selectSize = [[NSMutableArray alloc] initWithCapacity:0];
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
            array =   @[@[@"100",@"110",@"120",@"130",@"140",@"150",@"160",@"170"]];
        }else{
            //nan
            array =   @[@[@"100",@"110",@"120",@"130",@"140",@"150",@"160",@"170",@"175",@"180"]];
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
           array =   @[@[@"100",@"110",@"120",@"130",@"140",@"150",@"160",@"170"]];

       }else{
       //nan
           array =   @[@[@"100",@"110",@"120",@"130",@"140",@"150",@"160",@"170",@"175",@"180"]];
       }
       ZHPickView* _pickview=[[ZHPickView alloc] initPickviewWithArray:array isHaveNavControler:NO];
       _pickview.delegate = self;
        [_pickview show];
    }
}

-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{

    if (selectIndex==1) {
        [dibtn setTitle:[NSString stringWithFormat:@"底裤尺码 (%@)",resultString] forState:UIControlStateNormal];
        str1 = resultString;
    }
    
    if (selectIndex==2) {
        [fubtn setTitle:[NSString stringWithFormat:@"家居服尺码 (%@)",resultString] forState:UIControlStateNormal];
        str2 = resultString;
    }
}



-(BOOL)selectMySize{
    
    if (str1.length<1 || str2.length<1) {
        [SBPublicAlert showMBProgressHUD:@"请您选择完您的尺码" andWhereView:self.view hiddenTime:AlertShowTime];
        return NO;
    }
    
    [arr_selectSize addObject:str1];
    [arr_selectSize addObject:str2];
    return YES;
}


- (IBAction)nextBtnAction:(id)sender {
    
    if (![self selectMySize]) {
        return;
    }
    
    NSString *name = self.itype == 1 ?@"女童":@"男童";
    NSString *name2 = self.itype == 1 ?@"girl":@"boy";
    NSString *size = [arr_selectSize componentsJoinedByString:@","];
    
    [mainSev getaddwardrobeupdata:name
                         andcrowd:name
                     andfrequency:@""
                          andsize:size
                         andprops:@""
                          andtype:name2];
}




#pragma mark--- Severvice
-(void)serviceStarted:(ServiceType)aHandle{
}

-(void)serviceFailed:(ServiceType)aHandle{
    [SBPublicAlert hideMBprogressHUD:self.view];
    
}

-(void)serviceFinished:(ServiceType)aHandle withmodel:(id)amodel{
    [SBPublicAlert hideMBprogressHUD:self.view];
    
    if(![amodel isKindOfClass:[LBaseModel class]])
    {
        switch ((NSUInteger)aHandle) {
            case Http_addwardrobeup20_Tag:
            {
                [self gotoClosetList];
            }
                break;
                
            default:
                break;
        }
        return;
    }
}


-(void)gotoClosetList{
    
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
