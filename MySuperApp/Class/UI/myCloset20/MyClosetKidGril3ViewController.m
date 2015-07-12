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
#import "MyCloset6ViewController.h"


@interface MyClosetKidGril3ViewController ()<ZHPickViewDelegate,ServiceDelegate>
{
    IBOutlet UIButton* dibtn;
    IBOutlet UIButton* fubtn;
    IBOutlet UIButton* fubtn3;

    MainpageServ *mainSev;
    NSInteger selectIndex;
    
    
    NSString *str1;
    NSString *str2;
    NSString *str3;
    NSMutableArray *arr_selectSize;
}

@end

@implementation MyClosetKidGril3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"私人衣橱"];
    [self createBackBtnWithType:0];
    [self NewHiddenTableBarwithAnimated:YES];
    
    arr_selectSize = [[NSMutableArray alloc] initWithCapacity:0];

    
    mainSev = [[MainpageServ alloc] init];
    mainSev.delegate = self;
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
        NSArray *array=@[@[@"100",@"110",@"120",@"130",@"140",@"150",@"160",@"170"]];
        ZHPickView* _pickview=[[ZHPickView alloc] initPickviewWithArray:array isHaveNavControler:NO];
       _pickview.delegate = self;
        [_pickview show];
    }
   else if (btn.tag == 3) {
       //支持自定义数组：女孩睡衣
       NSArray *array=@[@[@"100",@"110",@"120",@"130",@"140",@"150",@"160",@"170"]];
       ZHPickView* _pickview=[[ZHPickView alloc] initPickviewWithArray:array isHaveNavControler:NO];
       _pickview.delegate = self;
       [_pickview show];
   }
}

-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{

    if (selectIndex==1) {
        [dibtn setTitle:[NSString stringWithFormat:@"文胸尺码 (%@)",resultString] forState:UIControlStateNormal];
        str1 = resultString;

    }
    
    if (selectIndex==2) {
        [fubtn setTitle:[NSString stringWithFormat:@"底裤尺码 (%@)",resultString] forState:UIControlStateNormal];
        str2 = resultString;

    }
    
    if (selectIndex==3) {
        [fubtn3 setTitle:[NSString stringWithFormat:@"睡衣尺码 (%@)",resultString] forState:UIControlStateNormal];
        str3 = resultString;
    }
}

-(BOOL)selectMySize{
    
    
    if ([str1 description].length<1 || [str2 description].length<1  || [str3 description].length<1 ) {
        [SBPublicAlert showMBProgressHUD:@"请您选择完您的尺码" andWhereView:self.view hiddenTime:AlertShowTime];
        return NO;
    }
    
    [arr_selectSize addObject:str1];
    [arr_selectSize addObject:str2];
    [arr_selectSize addObject:str3];
    
    return YES;
}



- (IBAction)nextBtnAction:(id)sender {

    UIButton *btn = (UIButton*)sender;
    if (btn.tag == 1) {
        
        //进入衣橱~
        
        if (![self selectMySize]) {
            return;
        }
        
        
        NSString *size = [arr_selectSize componentsJoinedByString:@","];
        
        [mainSev getaddwardrobeupdata:@"少女"
                             andcrowd:@"少女"
                         andfrequency:@""
                              andsize:size
                             andprops:@""
                              andtype:@"lass"];
        
    }else{
    
        //预约测体
        
        MyCloset6ViewController *lstvc = [[MyCloset6ViewController alloc] initWithNibName:@"MyCloset6ViewController" bundle:nil];
        [self.navigationController pushViewController:lstvc animated:YES];
        
    }
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
