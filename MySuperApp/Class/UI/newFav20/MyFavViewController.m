///
//  MyFavViewController.m
//  MySuperApp
//
//  Created by LEE on 14-7-31.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "MyFavViewController.h"
#import "ProductDetailViewController.h"

@interface MyFavViewController () {
    UILabel *label;
    BOOL isClear;
    
    //是否正在刷新
    BOOL isLoading;
    BOOL isDragging;
    BOOL hasMore;
    
    BOOL isEditing;  //是否正在编辑，编辑中不能进入商品详情。
    
    UIButton *delbtn;  //删除按钮
    UIButton *clearbtn;//清空按钮
    
}

@end

@implementation MyFavViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"商品收藏";
    
  
    contentArr = [NSMutableArray array];
    
    [tableList setBackgroundColor:[UIColor colorWithHexString:@"E6E6E6"]];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, NowViewsHight)];
    label.textAlignment = UITextAlignmentCenter;
    label.text = @"您暂时没收藏";
    [self.view addSubview:label];
    
    isEditing = NO;
  
    [self createBackBtnWithType:0];
    mainSer = [[MainpageServ alloc] init];
    mainSer.delegate = self;

    isEdit = 2;
    
    //创建右边按钮
    [self createRightBtn];
    
    [self.navbtnRight setBackgroundImage:[UIImage imageNamed:@"nav_icon_edit.png"] forState:UIControlStateNormal];
    [self.navbtnRight setTitle:@"" forState:UIControlStateNormal];
    [self.navbtnRight setTitle:@"" forState:UIControlStateHighlighted];
    [self.navbtnRight setBackgroundImage:[UIImage imageNamed:@"nav_icon_edit_press.png"] forState:UIControlStateHighlighted];
    [self.navbtnRight setFrame:CGRectMake(225, 10, 25, 25)];
    [self.navbtnRight addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];
    
    if (isIOS7up) {
        [tableList setFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
    }
    
    [self getData];
}

