//
//  MyClosetListViewController.m
//  MyAimerApp
//
//  Created by yanglee on 15/5/28.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "MyClosetListViewController.h"
#import "MyClosetListParser.h"
#import "MyCloset1ViewController.h"
#import "MyButton.h"
#import "ProductDetailViewController.h"

@interface MyClosetListViewController ()<ServiceDelegate,UIScrollViewDelegate>
{

    MainpageServ *mainSev;
    MyClosetListInfo *listInfo;
    
    UIScrollView *myallScrollV;
    UILabel *titlelab;
}
@end

@implementation MyClosetListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setTitle:@"私人衣橱列表"];
    [self createBackBtnWithType:0];
    [self NewHiddenTableBarwithAnimated:YES];

    
    [self createRightBtn];
    [self.navbtnRight setTitle:@"管理" forState:UIControlStateNormal];

    
    myallScrollV = [[UIScrollView alloc] init];
    [myallScrollV setFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    myallScrollV.tag = 100;
    myallScrollV.delegate = self;
    myallScrollV.pagingEnabled = YES;
    myallScrollV.backgroundColor = [UIColor clearColor];
    [self.view addSubview:myallScrollV];
    
    mainSev = [[MainpageServ alloc] init];
    mainSev.delegate = self;
    [mainSev getwardrobeinfo];
    [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
    
}

-(void)rightButAction{

    MyCloset1ViewController *vc1 = [[MyCloset1ViewController alloc] initWithNibName:@"MyCloset1ViewController" bundle:nil];
    [self.navigationController pushViewController:vc1 animated:YES];
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
            case Http_wardrobeinfo20_Tag:
            {
                
                listInfo = [[[MyClosetListParser alloc] init] parseClosetListInfo:amodel];
                
                NSInteger num = listInfo.wardrobe_info.count;
                [myallScrollV setContentSize:CGSizeMake(ScreenWidth * num, ScreenHeight)];
                
                
                for (int i=0; i< num; i++) {
                    
                    MyClosetListData *ldata = [listInfo.wardrobe_info objectAtIndex:i isArray:nil];
                    [myallScrollV addSubview:[self createCellView:ldata.goods_list andIndex:i]];
                }
                
                UIView *bgv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
                [bgv setBackgroundColor:[UIColor whiteColor]];
                [self.view addSubview:bgv];
                
                MyClosetListData *ldata = [listInfo.wardrobe_info objectAtIndex:0 isArray:nil];
                titlelab = [[UILabel alloc] initWithFrame:CGRectMake(50, 0,ScreenWidth-100, 40)];
                [titlelab setNumberOfLines:1];
                [titlelab setTextAlignment:NSTextAlignmentCenter];
                titlelab.text = [NSString stringWithFormat:@"%@",ldata.name];
                titlelab.font = [UIFont systemFontOfSize:LabBigSize];
                [titlelab setTextColor:[UIColor colorWithHexString:@"#444444"]];
                [self.view addSubview:titlelab];
                
                UIImage *arrow = [UIImage imageNamed:@"sryc_arrow_btn_l.png"];
                MyButton *leftbtn = [MyButton buttonWithType:UIButtonTypeCustom];
                [leftbtn setFrame:CGRectMake(60,10,arrow.size.width,arrow.size.height)];
                [leftbtn setImage:arrow forState:UIControlStateNormal];
                [leftbtn addTarget:self action:@selector(arrowAction:) forControlEvents:UIControlEventTouchUpInside];
                [leftbtn setBackgroundColor:[UIColor clearColor]];
                leftbtn.tag = 1;
                [self.view addSubview:leftbtn];
                
                
                UIImage *arrow2 = [UIImage imageNamed:@"sryc_arrow_btn_r.png"];
                MyButton *rightbtn = [MyButton buttonWithType:UIButtonTypeCustom];
                [rightbtn setFrame:CGRectMake(ScreenWidth-60-arrow.size.width,10,arrow2.size.width,arrow2.size.height)];
                [rightbtn setImage:arrow2 forState:UIControlStateNormal];
                [rightbtn addTarget:self action:@selector(arrowAction:) forControlEvents:UIControlEventTouchUpInside];
                [rightbtn setBackgroundColor:[UIColor clearColor]];
                rightbtn.tag = 2;
                [self.view addSubview:rightbtn];
                
                
            }
                break;
                
            default:
                break;
        }
        return;
    }
}


