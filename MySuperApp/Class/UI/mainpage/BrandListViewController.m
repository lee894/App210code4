//
//  BrandListViewController.m
//  MySuperApp
//
//  Created by Sophie  on 14-3-23.
//  Copyright (c) 2014年 aimer. All rights reserved.
//

#import "BrandListViewController.h"
#import "MainpageViewController.h"
#import "NewBrandDetail20ViewController.h"
#import "YKCanReuse_webViewController.h"

#import "UrlImageView.h"
#import "UrlImageButton.h"
#import "UIDevice-Hardware.h"

#import "ZBFlowView.h"
#import "ZBWaterView.h"

@interface BrandListViewController ()<ZBWaterViewDatasource,ZBWaterViewDelegate>
{
    //UITableView *brandtableView;// 品牌馆
    
    NSArray *arraylogoPhoto;//品牌馆logo
    MainpageServ *brandsev;
    
    ZBWaterView *_waterView;
}

@end

@implementation BrandListViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // [self createBrandView];

    [self createBackBtnWithType:0];
    [self setTitle:@"品牌馆"];
    [self NewHiddenTableBarwithAnimated:YES];

    brandsev = [[MainpageServ alloc] init];
    brandsev.delegate = self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    if (self.brandModel.brandsWall.count < 1) {
        [brandsev getBrandlist];
        [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
    }
}


#pragma mark--sever
-(void)serviceFinished:(ServiceType)aHandle withmodel:(id)amodel
{
    [SBPublicAlert hideMBprogressHUD:self.view];
    
    self.brandModel = (BrandsModel *)amodel;
    
    _waterView = [[ZBWaterView alloc]  initWithFrame:CGRectMake(0, 5, ScreenWidth,ScreenHeight-70)];
    _waterView.waterDataSource = self;
    _waterView.waterDelegate = self;
    _waterView.isDataEnd = YES;
    [_waterView endLoadMore];
    [_waterView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_waterView];
    [_waterView reloadData];

    
  //  [brandtableView reloadData];
}

-(void)serviceFailed:(ServiceType)aHandle{
    
    [SBPublicAlert hideMBprogressHUD:self.view];
}

-(void)serviceStarted:(ServiceType)aHandle
{
}



#pragma mark - ZBWaterViewDatasource
- (NSInteger)numberOfFlowViewInWaterView:(ZBWaterView *)waterView
{
    return self.brandModel.brandsWall.count + 1;
}

- (CustomWaterInfo *)infoOfWaterView:(ZBWaterView*)waterView
{
    CustomWaterInfo *info = [[CustomWaterInfo alloc] init];
    info.topMargin = 0;
    info.leftMargin = 5;
    info.bottomMargin = 0;
    info.rightMargin = 5;
    info.horizonPadding = 5;
    info.veticalPadding = 5;
    info.numOfColumn = 2;
    return info;
}

- (ZBFlowView *)waterView:(ZBWaterView *)waterView flowViewAtIndex:(NSInteger)index
{
    ZBFlowView *flowView = [waterView dequeueReusableCellWithIdentifier:@"cell"];
    flowView = [[ZBFlowView alloc] initWithFrame:CGRectZero];
    flowView.reuseIdentifier = @"cell";
    flowView.index = index;
    
    if (index == 1) {

        UIImageView *imgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, lee1fitAllScreen(152), lee1fitAllScreen(63))];
        [imgv setImage:[UIImage imageNamed:@"aboutAimer.png"]];
        [flowView addSubview:imgv];
    
    }else{
        
        NSInteger i = 0;
        if (index == 0) {
            i = index;
        }else if (index > 1)
        {
            i = index -1;
        }
        
        BrandsWall *pic2 = (BrandsWall *)[self.brandModel.brandsWall objectAtIndex:i isArray:nil];
        UrlImageView *imageView=[[UrlImageView alloc]init];
        imageView.frame=CGRectMake(0, 0, lee1fitAllScreen(152), lee1fitAllScreen(225));
        [imageView setImageFromUrl:YES withUrl:pic2.pic];
        [flowView addSubview:imageView];
    }
    
    return flowView;
}

- (CGFloat)waterView:(ZBWaterView *)waterView heightOfFlowViewAtIndex:(NSInteger)index
{
    if (index==1) {
        return lee1fitAllScreen(60);
    }
    return lee1fitAllScreen(225);
}


#pragma mark - ZBWaterViewDelegate
- (void)needLoadMoreByWaterView:(ZBWaterView *)waterView;
{
}

- (void)phoneWaterViewDidScroll:(ZBWaterView *)waterView
{
    //do what you want to do
    return;
}

- (void)waterView:(ZBWaterView *)waterView didSelectAtIndex:(NSInteger)index
{
    NSLog(@"didSelectAtIndex%ld",(long)index);
    
    if (index == 1) {
        
        //爱慕简介
        YKCanReuse_webViewController *webView = [[YKCanReuse_webViewController alloc] init];
        webView.strURL = @"http://m.aimer.com.cn/method/about";
        webView.strTitle = @"爱慕简介";
        [self.navigationController pushViewController:webView animated:YES];
        
    }else{
        
        NSInteger i = 0;
        if (index == 0) {
            i = index;
        }else if (index > 1)
        {
            i = index -1;
        }
        
        BrandsWall *wallModel = (BrandsWall *)[self.brandModel.brandsWall objectAtIndex:i isArray:nil];
        NewBrandDetail20ViewController *brandvc = [[NewBrandDetail20ViewController alloc] initWithNibName:@"NewBrandDetail20ViewController" bundle:nil];
        brandvc.brandname = wallModel.name;
        [self.navigationController pushViewController:brandvc animated:YES];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