#pragma mark -- 按钮事件
- (IBAction)edit:(id)sender//编辑
{
    if (contentArr.count == 0) {
        return;
    }
    isEdit = 1;
 
    [self.navbtnRight setTitle:@"完成" forState:UIControlStateNormal];
    [self.navbtnRight setTitle:@"完成" forState:UIControlStateHighlighted];
    [self.navbtnRight setBackgroundImage:[UIImage imageNamed:@"nav_btn.png"] forState:UIControlStateNormal];
    [self.navbtnRight setBackgroundImage:[UIImage imageNamed:@"nav_btn_press.png"] forState:UIControlStateHighlighted];
    [self.navbtnRight setFrame:CGRectMake(242, 7, 66, 32)];
    [self.navbtnRight addTarget:self action:@selector(empty:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [tableList reloadData];
    
    isEditing = YES;
    
}

- (IBAction)empty:(UIButton *)sender//清空
{
    
    [tableList reloadData];
    isEdit = 2;
    isEditing = NO;
    
    [self.navbtnRight setBackgroundImage:[UIImage imageNamed:@"nav_icon_edit.png"] forState:UIControlStateNormal];
    [self.navbtnRight setTitle:@"" forState:UIControlStateNormal];
    [self.navbtnRight setTitle:@"" forState:UIControlStateHighlighted];
    [self.navbtnRight setBackgroundImage:[UIImage imageNamed:@"nav_icon_edit_press.png"] forState:UIControlStateHighlighted];
    [self.navbtnRight setFrame:CGRectMake(225, 10, 25, 25)];
    [self.navbtnRight addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -- net request delegate
-(void)serviceStarted:(ServiceType)aHandle{
}

-(void)serviceFailed:(ServiceType)aHandle{
    [SBPublicAlert hideMBprogressHUD:self.view];
}

-(void)serviceFinished:(ServiceType)aHandle withmodel:(id)amodel{
    
    [SBPublicAlert hideMBprogressHUD:self.view];
    LBaseModel *model = (LBaseModel *)amodel;
    
    switch (model.requestTag) {
        case Http_Favorite_Tag:
            if (!model.errorMessage) {
                
                [SBPublicAlert hideMBprogressHUD:self.view];
                favoriteModel = (FavoriteFavoriteModel *)model;
                
                if (current == 1) {
                    [contentArr removeAllObjects];
                    [contentArr addObjectsFromArray:(NSMutableArray *)favoriteModel.favoritePic];
                }else {
                    
                    [contentArr addObjectsFromArray:(NSMutableArray *)favoriteModel.favoritePic];
                }
                
                
                if (contentArr.count != 0) {
                    [label removeFromSuperview];
                }
                
                isLoading = NO;
                
                totalCount = [favoriteModel.recordCount intValue];
                [self updateTableViewCount:contentArr.count];
                
                if (totalCount == current) {
                    hasMore = NO;
                }else{
                    hasMore = YES;
                }
                
                [tableList reloadData];
            }else{
                [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:0.6];
            }
            
            break;
        case Http_FavoriteDel_Tag:
            if (!model.errorMessage) {
                           
                [SBPublicAlert hideMBprogressHUD:self.view];
                if (isClear) {
                    [contentArr removeAllObjects];
                }else {
                    
                    for (int i = 0; i< contentArr.count; i++) {
                        FavoriteFavoritePic *model = (FavoriteFavoritePic *)[contentArr objectAtIndex:i];
                        if (model.productid == productID) {
                            [contentArr removeObjectAtIndex:i];
                        }
                    }
                }
                [tableList reloadData];

                if (contentArr.count == 0) {
                    UIButton *buttonEdit = (UIButton *)[self.view viewWithTag:100];
                    UIButton *buttonEmpty = (UIButton *)[self.view viewWithTag:101];
                    buttonEdit.hidden = NO;
                    buttonEmpty.hidden = YES;
                    
                    [self.view addSubview:label];
                }
            }else{
                [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:0.6];
            }
            break;
        case 10086:
            [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:0.6];
            break;
        default:
            [SBPublicAlert hideMBprogressHUD:self.view];
            break;
    }
}

#pragma mark -- UITableView Delegate and Datesource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ceilf(contentArr.count/2.0);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cellIdentifier";
    CollectCell *collectCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (collectCell == nil) {
        collectCell = [[[NSBundle mainBundle] loadNibNamed:@"CollectCell" owner:self options:nil] lastObject];
    }
    if (isEdit == 1) {//1 代表编辑显示x按钮
        [collectCell setbuttonCancel:NO];
    }else if (isEdit == 2){//2代表不显示x按钮
    [collectCell setbuttonCancel:YES];
    }
    collectCell.delegate = self;
    [collectCell setImageData:indexPath.row withArray:contentArr];

    return collectCell;
}

#pragma mark -- collectforkdelegate//删除单个收藏操作

- (void)forkWithTag:(NSInteger)tag withProductId:(NSString *)productId
{
    [mainSer getFavoritedel:productId andType:@"goods"];
    productID = productId;
    [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
}

- (void)forkProductList:(NSString *)productId//商品详情
{
    //lee999 编辑状态，不能进入商品详情
    if (isEditing) {
        return;
    }
    
    ProductDetailViewController* detail = [[ProductDetailViewController alloc] init];
    detail.thisProductId = [NSString stringWithFormat:@"%@",productId];
    detail.isFromRight = NO;
    detail.isFromMyAimer = YES;
    detail.isHiddenBar = YES;
    //lee999 修改，让其返回后，能回到收藏的界面
    [self.navigationController pushViewController:detail animated:YES];
}


#pragma mark 刷新的代理方法

//滚动表格隐藏键盘
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    if (isLoading) return;
    isDragging = YES;
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (isLoading || !hasMore) return;
    isDragging = NO;
    
        NSInteger returnKey = [tableList tableViewDidEndDragging];
        if (returnKey != k_RETURN_DO_NOTHING) {
            NSString * key = [NSString stringWithFormat:@"%ld", (long)returnKey];
            [self updateThread:key];
            
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
        
        NSInteger returnKey = [tableList tableViewDidDragging];
        if (returnKey == k_RETURN_LOADMORE) {
            NSString * key = [NSString stringWithFormat:@"%ld", (long)returnKey];
            [self updateThread:key];        
    }
}

#pragma mark 刷新
-(void)getData
{
    current = 1;
    NSString *PageCurr = [NSString stringWithFormat:@"%ld",(long)current];
   [mainSer getFavList:PageCurr andPer_page:@"10" andtype:@"good"];

    [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
    
}

#pragma mark 加载
- (void)nextPage
{
    current ++;
    NSString *PageCurr = [NSString stringWithFormat:@"%ld",(long)current];
    
    [mainSer getFavList:PageCurr andPer_page:@"10" andtype:@"good"];
    [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
}

- (void)updateTableViewCount:(NSInteger)theCount
{
    BOOL status = NO;
    if (theCount < totalCount) {//小于
        status = YES;
    }
    tableList.isCloseFooter = !status;
    
    if (status) {//还有数据
        // 一定要调用本方法，否则下拉/上拖视图的状态不会还原，会一直转菊花
        [tableList reloadData:NO];
    } else {//没有数据
        //  一定要调用本方法，否则下拉/上拖视图的状态不会还原，会一直转菊花
        [tableList reloadData:YES];
    }
}
- (void)updateThread:(NSString *)returnKey{
    
    isLoading = YES;
    
    switch ([returnKey intValue]) {
        case k_RETURN_REFRESH:
            //            [data removeAllObjects];
            [self getData];
            break;
        case k_RETURN_LOADMORE:
            [self nextPage];
            break;
        default:
            break;
    }
}


//#pragma mark -- 屏幕旋转
////iOS 5
//- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
//{
//	return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
//}
////iOS 6
//- (BOOL)shouldAutorotate
//{
//	return NO;
//}
//- (NSUInteger)supportedInterfaceOrientations
//{
//	return UIInterfaceOrientationMaskPortrait;
//}
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
//{
//	return UIInterfaceOrientationPortrait;
//}


//- (IBAction)clearComfirmOrCancel:(UIButton *)sender//清空弹出视图确认or取消
//{
//    self.navbtnRight.enabled = YES;
//    
//    switch (sender.tag) {
//        case 80:
//        {
//            [clearView removeFromSuperview];
//            
//            //            NSMutableString *str = [NSMutableString string];
//            //            for (int i = 0; i<favoriteModel.favoritePic.count; i++) {
//            //
//            //                [str appendString:((FavoriteFavoritePic *)[favoriteModel.favoritePic objectAtIndex:i]).productid];
//            //
//            //                if (i!=[favoriteModel.favoritePic count]-1) {
//            //                    [str appendString:@","];
//            //                }
//            //            }
//            [mainSer getFavoritedel:@"all" andType:@"goods"];
//            isClear = YES;
//            
//            [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
//            
//            [tableList reloadData:YES];
//        }
//            break;
//        case 81:
//            [clearView removeFromSuperview];
//            
//            break;
//        default:
//            break;
//    }
//}


@end
