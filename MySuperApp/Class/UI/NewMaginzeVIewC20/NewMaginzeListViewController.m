//
//  NewMaginzeListViewController.m
//  MyAimerApp
//
//  Created by yanglee on 15/4/11.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "NewMaginzeListViewController.h"
#import "PPBuyCircleCommonCell.h"
#import "NewMaginzeListInfo.h"
#import "NewMaginzeParser.h"
#import "NewMaginzeAViewController.h"
#import "NewMaginzeBViewController.h"
#import "CollectCell.h"
#import "NewMaginzeBViewControllerV2.h"


#define NomalColor [UIColor colorWithHexString:@"#6c6c6c"]
#define SelectedColor [UIColor colorWithHexString:@"#181818"]

#define SortNomalColor [UIColor colorWithHexString:@"#8e8e8e"]
#define SortSelectedColor [UIColor colorWithHexString:@"#C8002C"]

#define SwitchViewHight  35.

@interface NewMaginzeListViewController ()
{
    UITableView *myTableV;
    
    UITableView *productTableV;

    
    NewMaginzeListInfo *_maginzeinfo;
    
    
    //切换按钮
    UIView* switchBtnView;

    
    UIView* switchSelectView;
    UIButton *switchMyBuyPBtn;
    UIButton *switchWeShopPBtn;
    
    
    //分类按钮
    UIView* sortBtnView;
    
    UIButton *newbtn;
    UIButton *hotbtn;
    UIButton *pricebtn;
    
    UIImageView *newarrowImg;
    UIImageView *hotarrowImg;
    UIImageView *pricearrowImg;
    //end
    
    BOOL isPriceDown;  //价格是否 是由低到高
    
    int _currentpage;  //当前第几页
    int _totalCount;  //总页数

    //存放cell
    NSMutableArray *contentArr;
    BrandsProductListModel *productListModel;


}

@property (nonatomic, retain) NSString *orderStr;


@end

