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


#import "UrlImageView.h"
#import "UrlImageButton.h"
#import "UIDevice-Hardware.h"



@interface BrandListViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *brandtableView;// 品牌馆
    
    NSArray *arraylogoPhoto;//品牌馆logo
    
    MainpageServ *brandsev;
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
    
    [self createBackBtnWithType:0];
    [self setTitle:@"品牌馆"];
    [self NewHiddenTableBarwithAnimated:YES];

    
    [self createBrandView];

    
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

//品牌馆视图
-(void)createBrandView{
    
    brandtableView = [[UITableView alloc] init];
    //判断是不是iphone5
    if ([UIDevice isRunningOniPhone5]) {
        [brandtableView setFrame:CGRectMake(2, 10,ScreenWidth- 5, ScreenHeight-60)];
    }else{
        [brandtableView setFrame:CGRectMake(2, 10,ScreenWidth- 5, ScreenHeight-60)];
    }
    
    brandtableView.backgroundView = nil;
    brandtableView.backgroundColor = [UIColor clearColor];
    brandtableView.dataSource = self;
    brandtableView.delegate = self;
    [self.view addSubview:brandtableView];
    
}


- (IBAction)changebrandView:(UIButton *)sender{
    
    BrandsWall *wallModel = [self.brandModel.brandsWall objectAtIndex:sender.tag-10];
    NSDictionary *dic1  = [NSDictionary dictionaryWithObjectsAndKeys:wallModel.brandsWallIdentifier, @"BrandID",wallModel.name, @"Brandname",nil];
    
    //lee999埋点
    [TalkingData trackEvent:@"5003" label:@"点击品牌馆" parameters:dic1];
    [TalkingData trackEvent:@"5004" label:@"点击品牌详情" parameters:dic1];
    
    
    NewBrandDetail20ViewController *brandvc = [[NewBrandDetail20ViewController alloc] initWithNibName:@"NewBrandDetail20ViewController" bundle:nil];
    brandvc.brandname = wallModel.name;
    [self.navigationController pushViewController:brandvc animated:YES];
}



#pragma mark-
#pragma mark--- TableView
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 120;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ceilf(self.brandModel.brandsWall.count/BrandCellNum);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cellIdentifier";
    BrandCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BrandCell" owner:self options:nil] lastObject];
        cell.backgroundColor = [UIColor clearColor];
    }
    [cell setBackgroundImage:indexPath.row withArray:self.brandModel];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


#pragma mark--sever
-(void)serviceFinished:(ServiceType)aHandle withmodel:(id)amodel
{
    [SBPublicAlert hideMBprogressHUD:self.view];
    
    self.brandModel = (BrandsModel *)amodel;
    
    [brandtableView reloadData];
}

-(void)serviceFailed:(ServiceType)aHandle{
    
    [SBPublicAlert hideMBprogressHUD:self.view];
}

-(void)serviceStarted:(ServiceType)aHandle
{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
