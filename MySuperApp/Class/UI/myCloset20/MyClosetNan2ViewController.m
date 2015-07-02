//
//  MyClosetNan2ViewController.m
//  MyAimerApp
//
//  Created by yanglee on 15/6/8.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "MyClosetNan2ViewController.h"
#import "MyClosetNan3ViewController.h"
#import "MyButton.h"

@interface MyClosetNan2ViewController ()
{
    __weak IBOutlet UIScrollView *myScrollV;
    
    NSString *str_selectStyle; //已选中的穿衣之道。
    NSMutableArray *arr_btnStyle; //已选中的穿衣之道。

}
@end

@implementation MyClosetNan2ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"私人衣橱"];
    [self createBackBtnWithType:0];
    [self NewHiddenTableBarwithAnimated:YES];
    
    
    NSLog(@"--%@---%@",self.closetinfo.style,self.closetinfo.chuanyizhidao);
    
    
    [myScrollV addSubview:[self createCellView:self.closetinfo.chuanyizhidao]];
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
        [sortbtn addTarget:self action:@selector(typeSelectAction:) forControlEvents:UIControlEventTouchUpInside];
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
    [nextbtn setBackgroundImage:[UIImage imageNamed:@"big_btn_r_select.png"] forState:UIControlStateHighlighted];
    
    [nextbtn setBackgroundColor:[UIColor clearColor]];
    [nextbtn setTitle:@"下一步" forState:UIControlStateNormal];
    [bgv addSubview:nextbtn];
    
    H += 60;
    
    [bgv setFrame:CGRectMake(0, bgvH, ScreenWidth, H)];
    
    [myScrollV setContentSize:CGSizeMake(0, H+100)];
    
    return bgv;
}





- (IBAction)typeSelectAction:(id)sender {
    
    for (MyButton *btns in arr_btnStyle) {
        btns.selected = NO;
    }
    
    MyButton *btn = (MyButton*)sender;
    btn.selected = YES;
    str_selectStyle = btn.btntype;
}



- (IBAction)nextBtnAction:(id)sender {
    
    if ([str_selectStyle isEqualToString:@""]) {
        [SBPublicAlert showMBProgressHUD:@"请先选择您的穿衣之道" andWhereView:self.view hiddenTime:AlertShowTime];
        return;
    }
    [arr_btnStyle addObject:str_selectStyle];
    
    MyClosetNan3ViewController *nan3vc = [[MyClosetNan3ViewController alloc] initWithNibName:@"MyClosetNan3ViewController" bundle:nil];
    [nan3vc.arr_selectStyle addObjectsFromArray:arr_btnStyle];
    [self.navigationController pushViewController:nan3vc animated:YES];
    
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