@implementation NewMaginzeListViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (id)init{
    self = [super init];
    if (self)
        self.title = @"专辑";
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.strtitle.length > 1) {
        self.title = self.strtitle;
    }else{
    
    self.title = @"专辑";
    }

    [self creatTableView];


    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (app.mytabBarController.selectedIndex == 0) {
        
        if (self.isShowSwitchBtn) {
            [self createSwitchBtn];
        }
        [self createBackBtnWithType:0];

        [self NewHiddenTableBarwithAnimated:YES];
    }
    
    
    //初始化数据
    _currentpage = 1;
    contentArr = [[NSMutableArray alloc] initWithCapacity:0];
    
    
    //筛选按钮：
    //lee999 200版本 新增筛选界面
    [self createRightBtn];
    [self.navbtnRight setTitle:@"筛选" forState:UIControlStateNormal];
    [self.navbtnRight setTitle:@"筛选" forState:UIControlStateSelected];
    [self.navbtnRight setHidden:YES];


    mainSev = [[MainpageServ alloc] init];
    mainSev.delegate = self;

    [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    if ([_maginzeinfo.magazinelist count] < 1) {
        
        [self requestMaginzeData];
        
        [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
    }
    
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (app.mytabBarController.selectedIndex == 2) {
        [self NewSHowTableBarwithAnimated:YES];
    }
}


-(void)requestMaginzeData{
    if ([self.title isEqualToString:@"专辑"]) {
        [mainSev getMageinzeList20datawithTpye:@""];
    }else{
        [mainSev getMageinzeList20datawithTpye:self.strtitle];
    }

}


#pragma mark-- 筛选按钮
-(void)rightButAction{
    NewFilter20ViewController *newfvc = [[NewFilter20ViewController alloc] init];
    newfvc.delegate = self;
    newfvc.arrfilter = [NSMutableArray arrayWithArray:productListModel.productlistFilter];
    newfvc.arrSelectfilter = [NSMutableArray arrayWithArray:productListModel.productlist_select_filter];
    newfvc.params = self.params;
    newfvc.orderStr = self.orderStr;
    newfvc.key = @"";
    newfvc.strcurrentpage = [NSString stringWithFormat:@"%d",1];
    newfvc.strperpage = @"10";
    
    [self.navigationController pushViewController:newfvc animated:YES];
}


-(void)sureFilter:(NSString *)prama{
    NSLog(@"---%@",prama);

    _currentpage = 1;
    [contentdataArr removeAllObjects];
    
    [SingletonState sharedStateInstance].productlistType = 0;
    self.params = prama;
    [mainSev getProductlist:self.params andOrder:self.orderStr andKeyword:@"" andPage:[NSString stringWithFormat:@"%d",_currentpage] andPer_page:@"10"];
}




#pragma mark-- service
-(void)serviceStarted:(ServiceType)aHandle{
    
    [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
}

-(void)serviceFailed:(ServiceType)aHandle{
    [SBPublicAlert hideMBprogressHUD:self.view];
    
    [productTableV headerEndRefreshing];
    [productTableV footerEndRefreshing];
    
    [myTableV headerEndRefreshing];
    [myTableV footerEndRefreshing];
}

-(void)serviceFinished:(ServiceType)aHandle withmodel:(id)amodel{
    
    [SBPublicAlert hideMBprogressHUD:self.view];
    
    [productTableV headerEndRefreshing];
    [productTableV footerEndRefreshing];
    
    [myTableV headerEndRefreshing];
    [myTableV footerEndRefreshing];
    
    //如果是杂志
    if ([amodel isKindOfClass:[NSDictionary class]]) {
        _maginzeinfo = [[NewMaginzeParser alloc] parseMaginzeListInfo:amodel];
        [myTableV reloadData];
        return;
    }
    //end
    
    LBaseModel *model = (LBaseModel *)amodel;
    switch (model.requestTag) {
            
            
        case Http_Productlist_Tag:
        {
            if (!model.errorMessage) {
                [SBPublicAlert hideMBprogressHUD:self.view];
                
                productListModel = (BrandsProductListModel *)model;
                
                if (_currentpage == 1) {
                    [contentArr removeAllObjects];
                    [contentArr addObjectsFromArray:(NSMutableArray *)productListModel.productlistPictext];
                }else {
                    [contentArr addObjectsFromArray:(NSMutableArray *)productListModel.productlistPictext];
                }
                _totalCount = productListModel.recordCount;
                
                [productTableV reloadData];
                
                //[self updateTableViewCount:contentArr.count];
            }else {
                if (_currentpage > 1) {
                    
                    NSLog(@"进入了 失败  分页页码--------- 你懂吗？");
                    _currentpage--;
                    
                }
                [SBPublicAlert hideMBprogressHUD:self.view];
                //[self updateTableViewCount:contentArr.count];
            }
        }
            break;
        
        case 10086:
        {
            [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:0.6];
            return;
        }
            break;
        case 100861:
        {
            if (_currentpage > 1) {
                _currentpage--;
            }
            [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:0.6];
        }
        default:
            [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:0.6];
            //[self updateTableViewCount:contentArr.count];
            break;
    }
}


#pragma mark---UI创建
//创建表格
-(void)creatTableView{
    
    myTableV = [[UITableView alloc] init];
    myTableV.tag = 1001;
    
    
    //-----------专辑表格
    if (self.isShowSwitchBtn) {
        //显示切换按钮
        [myTableV setFrame:CGRectMake(0, SwitchViewHight, ScreenWidth, ScreenHeight- 50 -SwitchViewHight- 15)];
    }else{
        AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        if (app.mytabBarController.selectedIndex == 2) {
        [myTableV setFrame:CGRectMake(0, 0, ScreenWidth, selfViewHeight- 100)];
        }else{
            [myTableV setFrame:CGRectMake(0, 0, ScreenWidth, selfViewHeight- 45)];
        }
    }
    
    myTableV.delegate = self;
    myTableV.dataSource = self;
    [self.view addSubview:myTableV];
    [myTableV setBackgroundColor:[UIColor colorWithHexString:tableViewBGC]];
    [myTableV addHeaderWithTarget:self action:@selector(headerRereshingMaginze)];

    
    //----------------商品的表格！！！！
    if (self.isShowSwitchBtn) {
        
        productTableV = [[UITableView alloc] init];
        productTableV.tag = 1002;
        [productTableV setFrame:CGRectMake(0, SwitchViewHight*2, ScreenWidth, ScreenHeight- 50 -SwitchViewHight*2 - 15)];
        //切换按钮
        productTableV.delegate = self;
        productTableV.dataSource = self;
        [self.view addSubview:productTableV];
        [productTableV setBackgroundColor:[UIColor colorWithHexString:tableViewBGC]];
        
        productTableV.hidden = YES;
        
        [productTableV addHeaderWithTarget:self action:@selector(headerRereshingProductList)];
        [productTableV addFooterWithTarget:self action:@selector(footeraddDataingProductList)];
    }
}

-(void)createSwitchBtn{
    
    switchBtnView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, SwitchViewHight)];
    [switchBtnView setBackgroundColor:[UIColor colorWithHexString:@"F4F4F4"]];
    [self.view addSubview:switchBtnView];


    switchMyBuyPBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [switchMyBuyPBtn setFrame:CGRectMake(0, 0, ScreenWidth/2, SwitchViewHight)];
    switchMyBuyPBtn.translatesAutoresizingMaskIntoConstraints = NO;
    switchMyBuyPBtn.tag = 998;
    switchMyBuyPBtn.titleLabel.font = [UIFont systemFontOfSize:LabMidSize];
    [switchMyBuyPBtn setTitle:@"专辑" forState:UIControlStateNormal];
    [switchMyBuyPBtn setTitleColor:SelectedColor forState:UIControlStateNormal];
    [switchMyBuyPBtn addTarget:self action:@selector(switchProductBtn:) forControlEvents:UIControlEventTouchUpInside];
    [switchBtnView addSubview:switchMyBuyPBtn];
    
    switchWeShopPBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [switchWeShopPBtn setFrame:CGRectMake(ScreenWidth/2, 0, ScreenWidth/2, SwitchViewHight)];
    switchWeShopPBtn.translatesAutoresizingMaskIntoConstraints = NO;
    switchWeShopPBtn.tag = 997;
    switchWeShopPBtn.titleLabel.font = [UIFont systemFontOfSize:LabMidSize];
    [switchWeShopPBtn setTitleColor:NomalColor forState:UIControlStateNormal];
    [switchWeShopPBtn setTitle:@"商品" forState:UIControlStateNormal];
    [switchWeShopPBtn addTarget:self action:@selector(switchWXDProductBtn:) forControlEvents:UIControlEventTouchUpInside];
    [switchBtnView addSubview:switchWeShopPBtn];
    
    //底部
    UIView *sepVbtomm = [[UIView alloc] initWithFrame:CGRectMake(0, SwitchViewHight-1, ScreenWidth, 1)];
    [sepVbtomm setBackgroundColor:[UIColor colorWithHexString:@"#E8E8E8"]];
    [switchBtnView addSubview:sepVbtomm];
    
    //切换的
    switchSelectView = [[UIView alloc] initWithFrame:CGRectMake(0, SwitchViewHight-1, ScreenWidth/2, 1)];
    [switchSelectView setBackgroundColor:[UIColor colorWithHexString:@"#CF004B"]];
    [switchBtnView addSubview:switchSelectView];
    
    //中间的
    UIView *sepV0 = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth/2, 8, 0.5, SwitchViewHight-16)];
    [sepV0 setBackgroundColor:[UIColor colorWithHexString:@"#E8E8E8"]];
    [switchBtnView addSubview:sepV0];
    
    
    
    //-------筛选按钮
    
    sortBtnView = [[UIView alloc] initWithFrame:CGRectMake(0, SwitchViewHight, ScreenWidth, SwitchViewHight)];
    [sortBtnView setBackgroundColor:[UIColor colorWithHexString:@"FDFDFD"]];
    [self.view addSubview:sortBtnView];
    sortBtnView.hidden = YES;
    
    UIImage *imageDown = [UIImage imageNamed:@"list_arrow_down.png"];
    UIImage* imageUp = [UIImage imageNamed:@"list_arrow_up.png"];
    
    newarrowImg = [[UIImageView alloc] initWithFrame:CGRectMake(90, 10, imageDown.size.width, imageDown.size.height)];
    [newarrowImg setImage:imageDown];
    [sortBtnView addSubview:newarrowImg];
    
    hotarrowImg = [[UIImageView alloc] initWithFrame:CGRectMake(175, 10, imageDown.size.width, imageDown.size.height)];
    [hotarrowImg setImage:imageDown];
    [sortBtnView addSubview:hotarrowImg];
    
    pricearrowImg = [[UIImageView alloc] initWithFrame:CGRectMake(285, 10, imageDown.size.width, imageDown.size.height)];
    [pricearrowImg setImage:imageUp];
    [sortBtnView addSubview:pricearrowImg];
    
    
    newarrowImg.hidden = NO;
    hotarrowImg.hidden = YES;
    pricearrowImg.hidden = YES;
    
    
    newbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [newbtn setFrame:CGRectMake(0, 0, ScreenWidth/3, SwitchViewHight)];
    newbtn.translatesAutoresizingMaskIntoConstraints = NO;
    newbtn.tag = 100;
    newbtn.titleLabel.font = [UIFont systemFontOfSize:LabMidSize];
    [newbtn setTitle:@"最新上架" forState:UIControlStateNormal];
    [newbtn setTitleColor:SortSelectedColor forState:UIControlStateNormal];
    [newbtn addTarget:self action:@selector(sortBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [sortBtnView addSubview:newbtn];

    
    hotbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [hotbtn setFrame:CGRectMake(ScreenWidth/3, 0, ScreenWidth/3, SwitchViewHight)];
    hotbtn.translatesAutoresizingMaskIntoConstraints = NO;
    hotbtn.tag = 101;
    hotbtn.titleLabel.font = [UIFont systemFontOfSize:LabMidSize];
    [hotbtn setTitleColor:SortNomalColor forState:UIControlStateNormal];
    [hotbtn setTitle:@"人气" forState:UIControlStateNormal];
    [hotbtn addTarget:self action:@selector(sortBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [sortBtnView addSubview:hotbtn];
    
    
    pricebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [pricebtn setFrame:CGRectMake(ScreenWidth*2/3, 0, ScreenWidth/3, SwitchViewHight)];
    pricebtn.translatesAutoresizingMaskIntoConstraints = NO;
    pricebtn.tag = 102;
    pricebtn.titleLabel.font = [UIFont systemFontOfSize:LabMidSize];
    [pricebtn setTitleColor:SortNomalColor forState:UIControlStateNormal];
    [pricebtn setTitle:@"价格" forState:UIControlStateNormal];
    [pricebtn addTarget:self action:@selector(sortBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [sortBtnView addSubview:pricebtn];
    
}


#pragma mark--- Aciton   杂志
//刷新杂志列表页面
-(void)headerRereshingMaginze{
    [self requestMaginzeData];
    [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
}


#pragma mark--- Aciton   商品的上下拉刷新
-(void)headerRereshingProductList{
    
    _currentpage = 1;
    [contentArr removeAllObjects];
    
    [SingletonState sharedStateInstance].productlistType = 0;
    [mainSev getProductlist:self.params andOrder:self.orderStr andKeyword:@"" andPage:[NSString stringWithFormat:@"%d",_currentpage] andPer_page:@"10"];
    
    [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
}

-(void)footeraddDataingProductList{
    _currentpage++;
    
    [SingletonState sharedStateInstance].productlistType = 0;
    [mainSev getProductlist:self.params andOrder:self.orderStr andKeyword:@"" andPage:[NSString stringWithFormat:@"%d",_currentpage] andPer_page:@"10"];
    [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
}

//切换杂志
-(void)switchProductBtn:(id)sender{

    [self.navbtnRight setHidden:YES];
    
    myTableV.hidden = NO;
    productTableV.hidden = YES;
    
    [myTableV setFrame:CGRectMake(0, SwitchViewHight, ScreenWidth, ScreenHeight- 100 -SwitchViewHight- 20)];
     sortBtnView.hidden = YES;
    
    //我的商品
    [switchMyBuyPBtn setTitleColor:SelectedColor forState:UIControlStateNormal];
    [switchWeShopPBtn setTitleColor:NomalColor forState:UIControlStateNormal];
    
    [UIView animateWithDuration:0.3 animations:^{
        [switchSelectView setFrame:CGRectMake(0, SwitchViewHight-1, ScreenWidth/2, 1)];
    }];
}

//切换商品
-(void)switchWXDProductBtn:(id)sender{
    
    [self.navbtnRight setHidden:NO];
    
    myTableV.hidden = YES;
    productTableV.hidden = NO;
    sortBtnView.hidden = NO;
    
    //默认调去第一行
    UIButton* tmpBut;
    tmpBut.tag = 100;
    [self sortBtnClick:tmpBut];
    
    self.orderStr = @"desc";
    [newbtn setTitleColor:SortSelectedColor forState:UIControlStateNormal];
    [hotbtn setTitleColor:SortNomalColor forState:UIControlStateNormal];
    [pricebtn setTitleColor:SortNomalColor forState:UIControlStateNormal];
    
    newbtn.selected = YES;
    newarrowImg.hidden = NO;
    

    
    //微店商品
    [switchMyBuyPBtn setTitleColor:NomalColor forState:UIControlStateNormal];
    [switchWeShopPBtn setTitleColor:SelectedColor forState:UIControlStateNormal];
    
    [UIView animateWithDuration:0.3 animations:^{
        [switchSelectView setFrame:CGRectMake(ScreenWidth/2, SwitchViewHight-1, ScreenWidth/2, 1)];
        
    }];
}



- (IBAction)sortBtnClick:(id)sender {
    
    //每次都初始化为 1
    _currentpage = 1;
    newarrowImg.hidden = YES;
    hotarrowImg.hidden = YES;
    pricearrowImg.hidden = YES;
    
    [sender setSelected:YES];
    
    UIButton *btn = (UIButton*)sender;
    
    switch (btn.tag) {
        case 100:
        {//最新上架
            self.orderStr = @"desc";
            
            [newbtn setTitleColor:SortSelectedColor forState:UIControlStateNormal];
            [hotbtn setTitleColor:SortNomalColor forState:UIControlStateNormal];
            [pricebtn setTitleColor:SortNomalColor forState:UIControlStateNormal];

            newbtn.selected = YES;
            newarrowImg.hidden = NO;
        }
            break;
        case 101:
        {//人气
            self.orderStr = @"hot";
            [newbtn setTitleColor:SortNomalColor forState:UIControlStateNormal];
            [hotbtn setTitleColor:SortSelectedColor forState:UIControlStateNormal];
            [pricebtn setTitleColor:SortNomalColor forState:UIControlStateNormal];
            
            hotbtn.selected = YES;
            hotarrowImg.hidden = NO;
            
        }
            break;
        case 102:
        {//价格
            [newbtn setTitleColor:SortNomalColor forState:UIControlStateNormal];
            [hotbtn setTitleColor:SortNomalColor forState:UIControlStateNormal];
            [pricebtn setTitleColor:SortSelectedColor forState:UIControlStateNormal];
            
            if (isPriceDown) {
                isPriceDown = NO;
                self.orderStr = @"price_down";
                pricearrowImg.transform = CGAffineTransformMakeRotation(0);
            }else{
                isPriceDown = YES;
                self.orderStr = @"price_up";
                pricearrowImg.transform = CGAffineTransformMakeRotation(M_PI);
            }
            pricebtn.selected = YES;
            pricearrowImg.hidden = NO;
        }
            break;
        default:
            break;
    }
    
    [SingletonState sharedStateInstance].productlistType = 0;
    [mainSev getProductlist:self.params andOrder:self.orderStr andKeyword:@"" andPage:@"" andPer_page:@"10"];
    [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
}




#pragma mark-- tableView

// Section的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([tableView tag] == 1001) {
        return [_maginzeinfo.magazinelist count];
    }
    return 1;
}

// row的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView tag] == 1001) {
        return 1;
    }
    return ceil(contentArr.count/2.0);

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
        return lee1fitAllScreen(325); //+15 为中间间距
    }
    return lee1fitAllScreen(270);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (tableView.tag == 1001) {
        
        //专辑
        NewMaginzeData *item = [_maginzeinfo.magazinelist objectAtIndex:[indexPath section] isArray:nil];
        PPBuyCircleCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PPBuyCircleCommonCell"];
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"PPBuyCircleCommonCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            [tableView registerNib:[UINib nibWithNibName:@"PPBuyCircleCommonCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"PPBuyCircleCommonCell"];
        }
        cell.item = item;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setBackgroundColor:[UIColor clearColor]];
        return cell;
    }
    else{
    // 商品
        
        static NSString *CellIdentifier=@"MyCostomsCell";
        
        NSInteger row = [indexPath row];
        
        CollectCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell==nil) {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"CollectCell" owner:nil options:nil] objectAtIndex:0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell setImageData:row withArray:contentArr];
        cell.delegate = self;
        [cell setbuttonCancel:YES];
        
        return cell;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NewMaginzeData *item = [_maginzeinfo.magazinelist objectAtIndex:[indexPath section] isArray:nil];
    
    
    if ([item.magazine_type isEqualToString:@"A"]) {
    
        NewMaginzeAViewController *newMVC = [[NewMaginzeAViewController alloc] init];
        newMVC.strMaginzeId = item.magazine_id;
        newMVC.isFromHomePageAndShowSepBtn = self.isShowSwitchBtn;
        [self.navigationController pushViewController:newMVC animated:YES];
        
    }else{
        
//        NewMaginzeBViewController *newMVC = [[NewMaginzeBViewController alloc] init];
//        newMVC.strMaginzeId = item.magazine_id;
//        newMVC.isFromHomePageAndShowSepBtn = self.isShowSwitchBtn;
//        [self.navigationController pushViewController:newMVC animated:YES];
        
        NewMaginzeBViewControllerV2 *newMVC = [[NewMaginzeBViewControllerV2 alloc] init];
        newMVC.strMaginzeId = item.magazine_id;
        newMVC.isFromHomePageAndShowSepBtn = self.isShowSwitchBtn;
        [self.navigationController pushViewController:newMVC animated:YES];

        
    }
}





- (void) forkWithTag:(NSInteger)tag withProductId:(NSString *)productId{
    
}


- (void)forkProductList:(NSString *)productId {
    
    ProductDetailViewController *productDetailVC = [[ProductDetailViewController alloc] init];
    productDetailVC.thisProductId = productId;
    productDetailVC.isPush = YES;
    productDetailVC.isHiddenBar = YES;
    [self.navigationController pushViewController:productDetailVC animated:YES];
}


//#pragma mark 下拉加载数据
//- (void)updateTableViewCount:(NSInteger)theCount
//{
//    BOOL status = NO;
//    if (theCount < _totalCount) {//小于
//        status = YES;
//    }
//    //productTableV.isCloseFooter = !status;
//    
//    if (status) {//还有数据
//        // 一定要调用本方法，否则下拉/上拖视图的状态不会还原，会一直转菊花
//        [productTableV reloadData];
//    } else {//没有数据
//        //  一定要调用本方法，否则下拉/上拖视图的状态不会还原，会一直转菊花
//        [productTableV reloadData];
//    }
//}




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
