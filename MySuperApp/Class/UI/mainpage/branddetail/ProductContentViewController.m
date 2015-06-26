//
//  ProductContentViewController.m
//  MySuperApp
//
//  Created by LEE on 14-7-23.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "ProductContentViewController.h"
//#import "MillViewController.h"
#import "ProductDetailViewController.h"

@interface ProductContentViewController ()
{
    MainpageServ *request;
}
@end

@implementation ProductContentViewController
@synthesize params,current,arrayImg;
@synthesize tableList;
@synthesize imgBackground;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = self.strtitle;
    
    [self createBackBtnWithType:0];

    
    
    //lee999 200版本 新增筛选界面
    //if (!self.isHiddenFilerbtn) {
        [self createRightBtn];
        [self.navbtnRight setTitle:@"筛选" forState:UIControlStateNormal];
        [self.navbtnRight setTitle:@"筛选" forState:UIControlStateSelected];
    //}
    
    if (self.arrayImg.count > self.current) {

//        [self.imgBackground setImageWithURL:[NSURL URLWithString:[self.arrayImg objectAtIndex:self.current]]  placeholderImage:[UIImage imageNamed:@""]];//pic_default_home_modle.png

    }
    
    contentArr = [NSMutableArray array];
    
    request = [[MainpageServ alloc] init];
    request.delegate = self;
    [[NSUserDefaults standardUserDefaults]setObject:@"productlist" forKey:@"From"];
    
     [self getData];    
}


#pragma mark-- 筛选按钮
-(void)rightButAction{
    NewFilter20ViewController *newfvc = [[NewFilter20ViewController alloc] init];
    newfvc.delegate = self;
    //所有的筛选信息
    newfvc.arrfilter = [NSMutableArray arrayWithArray:brandList.productlistFilter];
    //已选中的筛选信息
    newfvc.arrSelectfilter = [NSMutableArray arrayWithArray:brandList.productlist_select_filter];
    newfvc.params = self.params;
    newfvc.orderStr = @"";
    newfvc.key = @"";
    newfvc.strcurrentpage = [NSString stringWithFormat:@"%ld",(long)current];
    newfvc.strperpage = @"10";
    [self.navigationController pushViewController:newfvc animated:YES];
}


-(void)sureFilter:(NSString *)prama{
    NSLog(@"---%@",prama);
    
    current = 1;
    self.params = prama;
    
    [self getData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -- UITableViewDelegate and DateSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ceilf(contentArr.count/2.0);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"CellIdentifier";
    ProductCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ProductCell" owner:self options:nil] objectAtIndex:0];
    }
    
    cell.delegate = self;
    [cell setBackgroundImage:indexPath.row withArray:contentArr];
    
    [cell setBackgroundColor:[UIColor colorWithHexString:@"E6E6E6"]];
    return cell;
    
}

#pragma mark -- 跳转到商品详情
- (void)getProductId:(NSInteger)tag
{
    ProductDetailViewController* detail = [[ProductDetailViewController alloc] init];
    detail.thisProductId = [NSString stringWithFormat:@"%@",((BrandsProductlistPictext *)[contentArr objectAtIndex:tag]).productlistPictextIdentifier ];
    detail.isHiddenBar = YES;
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark -- 按钮事件
- (IBAction)quit:(id)sender//返回
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- NetRequest delegate
#pragma mark--sever
-(void)serviceFinished:(ServiceType)aHandle withmodel:(id)amodel
{
    LBaseModel *model = (LBaseModel*)amodel;
    switch (model.requestTag) {
        case Http_Productlist_Tag:
        {
            brandList = (BrandsProductListModel *)model;
            
            if (!model.errorMessage) {
                [SBPublicAlert hideMBprogressHUD:self.view];
                
                if (current == 1) {
                    [contentArr removeAllObjects];
                    [contentArr addObjectsFromArray:(NSMutableArray *)brandList.productlistPictext];
                }else {
                    [contentArr addObjectsFromArray:(NSMutableArray *)brandList.productlistPictext];
                }
                totalCount = brandList.recordCount;
                [self updateTableViewCount:contentArr.count];
            }else {
                [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:0.6];
                [self updateTableViewCount:contentArr.count];
                
            }
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

-(void)serviceFailed:(ServiceType)aHandle{
    [SBPublicAlert hideMBprogressHUD:self.view];

}

-(void)serviceStarted:(ServiceType)aHandle
{

}



#pragma mark 刷新的代理方法
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSInteger returnKey = [self.tableList tableViewDidEndDragging];
    if (returnKey != k_RETURN_DO_NOTHING) {
        NSString * key = [NSString stringWithFormat:@"%d", returnKey];
        [self updateThread:key];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger returnKey = [self.tableList tableViewDidDragging];
    if (returnKey == k_RETURN_LOADMORE) {
        NSString * key = [NSString stringWithFormat:@"%d", returnKey];
        [self updateThread:key];
    }
}

#pragma mark 刷新
-(void)getData
{
    current = 1;
    NSString *PageCurr = [NSString stringWithFormat:@"%d",current];
    [request getProductlist:[NSString stringWithFormat:@"%@",self.params] andOrder:nil andKeyword:nil andPage:PageCurr andPer_page:@"10"];
    
    [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
    
}

#pragma mark 加载
- (void)nextPage
{
    current ++;
    NSString *PageCurr = [NSString stringWithFormat:@"%d",current];
    
    [request getProductlist:[NSString stringWithFormat:@"%@",self.params] andOrder:nil andKeyword:nil andPage:PageCurr andPer_page:@"10"];
    [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];

    
}

- (void)updateTableViewCount:(NSInteger)theCount
{
    BOOL status = NO;
    if (theCount < totalCount) {//小于
        status = YES;
    }
    self.tableList.isCloseFooter = !status;
    
    if (status) {//还有数据
        // 一定要调用本方法，否则下拉/上拖视图的状态不会还原，会一直转菊花
        [self.tableList reloadData:NO];
    } else {//没有数据
        //  一定要调用本方法，否则下拉/上拖视图的状态不会还原，会一直转菊花
        [self.tableList reloadData:YES];
    }
}
- (void)updateThread:(NSString *)returnKey{
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

@end
