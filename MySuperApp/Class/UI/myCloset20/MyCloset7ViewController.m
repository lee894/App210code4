//
//  MyCloset7ViewController.m
//  MyAimerApp
//
//  Created by yanglee on 15/6/17.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "MyCloset7ViewController.h"
#import "MyButton.h"
#import "ZHPickView.h"
#import "BindPhoneViewController.h"

@interface MyCloset7ViewController ()<ZHPickViewDelegate,ServiceDelegate>
{
    IBOutlet UIScrollView *myScrollV;
    MainpageServ *mainSev;
    MybespeakInfo *bespeakInfo;
    
    MyButton *btn1;
    MyButton *btn2;
    NSMutableArray *arrstoreid;

    NSString *selectStore;
    NSString *selecttime;
    
    
    ZHPickView* _pickview1;
    ZHPickView* _pickview2;
    
    
    BOOL isshowPicker;

}



@end

@implementation MyCloset7ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"预约测体"];
    [self createBackBtnWithType:0];
    
    isshowPicker = NO;
    
    selectStore = @"";
    selecttime = @"";
    arrstoreid = [[NSMutableArray alloc] initWithCapacity:0];
    
    mainSev = [[MainpageServ alloc] init];
    mainSev.delegate = self;
    [mainSev getbespeak];
    [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];

    
    [myScrollV addSubview:[self createCellView:@[@"门店",@"时间"]]];
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


