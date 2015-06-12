//
//  FavStoreViewController.m
//  MyAimerApp
//
//  Created by yanglee on 15/4/24.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "FavStoreViewController.h"
#import "StoreDetail20ViewController.h"
#import "NewFavInfo.h"
#import "NewFavParser.h"

@interface FavStoreViewController ()
{
    UITableView *myTableV;
    UILabel *noInfoLab;
    int current;

    NewFavInfo *_storeinfo;
    
    UIView *clearView;
    
    NSString *delStoreID;


    BOOL isEditing;  //是否正在编辑，编辑中不能进入商品详情。

}
@end

@implementation FavStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createBackBtnWithType:0];
    self.title = @"门店收藏";
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

- (IBAction)empty:(UIButton *)sender//清空
{
    
    isEditing = NO;
    
    [self.navbtnRight setBackgroundImage:[UIImage imageNamed:@"nav_icon_edit.png"] forState:UIControlStateNormal];
    [self.navbtnRight setTitle:@"" forState:UIControlStateNormal];
    [self.navbtnRight setTitle:@"" forState:UIControlStateHighlighted];
    [self.navbtnRight setBackgroundImage:[UIImage imageNamed:@"nav_icon_edit_press.png"] forState:UIControlStateHighlighted];
    [self.navbtnRight setFrame:CGRectMake(225, 10, 25, 25)];
    [self.navbtnRight addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];

    [myTableV reloadData];

    
//    self.navbtnRight.enabled = NO;
//    
//    clearView= [[[NSBundle mainBundle] loadNibNamed:@"ClearView" owner:self options:nil] lastObject];
//    [self.view addSubview:clearView];
//    
//    isEditing = YES;
}


- (IBAction)clearComfirmOrCancel:(UIButton *)sender//清空弹出视图确认or取消
{
    self.navbtnRight.enabled = YES;
    
    switch (sender.tag) {
        case 80:
        {
            [clearView removeFromSuperview];

            [mainSer getFavoritedel:@"all" andType:@"store"];
            //isClear = YES;
            [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
        }
            break;
        case 81:
            [clearView removeFromSuperview];
            
            break;
        default:
            break;
    }
}


//创建表格
-(void)creatTableView{
    
    myTableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-60) style:UITableViewStylePlain];
    myTableV.delegate = self;
    myTableV.dataSource = self;
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
    [mainSer getFavListnew20:PageCurr andPer_page:@"10" andtype:@"store"];
    
    [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
    
}

#pragma mark 加载
- (void)getnextPage
{
    current ++;
    NSString *PageCurr = [NSString stringWithFormat:@"%d",current];
    
    [mainSer getFavListnew20:PageCurr andPer_page:@"10" andtype:@"store"];
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
                        NewFavStoreData *store = (NewFavStoreData *)[contentdataArr objectAtIndex:i isArray:nil];
                        if (store.storeid == delStoreID) {
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
    
    
    
    _storeinfo = [[NewFavParser alloc] parseNewFavStoreInfo:amodel];
    if (_storeinfo.favorite_stores == 0) {
        current --;
        [SBPublicAlert showMBProgressHUD:@"最后一页了" andWhereView:self.view hiddenTime:0.6];
    }
    [contentdataArr addObjectsFromArray:_storeinfo.favorite_stores];
    
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
    return contentdataArr.count;
}

// row的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

// Section的 head高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 66;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *bgv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 66)];
    [bgv setBackgroundColor:[UIColor colorWithHexString:@"ffffff"]];
    
    
    NewFavStoreData *store = (NewFavStoreData *)[contentdataArr objectAtIndex:section isArray:nil];
    
    
    UILabel *namelab = [[UILabel alloc] initWithFrame:CGRectMake(15, 8, 230, 30)];
    [namelab setNumberOfLines:1];
    [namelab setTextAlignment:NSTextAlignmentLeft];
    namelab.font = [UIFont systemFontOfSize:LabBigSize];
    [namelab setTextColor:[UIColor colorWithHexString:@"#444444"]];
    [namelab setText:store.store_name];
    [bgv addSubview:namelab];
    
    UILabel *desclab = [[UILabel alloc] initWithFrame:CGRectMake(15, 38, 290, 20)];
    [desclab setNumberOfLines:1];
    [desclab setTextAlignment:NSTextAlignmentLeft];
    desclab.font = [UIFont systemFontOfSize:LablitileSmallSize];
    [desclab setTextColor:[UIColor colorWithHexString:@"#999999"]];
    [desclab setText:store.store_address];
    [bgv addSubview:desclab];
    
    
    UIView *bglv = [[UIView alloc] initWithFrame:CGRectMake(0, 65.5, ScreenWidth, 0.5)];
    [bglv setBackgroundColor:[UIColor colorWithHexString:@"999999"]];
    [bgv addSubview:bglv];
    
    
    UIImage*img = [UIImage imageNamed:@"dl_zc_arrow.png"];
    UIImageView*imageV = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth-15-img.size.width, 38, img.size.width, img.size.height)];
    [imageV setImage:img];
    [bgv addSubview:imageV];
    
    //距离
    UILabel *distancelab = [[UILabel alloc] initWithFrame:CGRectMake(240, 8, 60, 30)];
    [distancelab setNumberOfLines:1];
    [distancelab setTextAlignment:NSTextAlignmentRight];
    distancelab.font = [UIFont systemFontOfSize:LabMidSize];
    [distancelab setTextColor:[UIColor colorWithHexString:@"#888888"]];
