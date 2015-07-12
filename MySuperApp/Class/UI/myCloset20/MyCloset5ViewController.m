//
//  MyCloset5ViewController.m
//  MyAimerApp
//
//  Created by yanglee on 15/5/27.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "MyCloset5ViewController.h"
#import "MyClosetListViewController.h"
#import "ZHPickView.h"
#import "BindPhoneViewController.h"
#import "MyClosetListViewController.h"
#import "SingletonState.h"

@interface MyCloset5ViewController ()<ZHPickViewDelegate>
{
    
    
    NSString *selectBra;
    NSString *selectUnderpants;
    
    MainpageServ *mainSev;
    MyClosetInfo *_closetinfo;
    
    IBOutlet UIButton *btn1;
    IBOutlet UIButton *btn2;
    
    NSInteger selectIndex;
    
    NSMutableArray *arr_selectFreque;
}
@end

@implementation MyCloset5ViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.arr_selectStyle = [[NSMutableArray alloc] initWithCapacity:0];
        self.arr_selectSize = [[NSMutableArray alloc] initWithCapacity:0];
        arr_selectFreque = [[NSMutableArray alloc] initWithCapacity:0];

    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    selectBra = @"";
    selectUnderpants = @"";
    
    [self setTitle:@"私人衣橱"];
    [self createBackBtnWithType:0];
    
    mainSev = [[MainpageServ alloc] init];
    mainSev.delegate = self;
    
    // Do any additional setup after loading the view from its nib.
}



- (IBAction)typeSelectAction:(id)sender {
    UIButton *btn = (UIButton*)sender;
    btn.selected = YES;
    
    selectIndex = btn.tag;
    
    if (btn.tag == 1) {
        //支持自定义数组：
        NSArray *array=@[@[@"三个月",@"半年（建议）",@"一年"]];
        ZHPickView* _pickview=[[ZHPickView alloc] initPickviewWithArray:array isHaveNavControler:NO];
        _pickview.delegate = self;
        [_pickview show];
    }
    else if (btn.tag == 2) {
        //支持自定义数组：
        NSArray *array=@[@[@"一个月",@"三个月（建议）",@"半年"]];
        ZHPickView* _pickview=[[ZHPickView alloc] initPickviewWithArray:array isHaveNavControler:NO];
        _pickview.delegate = self;
        [_pickview show];
    }
}


-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{
    
    if (selectIndex==1) {
        [btn1 setTitle:[NSString stringWithFormat:@"文胸 (%@)",resultString] forState:UIControlStateNormal];
        
        if ([resultString isEqualToString:@"三个月"]) {
        selectBra = @"B";
        }
        if ([resultString isEqualToString:@"半年（建议）"]) {
            selectBra = @"C";
        }
        if ([resultString isEqualToString:@"一年"]) {
            selectBra = @"D";
        }
    }
    
    if (selectIndex==2) {
        [btn2 setTitle:[NSString stringWithFormat:@"底裤 (%@)",resultString] forState:UIControlStateNormal];
        
        if ([resultString isEqualToString:@"一个月"]) {
            selectUnderpants = @"A";
        }
        if ([resultString isEqualToString:@"三个月（建议）"]) {
            selectUnderpants = @"B";
        }
        if ([resultString isEqualToString:@"半年"]) {
            selectUnderpants = @"C";
        }
        
    }
}

//定期更换提醒
-(IBAction)aLertChangeAction:(id)sender{
    
    if (![self isSelectFrequence]) {
        return;
    }

    [mainSev alertChangeMyClost:selectBra andDown:selectUnderpants];
}



-(BOOL)isSelectFrequence{

    if ([selectBra isEqualToString:@""]) {
        [SBPublicAlert showMBProgressHUD:@"请您选择文胸的更换频率" andWhereView:self.view hiddenTime:AlertShowTime];
        return NO;
    }
    
    if ([selectUnderpants isEqualToString:@""]) {
        
        [SBPublicAlert showMBProgressHUD:@"请您选择底裤的更换频率" andWhereView:self.view hiddenTime:AlertShowTime];
        return NO;
    }
    
    [arr_selectFreque addObject:selectBra];
    [arr_selectFreque addObject:selectUnderpants];

    return YES;
}

//跳过直接进入 衣橱
- (IBAction)gotoClosetListAction:(id)sender {
    
    if (![self isSelectFrequence]) {
        return;
    }
    
    NSString *size = [self.arr_selectSize componentsJoinedByString:@","];
    NSString *style = [self.arr_selectStyle componentsJoinedByString:@","];
    NSString *freeq = [arr_selectFreque componentsJoinedByString:@","];

    [mainSev getaddwardrobeupdata:@"女士"
                         andcrowd:@"女士"
                     andfrequency:freeq
                          andsize:size
                         andprops:style
                          andtype:@"woman"];
}



-(void)gotoMyclosetList
{
    MyClosetListViewController *lstvc = [[MyClosetListViewController alloc] initWithNibName:@"MyClosetListViewController" bundle:nil];
    [self.navigationController pushViewController:lstvc animated:YES];

}


#pragma mark--- Severvice
-(void)serviceStarted:(ServiceType)aHandle{
}

-(void)serviceFailed:(ServiceType)aHandle{
    [SBPublicAlert hideMBprogressHUD:self.view];
    
    if (aHandle == ENeedbindPhone) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"爱慕提示" message:@"更换频率提醒需要您先绑定手机" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"绑定", nil];
        alert.delegate = self;
        alert.tag = 1099;
        [alert show];
    }
}

-(void)serviceFinished:(ServiceType)aHandle withmodel:(id)amodel{
    [SBPublicAlert hideMBprogressHUD:self.view];
    
    if(![amodel isKindOfClass:[LBaseModel class]])
    {
        switch ((NSUInteger)aHandle) {
            case Http_changefrequency20_Tag:
            {
                
                NSString *moblie = @"";
                if ([amodel respondsToSelector:@selector(objectForKey:)]) {
                    moblie = [amodel objectForKey:@"mobile" isDictionary:nil];
                }
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"爱慕提示" message:[NSString stringWithFormat:@"更换提醒将以短信的形式发送到您的手机(%@)，退订可以再手机中操作",moblie] delegate:self cancelButtonTitle:@"进入衣橱" otherButtonTitles:nil];
                alert.delegate = self;
                alert.tag = 1100;
                [alert show];
            }
                break;
                
                
            case Http_addwardrobeup20_Tag:
            {
                [self gotoMyclosetList];
            }
                break;
                
            default:
                break;
        }
        return;
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (alertView.tag == 1099) {
        if (buttonIndex == 1) {
            
            //绑定手机
            BindPhoneViewController *tempBindPhone = [[BindPhoneViewController alloc] initWithNibName:@"BindPhoneViewController" bundle:nil];
            [self.navigationController  pushViewController:tempBindPhone animated:YES];
            
        }
    }
    
    if (alertView.tag == 1100) {
        [self gotoClosetListAction:nil];
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