-(void)arrowAction:(id)sender{

    UIButton*btn = (UIButton*)sender;
    
    NSLog(@"----%f",myallScrollV.contentOffset.x);
    
    
    if (btn.tag == 1) {
        //左边
        if (myallScrollV.contentOffset.x == 0) {
            return;
        }else{
            CGPoint oldzie = myallScrollV.contentOffset;
            oldzie.x -= ScreenWidth;
            [myallScrollV setContentOffset:oldzie animated:YES];
            
            NSInteger num = oldzie.x/ScreenWidth;
            NSLog(@"---%ld",(long)num);
            if (myallScrollV.tag == 100) {
                MyClosetListData *ldata = [listInfo.wardrobe_info objectAtIndex:num isArray:nil];
                titlelab.text = [NSString stringWithFormat:@"%@",ldata.name];
            }
        }
        
    }else if (btn.tag == 2){
    //右边
        NSInteger num = myallScrollV.contentOffset.x/ScreenWidth;

        if (num == listInfo.wardrobe_info.count-1) {
            return;
        }else{
            CGPoint oldzie = myallScrollV.contentOffset;
            oldzie.x += ScreenWidth;
            [myallScrollV setContentOffset:oldzie animated:YES];
            
            NSInteger num = oldzie.x/ScreenWidth;
            NSLog(@"---%ld",(long)num);
            if (myallScrollV.tag == 100) {
                MyClosetListData *ldata = [listInfo.wardrobe_info objectAtIndex:num isArray:nil];
                titlelab.text = [NSString stringWithFormat:@"%@",ldata.name];
            }
        }
    }
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger num = scrollView.contentOffset.x/ScreenWidth;
    if (scrollView.tag == 100) {
        MyClosetListData *ldata = [listInfo.wardrobe_info objectAtIndex:num isArray:nil];
        titlelab.text = [NSString stringWithFormat:@"%@",ldata.name];
    }
}


-(UIScrollView *)createCellView:(NSArray*)subSortArray andIndex:(NSInteger)index{
    
    int bgvH = 40;
    
    
    int lineNum = 2; //每行的数量
    
    int ySP = 12;  //距离顶部的位置
    int SP = 20;  //左右间距
    int SH = 22;  //上下间距
    int pW = lee1fitAllScreen(127);  //商品宽度
    int pH = lee1fitAllScreen(180);  //商品高度
    int imgH = lee1fitAllScreen(154); //商品图片的高度
    
    //行数
    NSInteger subSortbtnNum = ([subSortArray count]%lineNum == 0? [subSortArray count]/lineNum :[subSortArray count]/lineNum+1);
    
    UIScrollView *bgv = [[UIScrollView alloc] initWithFrame:CGRectMake(ScreenWidth*index, bgvH, ScreenWidth, ScreenHeight -bgvH - 60)]; //subSortbtnNum*100
        [bgv setBackgroundColor:[UIColor clearColor]];
    
    
    
    for (int i = 0; i<subSortbtnNum; i++) {
        
        NSInteger jcount = ([subSortArray count]-lineNum*i)>lineNum?lineNum:([subSortArray count]-lineNum*i);
        
        for (int j = 0; j<jcount; j++) {
            
            
            MyClosetitemData *item = (MyClosetitemData*)[subSortArray objectAtIndex:j + i*lineNum isArray:nil];
            
            UIView *sortV = [[UIView alloc] initWithFrame:CGRectMake(SP + j*(pW+SP), ySP + i*(pH + SH), pW, pH)];
            sortV.layer.borderWidth = 0.5;
            sortV.layer.borderColor = [[UIColor colorWithHexString:@"e2e2e2"] CGColor];
            sortV.tag = j + i*lineNum;
            [bgv addSubview:sortV];
            
            [sortV setBackgroundColor:[UIColor whiteColor]];
            
            UrlImageView *buynowV = [[UrlImageView alloc] initWithFrame:CGRectMake(0, 0, pW, imgH)];
            [buynowV setImageFromUrl:NO withUrl:[self ImageSize:item.pic Size:ChangeImageURL]];
            [sortV addSubview:buynowV];
            
            UILabel *pricelab = [[UILabel alloc] initWithFrame:CGRectMake(0, imgH, pW, 26)];
            [pricelab setNumberOfLines:1];
            [pricelab setTextAlignment:NSTextAlignmentCenter];
            pricelab.text = [NSString stringWithFormat:@"￥%@",item.price.value];
            pricelab.font = [UIFont systemFontOfSize:LabSmallSize];
            [pricelab setTextColor:[UIColor colorWithHexString:@"#444444"]];
            [sortV addSubview:pricelab];
            
            
            MyButton *sortbtn = [MyButton buttonWithType:UIButtonTypeCustom];
            [sortbtn setFrame:CGRectMake(SP + j*(pW+SP), ySP + i*(pH + SH), pW, pH)];
            [sortbtn addTarget:self action:@selector(gotoProductDetailViewAciton:) forControlEvents:UIControlEventTouchUpInside];
            [sortbtn setBackgroundColor:[UIColor clearColor]];
            sortbtn.addstring = item.aid;
            sortbtn.addtitle = item.name;
            [bgv addSubview:sortbtn];
        }
    }
    
    NSInteger H = SP + (pH +SP)* subSortbtnNum;
    [bgv setContentSize:CGSizeMake(ScreenWidth, H)];
    
//    [bgv setFrame:CGRectMake(0, bgvH, ScreenWidth, H)];
    
    return bgv;
}



-(void)gotoProductDetailViewAciton:(MyButton*)btn{
    
    ProductDetailViewController *jumpVC=[[ProductDetailViewController alloc]init];
    jumpVC.thisProductId=btn.addstring;
    jumpVC.ThisPorductName=btn.addtitle;
    jumpVC.source_id=@"1002";
    [self.navigationController pushViewController:jumpVC animated:YES];
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