//    [distancelab setText:[NSString stringWithFormat:@"%.2fkm",[store.distance floatValue]]];
//    [bgv addSubview:distancelab];
    
    
    UIButton *sortbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sortbtn setFrame:bgv.frame];
    [sortbtn addTarget:self action:@selector(gotoStoreAction:) forControlEvents:UIControlEventTouchUpInside];
    sortbtn.tag = section;
    [bgv addSubview:sortbtn];
    
    
    //删除按钮--------------
    UIButton *delbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [delbtn setFrame:CGRectMake(290, 2, 28, 28)];
    if (isEditing) {
        delbtn.hidden = NO;
    }else{
        delbtn.hidden = YES;
    }
    [delbtn setBackgroundImage:[UIImage imageNamed:@"edit_icon_delete.png"] forState:UIControlStateNormal];
    [delbtn addTarget:self action:@selector(delStoreAction:) forControlEvents:UIControlEventTouchUpInside];
    delbtn.tag = section;
    [bgv addSubview:delbtn];
    
    
    
    return bgv;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

// row的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * showUserInfoCellIdentifier = @"ShowUserInfoCell";
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil)
    {
        // Create a cell to display an ingredient.
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:showUserInfoCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }

    // Configure the cell.
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:
(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSUInteger row = [indexPath row];
        [contentdataArr removeObjectAtIndex:row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

#pragma mark--- Action


-(void)gotoStoreAction:(id)sender{
    
    UIButton*btn = (UIButton*)sender;
    [self gotoStoreVC:btn.tag];
}


-(void)delStoreAction:(id)sender{
    
    UIButton*btn = (UIButton*)sender;
    NewFavStoreData *store = (NewFavStoreData *)[contentdataArr objectAtIndex:btn.tag isArray:nil];
    
    //type == goods store magazine

    [mainSer getFavoritedel:store.storeid andType:@"store"];
    delStoreID = store.storeid;
    [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];

}


-(void)gotoStoreVC:(int)index{
    
    
    if (isEditing) {
        return;
    }
    
    NewFavStoreData *store = (NewFavStoreData *)[contentdataArr objectAtIndex:index isArray:nil];
    
    NSDictionary *dic1  = [NSDictionary dictionaryWithObjectsAndKeys:store.store_name, @"storename",nil];
    [TalkingData trackEvent:@"5007" label:@"查找门店" parameters:dic1];
    
    StoresStores *storeold = [[StoresStores alloc] init];
    storeold.storeid = store.storeid;
    storeold.storeName = store.store_name;
    storeold.storeAddress = store.store_address;
    storeold.storeTel = store.store_tel;
    storeold.storeGpslat = store.store_gpslat;
    storeold.storeGpslng = store.store_gpslng;
    storeold.filePath = store.file_path;
    storeold.brand = store.brand;
    storeold.promotion_message = store.promotion_message;
    storeold.created = store.created;
    storeold.update_time = store.update_time;
    storeold.business_hours = store.business_hours;
    storeold.distance = store.distance;
    storeold.is_favorite = store.is_favorite;

    
    StoreDetail20ViewController *stvc = [[StoreDetail20ViewController alloc] init];
    stvc.store = storeold;
    [self.navigationController pushViewController:stvc animated:YES];
    
    /*
     StoreViewController *tempStore = [[StoreViewController alloc] initWithNibName:@"StoreViewController" bundle:nil];
     tempStore.num = index;
     tempStore.myPositionJinduString = lng;
     tempStore.myPositionWeiduString = lan;
     [self.navigationController pushViewController:tempStore animated:YES];
     */
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
