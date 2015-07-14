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

@interface MyClosetNan3ViewController ()<ZHPickViewDelegate,ServiceDelegate>
{
    IBOutlet UIButton* dibtn;
    IBOutlet UIButton* fubtn;
    
    NSString *str1;
    NSString *str2;
    
    
    
    ZHPickView* _pickview1;
    ZHPickView* _pickview2;
    
    NSInteger selectIndex;
    MainpageServ *mainSev;

    NSMutableArray *arr_selectSize;
}
@end

@implementation MyClosetNan3ViewController


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
    [self NewHiddenTableBarwithAnimated:YES];
    
    str1 = @"";
    str2 = @"";
    
    mainSev = [[MainpageServ alloc] init];
    mainSev.delegate = self;
}


-(void)viewWillDisappear:(BOOL)animated{
    [self removePicker];
    
}

-(void)removePicker{
    if (_pickview1) {
        [_pickview1 remove];
    }
    if (_pickview2) {
        [_pickview2 remove];
    }
}

- (IBAction)typeSelectAction:(id)sender {
    UIButton *btn = (UIButton*)sender;
    btn.selected = YES;
    
    [self removePicker];

    selectIndex = btn.tag;
    
    if (btn.tag == 1) {
        //支持自定义数组： 男  内裤
        NSArray *array=@[@[@"165",@"170",@"175",@"180",@"185",@"190"]];
        if (!_pickview1) {
            _pickview1=[[ZHPickView alloc] initPickviewWithArray:array isHaveNavControler:NO];
        }
        _pickview1.delegate = self;
        [_pickview1 show];
    }
   else if (btn.tag == 2) {
        //支持自定义数组：
       NSArray *array=@[@[@"165",@"170",@"175",@"180",@"185",@"190"]];
       if (!_pickview2) {
           _pickview2=[[ZHPickView alloc] initPickviewWithArray:array isHaveNavControler:NO];
       }
       _pickview2.delegate = self;
        [_pickview2 show];
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
    
    if ([str1 description].length<1 || [str2 description].length<1) {
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
    
    NSString *size = [arr_selectSize componentsJoinedByString:@","];
    NSString *style = [self.arr_selectStyle componentsJoinedByString:@","];
    
    [mainSev getaddwardrobeupdata:@"男士"
                         andcrowd:@"男士"
                     andfrequency:@""
                          andsize:size
                         andprops:style
                          andtype:@"man"];
    [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];

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
    
    if ([[SingletonState sharedStateInstance].str_wardrobe hasSuffix:@","]) {
        
        [SingletonState sharedStateInstance].str_wardrobe = [NSString stringWithFormat:@"%@%@",[SingletonState sharedStateInstance].str_wardrobe,@"2"];
    }else{
        [SingletonState sharedStateInstance].str_wardrobe = [NSString stringWithFormat:@"%@,%@",[SingletonState sharedStateInstance].str_wardrobe,@"2"];
    }
    

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
