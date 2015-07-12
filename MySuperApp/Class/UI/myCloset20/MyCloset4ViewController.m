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

@interface MyCloset4ViewController ()<ServiceDelegate,ZHPickViewDelegate>
{
    
    MainpageServ *mainSev;

    
    IBOutlet UIButton* btn1;
    IBOutlet UIButton* btn2;
    IBOutlet UIButton* btn3;
    
    ZHPickView* _pickview1;
    ZHPickView* _pickview2;
    ZHPickView* _pickview3;

    NSInteger selectIndex;
    
    NSString *str1;
    NSString *str2;
    NSString *str3;

    NSMutableArray *arr_selectSize;
}

@end

@implementation MyCloset4ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.arr_selectStyle = [[NSMutableArray alloc] initWithCapacity:0];
        arr_selectSize = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];

    [self setTitle:@"私人衣橱"];
    [self createBackBtnWithType:0];
    
    str1 = @"";
    str2 = @"";
    str3 = @"";
    
    mainSev = [[MainpageServ alloc] init];
    mainSev.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated{

    [_pickview1 remove];
    [_pickview2 remove];
    [_pickview3 remove];
    
}


- (IBAction)typeSelectAction:(id)sender {
    UIButton *btn = (UIButton*)sender;
    btn.selected = YES;
    
    selectIndex = btn.tag;
    
    if (btn.tag == 1) {
        //支持自定义数组：  女  文胸
        NSArray *array=@[@[@"A65",@"B65",@"C65",@"A70",@"B70",@"C70",@"D70",@"E70",@"F70",@"A75",@"B75",@"C75",@"D75",@"E75",@"F75",@"A80",@"B80",@"C80",@"D80",@"E80",@"F80",@"A85",@"B85",@"C85",@"D85",@"E85",@"F85",@"A90",@"B90",@"C90",@"D90",@"E90",@"F90",@"A100",@"B100",@"C100",@"D100",@"E100",@"F100"]];
        if (!_pickview1) {
            _pickview1 =[[ZHPickView alloc] initPickviewWithArray:array isHaveNavControler:NO];
        }
        _pickview1.delegate = self;
        [_pickview1 show];
    }
    else if (btn.tag == 2) {
        //支持自定义数组： 女  底裤
        NSArray *array=@[@[@"64",@"70",@"76",@"82",@"90",@"95",@"100",@"110",@"155",@"160",@"165",@"170",@"175"]];
        if (!_pickview2) {
            _pickview2=[[ZHPickView alloc] initPickviewWithArray:array isHaveNavControler:NO];
        }
        _pickview2.delegate = self;
        [_pickview2 show];
    }
    else if (btn.tag == 3) {
        //支持自定义数组：女睡衣
        NSArray *array=@[@[@"155",@"160",@"165",@"170",@"175",@"180"]];
        if (!_pickview3) {
            _pickview3=[[ZHPickView alloc] initPickviewWithArray:array isHaveNavControler:NO];
        }
        _pickview3.delegate = self;
        [_pickview3 show];
    }
}

-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{
    
    if (selectIndex==1) {
        [btn1 setTitle:[NSString stringWithFormat:@"文胸尺码 (%@)",resultString] forState:UIControlStateNormal];
        str1 = resultString;

    }
    
    if (selectIndex==2) {
        [btn2 setTitle:[NSString stringWithFormat:@"底裤尺码 (%@)",resultString] forState:UIControlStateNormal];
        str2 = resultString;

    }
    
    if (selectIndex==3) {
        [btn3 setTitle:[NSString stringWithFormat:@"睡衣尺码 (%@)",resultString] forState:UIControlStateNormal];
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


//确定尺码，下一步   《选择更换频次》
- (IBAction)slectPerAction:(id)sender {
    
    if (![self selectMySize]) {
        return;
    }

    MyCloset5ViewController *clv2 = [[MyCloset5ViewController alloc] initWithNibName:@"MyCloset5ViewController" bundle:nil];
    [clv2.arr_selectSize addObjectsFromArray:arr_selectSize];
    [clv2.arr_selectStyle addObjectsFromArray:self.arr_selectStyle];
    [self.navigationController pushViewController:clv2 animated:YES];
}


//不知道尺码
- (IBAction)dontKnowSizeAction:(id)sender {
    
    MyCloset6ViewController *clv2 = [[MyCloset6ViewController alloc] initWithNibName:@"MyCloset6ViewController" bundle:nil];
    [self.navigationController pushViewController:clv2 animated:YES];
}


// 跳过===  去衣橱了！！！
- (IBAction)gotoClosetListAction:(id)sender {


    
    MyCloset5ViewController *clv2 = [[MyCloset5ViewController alloc] initWithNibName:@"MyCloset5ViewController" bundle:nil];
    [clv2.arr_selectStyle addObjectsFromArray:self.arr_selectStyle];
    [self.navigationController pushViewController:clv2 animated:YES];
    
//    NSString *size = [arr_selectSize componentsJoinedByString:@","];
//    NSString *style = [self.arr_selectStyle componentsJoinedByString:@","];
//
//    [mainSev getaddwardrobeupdata:@"女士"
//                         andcrowd:@"女士"
//                     andfrequency:@""
//                          andsize:size
//                         andprops:style
//                          andtype:@"woman"];
    
}

-(void)gotoClosetList{

    MyClosetListViewController *lstvc = [[MyClosetListViewController alloc] initWithNibName:@"MyClosetListViewController" bundle:nil];
    [self.navigationController pushViewController:lstvc animated:YES];
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
