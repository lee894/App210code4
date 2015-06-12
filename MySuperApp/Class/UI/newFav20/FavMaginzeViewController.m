//
//  FavMaginzeViewController.m
//  MyAimerApp
//
//  Created by yanglee on 15/4/24.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "FavMaginzeViewController.h"
#import "NewFavInfo.h"
#import "NewFavParser.h"
#import "PPBuyCircleCommonCell.h"
#import "NewMaginzeListInfo.h"
#import "NewMaginzeAViewController.h"
#import "NewMaginzeBViewController.h"
#import "NewMaginzeBViewControllerV2.h"


@interface FavMaginzeViewController ()
{
    UITableView *myTableV;
    int current;
    NewFavInfo *_maginzeinfo;
    
    UILabel *noInfoLab;
    
    NSString *delMaginzeID;

    
    BOOL     isEditing;
}
@end

@implementation FavMaginzeViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    
    [self createBackBtnWithType:0];
    self.title = @"专辑收藏";
    [self creatTableView];
    
    contentdataArr = [[NSMutableArray alloc] initWithCapacity:0];
    
    
    isEditing = NO;

    //创建右边按钮
    [self createRightBtn];
    
    [self.navbtnRight setBackgroundImage:[UIImage imageNamed:@"nav_icon_edit.png"] forState:UIControlStateNormal];
    [self.navbtnRight setTitle:@"" forState:UIControlStateNormal];
    [self.navbtnRight setTitle:@"" forState:UIControlStateHighlighted];
    [self.navbtnRight setBackgroundImage:[UIImage imageNamed:@"nav_icon_edit_press.png"] forState:UIControlStateHighlighted];
    [self.navbtnRight setFrame:CGRectMake(225, 10, 25, 25)];
    [self.navbtnRight addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];
    
    
    mainSer = [[MainpageServ alloc] init];
    mainSer.delegate = self;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [self getreflashData];
}

#pragma mark -- 按钮事件
- (IBAction)edit:(id)sender//编辑
{
    if (contentdataArr.count == 0) {
        return;
    }
    
    isEditing = YES;
    
    [self.navbtnRight setTitle:@"完成" forState:UIControlStateNormal];
    [self.navbtnRight setTitle:@"完成" forState:UIControlStateHighlighted];
    [self.navbtnRight setBackgroundImage:[UIImage imageNamed:@"nav_btn.png"] forState:UIControlStateNormal];
    [self.navbtnRight setBackgroundImage:[UIImage imageNamed:@"nav_btn_press.png"] forState:UIControlStateHighlighted];
    [self.navbtnRight setFrame:CGRectMake(242, 7, 66, 32)];
    [self.navbtnRight addTarget:self action:@selector(empty:) forControlEvents:UIControlEventTouchUpInside];
    
    [myTableV reloadData];
    
    
}

- (IBAction)empty:(UIButton *)sender//完成Action
{
    isEditing = NO;
    
    [self.navbtnRight setBackgroundImage:[UIImage imageNamed:@"nav_icon_edit.png"] forState:UIControlStateNormal];
    [self.navbtnRight setTitle:@"" forState:UIControlStateNormal];
    [self.navbtnRight setTitle:@"" forState:UIControlStateHighlighted];
    [self.navbtnRight setBackgroundImage:[UIImage imageNamed:@"nav_icon_edit_press.png"] forState:UIControlStateHighlighted];
    [self.navbtnRight setFrame:CGRectMake(225, 10, 25, 25)];
    [self.navbtnRight addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];
    
    [myTableV reloadData];

}

//创建表格
-(void)creatTableView{
    
    myTableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight -55) style:UITableViewStylePlain];
    myTableV.delegate = self;
    myTableV.dataSource = self;
    myTableV.tag = 1001;
    [self.view addSubview:myTableV];
    [myTableV setBackgroundColor:[UIColor colorWithHexString:tableViewBGC]];
    
    
    
    noInfoLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, ScreenWidth, 30)];
    [noInfoLab setText:@"暂无数据"];
    [noInfoLab setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:noInfoLab];
    
    myTableV.hidden = YES;
    
    [myTableV addHeaderWithTarget:self action:@selector(getreflashData)];
    [myTableV addFooterWithTarget:self action:@selector(getnextPage)];
    
}