-(UIView *)createCellView:(NSArray*)subSortArray{
    
    NSInteger bgvH = 80;
//    NSInteger lineNum = 1; //每行的数量
    
    NSInteger ySP = 22;  //距离顶部的位置
    NSInteger SP = 30;  //间距
    NSInteger pW = (ScreenWidth-60);  //商品宽度
    NSInteger pH = 40;  //商品高度
    
    //行数
    NSInteger subSortbtnNum = [subSortArray count];//([subSortArray count]%lineNum == 0? [subSortArray count]/lineNum :[subSortArray count]/lineNum+1);
    
    UIView *bgv = [[UIView alloc] initWithFrame:CGRectMake(0, bgvH, ScreenWidth, subSortbtnNum*100)];
    [bgv setBackgroundColor:[UIColor clearColor]];
    
    
    
    btn1 = [MyButton buttonWithType:UIButtonTypeCustom];
    [btn1 setFrame:CGRectMake(SP , ySP, pW, pH)];
    [btn1 addTarget:self action:@selector(typeAction:) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setTitleColor:[UIColor colorWithHexString:@"#888888"] forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor colorWithHexString:@"#c8002c"] forState:UIControlStateSelected];
    btn1.tag = 1;
    [btn1 setBackgroundImage:[UIImage imageNamed:@"sryc_laber_class_big_normal.png"] forState:UIControlStateNormal];
    [btn1 setBackgroundImage:[UIImage imageNamed:@"sryc_laber_class_big_select.png"] forState:UIControlStateSelected];
    [btn1 setBackgroundColor:[UIColor clearColor]];
    [btn1 setTitle:@"门店" forState:UIControlStateNormal];
    [bgv addSubview:btn1];
    
    
    btn2 = [MyButton buttonWithType:UIButtonTypeCustom];
    [btn2 setFrame:CGRectMake(SP , ySP + 1*(pH + ySP), pW, pH)];
    [btn2 addTarget:self action:@selector(typeAction:) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setTitleColor:[UIColor colorWithHexString:@"#888888"] forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor colorWithHexString:@"#c8002c"] forState:UIControlStateSelected];
    btn2.tag = 2;
    [btn2 setBackgroundImage:[UIImage imageNamed:@"sryc_laber_class_big_normal.png"] forState:UIControlStateNormal];
    [btn2 setBackgroundImage:[UIImage imageNamed:@"sryc_laber_class_big_select.png"] forState:UIControlStateSelected];
    [btn2 setBackgroundColor:[UIColor clearColor]];
    [btn2 setTitle:@"时间" forState:UIControlStateNormal];
    [bgv addSubview:btn2];
    
    
    NSInteger H = 2*ySP + (pH +ySP)* subSortbtnNum;
    
    UIButton *nextbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextbtn setFrame:CGRectMake(30,H,ScreenWidth-60,40)];
    [nextbtn addTarget:self action:@selector(nextBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [nextbtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    [nextbtn setBackgroundImage:[UIImage imageNamed:@"big_btn_r_normal.png"] forState:UIControlStateNormal];
    [nextbtn setBackgroundImage:[UIImage imageNamed:@"big_btn_r_hover.png"] forState:UIControlStateHighlighted];
    
    [nextbtn setBackgroundColor:[UIColor clearColor]];
    [nextbtn setTitle:@"申请预约" forState:UIControlStateNormal];
    [bgv addSubview:nextbtn];
    
    H += 60;
    
    [bgv setFrame:CGRectMake(0, bgvH, ScreenWidth, H)];
    
    [myScrollV setContentSize:CGSizeMake(0, H+100)];
    
    return bgv;
}


-(void)typeAction:(id)sender{

    MyButton*btn = (MyButton*)sender;
    
    [self removePicker];
    
    
    [mainSev getbespeak];
    [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
    
    
    if (!isshowPicker) {
        return;
    }
    
    
    if (btn.tag == 1) {
        //支持自定义数组：
        NSMutableArray *arr = [[NSMutableArray alloc]initWithCapacity:0];
        for (MybespeakData *dara in bespeakInfo.stores) {
            [arr addObject:dara.name];
            [arrstoreid addObject:dara.aid];
        }
        
        btn1.selected = YES;
        
        NSArray *array= @[arr];
        if (!_pickview1) {
            _pickview1=[[ZHPickView alloc] initPickviewWithArray:array isHaveNavControler:NO];
        }
        _pickview1.delegate = self;
        _pickview1.tag = btn.tag;
        [_pickview1 show];
    }
    else if (btn.tag == 2) {
        //支持自定义数组：
        
        //创建时间格式化实例对象
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //设置时间格式
        [dateFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
        
        //将时间字符串转换成NSDate类型的时间。dateFromString方法。
//        NSDate *tempDate = [NSDate date];
        if (!_pickview2) {
            _pickview2=[[ZHPickView alloc] initDatePickWithDate:nil datePickerMode:UIDatePickerModeDate isHaveNavControler:NO];
        }
        
        _pickview2.delegate = self;
        _pickview2.tag = btn.tag;
        [_pickview2 show];
        
        btn2.selected = YES;
    }
}

-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{
 
    if (pickView.tag == 1) {
        [btn1 setTitle:[NSString stringWithFormat:@"门店：%@",resultString] forState:UIControlStateNormal];
    }
    if (pickView.tag == 2) {
        selecttime = resultString;
        [btn2 setTitle:[NSString stringWithFormat:@"时间：%@",resultString] forState:UIControlStateNormal];
    }
    
}

-(void)toobarDonBtnHave:(ZHPickView *)pickView andIndex:(NSInteger)index{

    if (pickView.tag == 1) {
        selectStore = [arrstoreid objectAtIndex:index];
        NSLog(@"---%@",selectStore);
    }
}



-(void)nextBtnAction:(id)sener
{
    if ([selectStore isEqualToString:@""]) {
        
        [SBPublicAlert showMBProgressHUD:@"请您选择预约门店" andWhereView:self.view hiddenTime:AlertShowTime];
        return;
    }
    
    if ([selecttime isEqualToString:@""]) {
        [SBPublicAlert showMBProgressHUD:@"请您选择预约时间" andWhereView:self.view hiddenTime:AlertShowTime];
        return;
    }
    
    
    NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"usersession"];
    
    [mainSev bespeakup:selectStore andTime:selecttime anduid:userid];
    [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
    
}


#pragma mark--- Severvice
-(void)serviceStarted:(ServiceType)aHandle{
}

-(void)serviceFailed:(ServiceType)aHandle{
    [SBPublicAlert hideMBprogressHUD:self.view];
    
    isshowPicker = NO;
    
    if (aHandle == ENeedbindPhone) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"爱慕提示" message:@"预约测体需要您先绑定手机" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"绑定", nil];
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
            case Http_bespeak20_Tag:
            {
                bespeakInfo = [[[MybespeakParser alloc] init] parsebespeakInfo:amodel];
                
                isshowPicker = YES;
                
            }
                break;
                
            case Http_bespeakup20_Tag:
            {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"爱慕提示" message:@"恭喜您预约成功" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles: nil];
                alert.delegate = self;
                alert.tag = 1098;
                [alert show];
            }
                
            default:
                break;
        }
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 1098) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    if (alertView.tag == 1099) {
        if (buttonIndex == 1) {
            
            //绑定手机
            BindPhoneViewController *tempBindPhone = [[BindPhoneViewController alloc] initWithNibName:@"BindPhoneViewController" bundle:nil];
            [self.navigationController  pushViewController:tempBindPhone animated:YES];
            
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
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
