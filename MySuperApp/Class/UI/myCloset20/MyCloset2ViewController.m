//
//  MyCloset2ViewController.m
//  MyAimerApp
//
//  Created by yanglee on 15/5/27.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "MyCloset2ViewController.h"
#import "MyCloset3ViewController.h"
#import "MyButton.h"

@interface MyCloset2ViewController ()
{
    __weak IBOutlet UILabel *title2Lab;
    __weak IBOutlet UIScrollView *myScrollV;
    
    NSMutableArray *arr_selectStyle; //已选中的风格。

}
@end

@implementation MyCloset2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"私人衣橱2"];
    [self createBackBtnWithType:0];
    
    arr_selectStyle = [[NSMutableArray alloc] initWithCapacity:0];
    
    [myScrollV addSubview:[self createCellView:self.closetinfo.style]];
    
}



-(UIView *)createCellView:(NSArray*)subSortArray{
    
    NSInteger bgvH = 80;
    NSInteger lineNum = 2; //每行的数量
    NSInteger ySP = 22;  //距离顶部的位置
    NSInteger SP = 40;  //间距
    NSInteger pW = (ScreenWidth-120)/2;  //商品宽度
    NSInteger pH = 40;  //商品高度
    
    //行数
    NSInteger subSortbtnNum = ([subSortArray count]%lineNum == 0? [subSortArray count]/lineNum :[subSortArray count]/lineNum+1);
    
    UIView *bgv = [[UIView alloc] initWithFrame:CGRectMake(0, bgvH, ScreenWidth, subSortbtnNum*100)];
    [bgv setBackgroundColor:[UIColor clearColor]];
    
    
    for (NSInteger i = 0; i<subSortbtnNum; i++) {
        NSInteger jcount = ([subSortArray count]-lineNum*i)>lineNum?lineNum:([subSortArray count]-lineNum*i);
        
        for (NSInteger j = 0; j<jcount; j++) {
            
            MyClosetData *item = (MyClosetData*)[subSortArray objectAtIndex:j + i*lineNum isArray:nil];
         
            MyButton *sortbtn = [MyButton buttonWithType:UIButtonTypeCustom];
            [sortbtn setFrame:CGRectMake(SP + j*(pW+SP), ySP + i*(pH + ySP), pW, pH)];
            [sortbtn addTarget:self action:@selector(typeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [sortbtn setTitleColor:[UIColor colorWithHexString:@"#888888"] forState:UIControlStateNormal];
            [sortbtn setTitleColor:[UIColor colorWithHexString:@"#c8002c"] forState:UIControlStateSelected];

            [sortbtn setBackgroundImage:[UIImage imageNamed:@"sryc_laber_class_normal.png"] forState:UIControlStateNormal];
            [sortbtn setBackgroundImage:[UIImage imageNamed:@"sryc_laber_class_select.png"] forState:UIControlStateSelected];

            [sortbtn setBackgroundColor:[UIColor clearColor]];
            [sortbtn setTitle:item.wardrobe_name forState:UIControlStateNormal];
            sortbtn.btntype = item.value;
            sortbtn.addstring = item.wardrobe_name;
            [bgv addSubview:sortbtn];
        }
    }
    
    NSInteger H = 2*ySP + (pH +ySP)* subSortbtnNum;

    
    UIButton *nextbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextbtn setFrame:CGRectMake(30,H,ScreenWidth-60,40)];
    [nextbtn addTarget:self action:@selector(nextBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [nextbtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    [nextbtn setBackgroundImage:[UIImage imageNamed:@"big_btn_r_normal.png"] forState:UIControlStateNormal];
    [nextbtn setBackgroundImage:[UIImage imageNamed:@"big_btn_r_select.png"] forState:UIControlStateHighlighted];
    
    [nextbtn setBackgroundColor:[UIColor clearColor]];
    [nextbtn setTitle:@"下一步" forState:UIControlStateNormal];
    [bgv addSubview:nextbtn];
    
    H += 60;
    
    [bgv setFrame:CGRectMake(0, bgvH, ScreenWidth, H)];
    
    
    [myScrollV setContentSize:CGSizeMake(0, H+100)];
    
    return bgv;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)typeBtnAction:(id)sender{
    
    
    if ([arr_selectStyle count] == 3) {
        [SBPublicAlert showMBProgressHUD:@"您最多可选择3项" andWhereView:self.view hiddenTime:AlertShowTime];
        return;
    }
 
    MyButton*btn = (MyButton*)sender;
    btn.selected = !btn.selected;
    
    if (btn.selected) {
        [arr_selectStyle addObject:btn.btntype];
    }else{
        [arr_selectStyle removeObject:btn.btntype];
    }
    
    NSLog(@"btntype---%@",arr_selectStyle);
}


- (IBAction)nextBtnAction:(id)sender{
    
    
    if ([arr_selectStyle count] == 0) {
        [SBPublicAlert showMBProgressHUD:@"请先选择您的风格" andWhereView:self.view hiddenTime:AlertShowTime];
        return;
    }
    
    MyCloset3ViewController *clv2 = [[MyCloset3ViewController alloc] initWithNibName:@"MyCloset3ViewController" bundle:nil];
    clv2.closetinfo = self.closetinfo;
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