#pragma mark 刷新
-(void)getreflashData
{
    current = 1;
    [contentdataArr removeAllObjects];

    NSString *PageCurr = [NSString stringWithFormat:@"%d",current];
    [mainSer getFavListnew20:PageCurr andPer_page:@"1000" andtype:@"magazine"];
    
    [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
    
}

#pragma mark 加载
- (void)getnextPage
{
    current ++;
    NSString *PageCurr = [NSString stringWithFormat:@"%d",current];
    
    [mainSer getFavListnew20:PageCurr andPer_page:@"10" andtype:@"magazine"];
    [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
}


#pragma mark -- net request delegate
-(void)serviceStarted:(ServiceType)aHandle{
}

-(void)serviceFailed:(ServiceType)aHandle{
    [SBPublicAlert hideMBprogressHUD:self.view];
    
    [myTableV headerEndRefreshing];
    [myTableV footerEndRefreshing];
    
    current --;
}

-(void)serviceFinished:(ServiceType)aHandle withmodel:(id)amodel{
    
    [SBPublicAlert hideMBprogressHUD:self.view];

    
    [myTableV headerEndRefreshing];
    [myTableV footerEndRefreshing];
    
    
    LBaseModel *model = (LBaseModel *)amodel;
    if ([amodel isKindOfClass:[LBaseModel class]] &&
        model.requestTag < 200) {
        switch (model.requestTag) {
            case Http_FavoriteDel_Tag:
            {
                if (!model.errorMessage) {
                    
                    [SBPublicAlert hideMBprogressHUD:self.view];
                    
                    for (int i = 0; i< contentdataArr.count; i++) {
                        NewMaginzeData *item = [contentdataArr objectAtIndex:i isArray:nil];
                        if (item.magazine_id == delMaginzeID) {
                            [contentdataArr removeObjectAtIndex:i];
                            break;
                        }
                    }
                    
                    if (contentdataArr.count == 0) {
                        noInfoLab.hidden = NO;
                        myTableV.hidden = YES;
                    }
                    [myTableV reloadData];
                    
                    
                }else{
                    [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:0.6];
                }
            }
                break;
                
            default:
                break;
        }
        return;
    }
    
    _maginzeinfo = [[NewFavParser alloc] parseNewFavMaginzeInfo:amodel];
    [contentdataArr addObjectsFromArray:_maginzeinfo.favorite_magazine];

    if ([contentdataArr count] > 0) {
        myTableV.hidden = NO;
        noInfoLab.hidden = YES;
    }else{
        myTableV.hidden = YES;
        noInfoLab.hidden = NO;
        
    }
    
    [myTableV reloadData];
}


#pragma mark-- tableView

// Section的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([tableView tag] == 1001) {
        return [contentdataArr count];
    }
    return 1;
}

// row的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView tag] == 1001) {
        return 1;
    }
    return ceil(contentdataArr.count/2.0);
    
}

// Section的 head高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if ([tableView tag] == 1001) {
        return 0;
    }
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if ([tableView tag] == 1001) {
        return 0.1;
    }
    return 0.1;
}

// row的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView tag] == 1001) {
        return 315 + 25; //+15 为中间间距
    }
    return 270;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        //专辑
        NewMaginzeData *item = [contentdataArr objectAtIndex:[indexPath section] isArray:nil];
        PPBuyCircleCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PPBuyCircleCommonCell"];
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"PPBuyCircleCommonCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            [tableView registerNib:[UINib nibWithNibName:@"PPBuyCircleCommonCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"PPBuyCircleCommonCell"];
        }
        cell.item = item;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setBackgroundColor:[UIColor clearColor]];
    
    cell.delMaginzeBtn.tag = [indexPath section];
    if (isEditing) {
        cell.delMaginzeBtn.hidden = NO;
        [cell.delMaginzeBtn addTarget:self action:@selector(delStoreAction:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        cell.delMaginzeBtn.hidden = YES;
    }
    

        return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (isEditing) {
        return;
    }
    
    NewMaginzeData *item = [contentdataArr objectAtIndex:[indexPath section] isArray:nil];
    
    
    if ([item.magazine_type isEqualToString:@"A"]) {
        
        NewMaginzeAViewController *newMVC = [[NewMaginzeAViewController alloc] init];
        newMVC.strMaginzeId = item.magazine_id;
        newMVC.isFromHomePageAndShowSepBtn = NO;
        [self.navigationController pushViewController:newMVC animated:YES];
        
    }else{

        
        NewMaginzeBViewControllerV2 *newMVC = [[NewMaginzeBViewControllerV2 alloc] init];
        newMVC.strMaginzeId = item.magazine_id;
        newMVC.isFromHomePageAndShowSepBtn = NO;
        [self.navigationController pushViewController:newMVC animated:YES];
    }
}



-(void)delStoreAction:(id)sender{
    
    UIButton*btn = (UIButton*)sender;
    
    NewMaginzeData *item = [contentdataArr objectAtIndex:[btn tag] isArray:nil];
    
    //type == goods store magazine
    [mainSer getFavoritedel:item.magazine_id andType:@"magazine"];
    delMaginzeID = item.magazine_id;
    [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
    
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
