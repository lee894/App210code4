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
#import "MyButton.h"


@interface MyCloset3ViewController ()
{
   IBOutlet UIButton *btn1;
   IBOutlet UIButton *btn2;
   IBOutlet UIButton *btn3;
    
    
    IBOutlet UIScrollView *myScrollV;
    NSString *str_selectStyle; //已选中的穿衣之道。
    NSMutableArray *arr_btnStyle; //已选中的穿衣之道。


}
@end

@implementation MyCloset3ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.arr_selectStyle = [[NSMutableArray alloc] initWithCapacity:0];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setTitle:@"私人衣橱"];
    [self createBackBtnWithType:0];
    
    str_selectStyle = @"";
    arr_btnStyle = [[NSMutableArray alloc] initWithCapacity:0];
    
    
    [myScrollV addSubview:[self createCellView:self.closetinfo.chuanyizhidao]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(UIView *)createCellView:(NSArray*)subSortArray{
    
    NSInteger bgvH = 80;
    NSInteger lineNum = 1; //每行的数量
    
    NSInteger ySP = 22;  //距离顶部的位置
    NSInteger SP = 30;  //间距
    NSInteger pW = (ScreenWidth-60);  //商品宽度
    NSInteger pH = 40;  //商品高度
    //    NSInteger imgH = 154; //商品图片的高度
    
    //行数
    NSInteger subSortbtnNum = [subSortArray count];//([subSortArray count]%lineNum == 0? [subSortArray count]/lineNum :[subSortArray count]/lineNum+1);
    
    UIView *bgv = [[UIView alloc] initWithFrame:CGRectMake(0, bgvH, ScreenWidth, subSortbtnNum*100)];
    [bgv setBackgroundColor:[UIColor clearColor]];
    
    
    for (NSInteger i = 0; i<subSortbtnNum; i++) {
        
            MyClosetData *item = (MyClosetData*)[subSortArray objectAtIndex:i*lineNum isArray:nil];
            
            MyButton *sortbtn = [MyButton buttonWithType:UIButtonTypeCustom];
            [sortbtn setFrame:CGRectMake(SP , ySP + i*(pH + ySP), pW, pH)];
            [sortbtn addTarget:self action:@selector(typeAction:) forControlEvents:UIControlEventTouchUpInside];
            [sortbtn setTitleColor:[UIColor colorWithHexString:@"#888888"] forState:UIControlStateNormal];
            [sortbtn setTitleColor:[UIColor colorWithHexString:@"#c8002c"] forState:UIControlStateSelected];
            sortbtn.tag = i+1;
            
            [sortbtn setBackgroundImage:[UIImage imageNamed:@"sryc_laber_class_big_normal.png"] forState:UIControlStateNormal];
            [sortbtn setBackgroundImage:[UIImage imageNamed:@"sryc_laber_class_big_select.png"] forState:UIControlStateSelected];
            
            [sortbtn setBackgroundColor:[UIColor clearColor]];
            [sortbtn setTitle:item.wardrobe_name forState:UIControlStateNormal];
            sortbtn.btntype = item.value;
            sortbtn.addstring = item.wardrobe_name;
            [bgv addSubview:sortbtn];
        
            [arr_btnStyle addObject:sortbtn];
    }
    
    NSInteger H = 2*ySP + (pH +ySP)* subSortbtnNum;
    
    
    UIButton *nextbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextbtn setFrame:CGRectMake(30,H,ScreenWidth-60,40)];
    [nextbtn addTarget:self action:@selector(nextBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [nextbtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    [nextbtn setBackgroundImage:[UIImage imageNamed:@"big_btn_r_normal.png"] forState:UIControlStateNormal];
    [nextbtn setBackgroundImage:[UIImage imageNamed:@"big_btn_r_hover.png"] forState:UIControlStateHighlighted];
    
    [nextbtn setBackgroundColor:[UIColor clearColor]];
    [nextbtn setTitle:@"下一步" forState:UIControlStateNormal];
    [bgv addSubview:nextbtn];
    
    H += 60;
    
    [bgv setFrame:CGRectMake(0, bgvH, ScreenWidth, H)];
    
    [myScrollV setContentSize:CGSizeMake(0, H+100)];
    
    return bgv;
}




-(IBAction)typeAction:(id)sender{
    
    for (MyButton *btns in arr_btnStyle) {
        btns.selected = NO;
    }
    
    MyButton *btn = (MyButton*)sender;
    btn.selected = YES;
    str_selectStyle = btn.btntype;
}


- (IBAction)nextBtnAction:(id)sender{
    
    if ([str_selectStyle isEqualToString:@""]) {
        [SBPublicAlert showMBProgressHUD:@"请先选择您的穿衣之道" andWhereView:self.view hiddenTime:AlertShowTime];
        return;
    }
    
    [self.arr_selectStyle addObject:str_selectStyle];
    
    NSLog(@"arr_selectStyle---%@",self.arr_selectStyle);
    
    MyCloset4ViewController *clv2 = [[MyCloset4ViewController alloc] initWithNibName:@"MyCloset4ViewController" bundle:nil];
    [clv2.arr_selectStyle addObjectsFromArray:self.arr_selectStyle];
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
