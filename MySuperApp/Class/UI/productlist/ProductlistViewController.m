//
//  ProductlistViewController.m
//  MySuperApp
//
//  Created by lee on 14-4-2.
//  Copyright (c) 2014年 aimer. All rights reserved.
//

#import "ProductlistViewController.h"
#import "ProductDetailViewController.h"
#import "YKPreferentialSuit.h"
#import "NewFilter20ViewController.h"

@interface ProductlistViewController ()
{

}
@end

@implementation ProductlistViewController
@synthesize suitname;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.isHot) {
        self.title = @"热卖";
    }else {
        self.title = @"新品";
    }
    
    if (self.isSearch) {
        self.title = self.titleName?self.titleName:@"搜索结果";
    }else {
        self.title = self.titleName?self.titleName:self.title;
    }
    
    isPriceDown = YES;

    
    //lee999 修改标题文案
    if (self.titleName && ![self.titleName isEqualToString:@""] && self.titleName.length> 1) {
        self.title = self.titleName;
    }

    //lee999
    current = 1;

    [self NewHiddenTableBarwithAnimated:YES];
    
    
    contentArr = [[NSMutableArray alloc] initWithCapacity:0];
    
    [self createBackBtnWithType:0];
    mainSev = [[MainpageServ alloc] init];
    mainSev.delegate = self;
    
    if (self.isSuitlist) {
//        producttabV.isCloseFooter = YES;
//        producttabV.isCloseHeader = YES;
        viewbtns.hidden = YES;
        
        [mainSev getSuitlistwithname:suitname];
        [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
        
    }else{
    }
    
    //lee894设置首页的高度~~
    //适配屏幕及系统版本
    [self fitIOSFrame];
    
    [producttabV setBackgroundColor:[UIColor colorWithHexString:tableViewBGC]];
    
    [producttabV addHeaderWithTarget:self action:@selector(headerRereshingProductList)];
    [producttabV addFooterWithTarget:self action:@selector(footeraddDataingProductList)];
    
    
}

#pragma mark-- 筛选按钮
-(void)rightButAction{
    NewFilter20ViewController *newfvc = [[NewFilter20ViewController alloc] init];
    newfvc.delegate = self;
    //所有的筛选信息
    newfvc.arrfilter = [NSMutableArray arrayWithArray:productListModel.productlistFilter];
    //已选中的筛选信息
    newfvc.arrSelectfilter = [NSMutableArray arrayWithArray:productListModel.productlist_select_filter];
    newfvc.params = self.params;
    newfvc.orderStr = self.orderStr;
    //newfvc.key = self.key;
    //lee999 150506 修改搜索的key
    if ([self.key description].length > 0 && self.isFromSearchPage) {
        self.params = [NSString stringWithFormat:@"k,%@",self.key];
        self.key = @"";
    }
    //end
    
    newfvc.strcurrentpage = [NSString stringWithFormat:@"%d",current];
    newfvc.strperpage = @"10";
    [self.navigationController pushViewController:newfvc animated:YES];
}


-(void)sureFilter:(NSString *)prama{
    NSLog(@"---%@",prama);

    current = 1;
    self.params = prama;
    
    self.title = @"筛选结果";
    
    [mainSev getProductlist:self.params andOrder:self.orderStr andKeyword:self.key andPage:[NSString stringWithFormat:@"%d",current] andPer_page:@"10"];
    [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];

}


//适配不同屏幕及尺寸
-(void)fitIOSFrame{
//    if (isIOS7up) {
//        [viewbtns setFrame:CGRectMake(0, 60, 320, 40)];
//        producttabV.frame = CGRectMake(0, 100, 320, self.view.frame.size.height-100);
        if (self.isSuitlist) {
            viewbtns.hidden = YES;
            producttabV.frame = CGRectMake(0, 0, 320, self.view.frame.size.height-0);
        }
//    }else{
//        [viewbtns setFrame:CGRectMake(0, 0, 320, 40)];
//        producttabV.frame = CGRectMake(0, 40, 320, self.view.frame.size.height-40);
//        if (self.isSuitlist) {
//            producttabV.frame = CGRectMake(0, 0, 320, self.view.frame.size.height);
//        }
//    }
}




- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    UIButton *tmpBut = nil;
    if (self.isHot) {
        tmpBut = (UIButton *)[viewbtns viewWithTag:101];
    }else  if (self.isOrder){
        tmpBut = (UIButton *)[viewbtns viewWithTag:102];
    }else {
        tmpBut = (UIButton *)[viewbtns viewWithTag:100];
    }

    [self sortBtnClick:tmpBut];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    //临走跳转之前，显示这些按钮
    [self showTitleAndFootwithAnimated:NO];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//旋转图片问题

- (IBAction)sortBtnClick:(id)sender {
    
    for (int i = 100; i < 104; i++) {
        UIButton *tmpBut = (UIButton *)[viewbtns viewWithTag:i];
        [tmpBut setSelected:NO];
    }
    
    current = 1;
    newkeyImg.hidden = YES;
    hotkeyImg.hidden = YES;
    pricekeyImg.hidden = YES;
    
    newarrowImg.hidden = YES;
    hotarrowImg.hidden = YES;
    pricearrowImg.hidden = YES;
    
    [sender setSelected:YES];
    
    UIButton *btn = (UIButton*)sender;
    
    switch (btn.tag) {
        case 100:
        {//最新上架
            self.isOrder = NO;
            self.isHot = NO;
            self.orderStr = @"desc";
            newbtn.selected = YES;
            newkeyImg.hidden = NO;
            newarrowImg.hidden = NO;
        }
            break;
        case 101:
        {//人气
            self.isOrder = NO;
            self.isHot = YES;
            self.orderStr = @"hot";
            hotbtn.selected = YES;
            hotkeyImg.hidden = NO;
            hotarrowImg.hidden = NO;
            
        }
            break;
        case 102:
        {//价格
            self.isOrder = YES;
            self.isHot = NO;
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
            pricekeyImg.hidden = NO;
            pricearrowImg.hidden = NO;
        }
            break;
        default:
            break;
    }
    
    if (!self.isSearch) {
        
        if (!self.isProduct) {
            if (!self.isSuitlist) {
                [self headerRereshingProductList];
            }
        }
    }else {
        if (self.isSuitlist) {
            viewbtns.hidden = YES;
        }else{
            viewbtns.hidden = NO;
        }
        if (!isShow){
            if (!self.isSuitlist) {
                
                //lee999 150506 修改搜索的key
                if ([self.key description].length > 0 && self.isFromSearchPage) {
                    self.params = [NSString stringWithFormat:@"k,%@",self.key];
                    self.key = @"";
                }
                //end

            [mainSev getProductlist:self.params andOrder:self.orderStr andKeyword:self.key andPage:[NSString stringWithFormat:@"%d",current] andPer_page:@"10"];
            [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];

            }
        }
    }
}

#pragma mark--- Aciton   商品的上下拉刷新
-(void)headerRereshingProductList{
    
    current = 1;
    if (contentArr && contentArr.count >0) {
        [contentArr removeAllObjects];
    }
    
    [mainSev getProductlist:self.params andOrder:self.orderStr andKeyword:@"" andPage:[NSString stringWithFormat:@"%d",current] andPer_page:@"10"];
    
    [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
}

-(void)footeraddDataingProductList{
    current++;
    [mainSev getProductlist:self.params andOrder:self.orderStr andKeyword:@"" andPage:[NSString stringWithFormat:@"%d",current] andPer_page:@"10"];
    [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
}




#pragma mark -- net request delegate
-(void)serviceStarted:(ServiceType)aHandle{
}

-(void)serviceFailed:(ServiceType)aHandle{
    [SBPublicAlert hideMBprogressHUD:self.view];
    
    
    [producttabV headerEndRefreshing];
    [producttabV footerEndRefreshing];
}

-(void)serviceFinished:(ServiceType)aHandle withmodel:(id)amodel{
    
    [SBPublicAlert hideMBprogressHUD:self.view];
    LBaseModel *model = (LBaseModel *)amodel;
    
    
    [producttabV headerEndRefreshing];
    [producttabV footerEndRefreshing];

    switch (model.requestTag) {
        case Http_Productlist_Tag:
        {
            if (!model.errorMessage) {
                [SBPublicAlert hideMBprogressHUD:self.view];
                
                productListModel = (BrandsProductListModel *)model;
                
                if (self.isSearch&&productListModel.recordCount == 0) {
                    [SBPublicAlert showMBProgressHUD:@"没有查到此商品" andWhereView:self.view hiddenTime:0.6];
                    return;
                }
                if (current == 1) {
                    if (contentArr && contentArr.count >0) {
                        [contentArr removeAllObjects];
                    }
                    [contentArr addObjectsFromArray:(NSMutableArray *)productListModel.productlistPictext];
                }else {
                    [contentArr addObjectsFromArray:(NSMutableArray *)productListModel.productlistPictext];
                }
                totalCount = productListModel.recordCount;
                [producttabV reloadData];
                
                //[self updateTableViewCount:contentArr.count];
                
                
                //lee999 200版本 新增筛选界面
                if (!self.isHiddenFilerbtn && [contentArr count]> 0) {
                    [self createRightBtn];
                    [self.navbtnRight setTitle:@"筛选" forState:UIControlStateNormal];
                    [self.navbtnRight setTitle:@"筛选" forState:UIControlStateSelected];
                }
                
            }else {
                if (current > 1) {
                    
                    NSLog(@"进入了 失败  分页页码--------- 你懂吗？");
                    current--;
                }
                [SBPublicAlert hideMBprogressHUD:self.view];
                //[self updateTableViewCount:contentArr.count];
            }            
        }
            break;
        case Http_SuitList_Tag:
        {
            if (!model.errorMessage) {
                [SBPublicAlert hideMBprogressHUD:self.view];
                contentArr = (NSMutableArray *)[(SuitListSuitListModel *)model suitlist];
                [producttabV reloadData];
                
            }else{
                [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:0.6];
            }
            return;
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
            if (current > 1) {
                current--;
            }
            [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:0.6];
        }
        default:
            [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:0.6];
            //[self updateTableViewCount:contentArr.count];
            break;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ceil(contentArr.count/2.0);
}

- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier=@"MyCostomsCell";
    
    NSInteger row = [indexPath row];
    
    CollectCell *cell=[_tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"CollectCell" owner:nil options:nil] objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell setImageData:row withArray:contentArr];
    cell.delegate = self;
    [cell setbuttonCancel:YES];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



- (void) forkWithTag:(NSInteger)tag withProductId:(NSString *)productId{
}

- (void)forkProductList:(NSString *)productId {
    self.isProduct = YES;
    
    if (self.isSuitlist) {
        //        套装信息
        
        YKPreferentialSuit *controller = [[YKPreferentialSuit alloc] init];
//        controller.mill_Tag = self.mill_Tag;
        controller.strStuit = productId;
        [self.navigationController pushViewController:controller animated:YES];
    
    }else {
    
        ProductDetailViewController *productDetailVC = [[ProductDetailViewController alloc] init];
        productDetailVC.thisProductId = productId;
//        productDetailVC.mill_Tag = self.mill_Tag;
        productDetailVC.isPush = YES;
        productDetailVC.isHiddenBar = YES;
//        productDetailVC.MillVC = self.MillVC;
        [self.navigationController pushViewController:productDetailVC animated:YES];
    }
}

//#pragma mark 滑动隐藏
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
//    return YES;
//}
//
//- (void)handleSwipeUp:(UISwipeGestureRecognizer *)param{
//    if (param.direction & UISwipeGestureRecognizerDirectionUp) {
//        NSLog(@"上滑了，要隐藏nav");
//        if (!isShow) {
////            [self hiddenTitleAndFootwithAnimated:YES];
////            [UIView animateWithDuration:0.6 delay:0 options:UIViewAnimationOptionRepeat animations:^{
////                [viewbtns setFrame:CGRectMake(0, -40, 320, 40)];
////                producttabV.frame = CGRectMake(0, 0, 320, self.view.frame.size.height);
////            } completion:^(BOOL finished) {
////            }];
//
//        }
//        isShow = YES;
//    }
//}
//- (void)handleSwipeDown:(UISwipeGestureRecognizer *)param{
//    if (param.direction & UISwipeGestureRecognizerDirectionDown) {
//        NSLog(@"下滑了，要显示");
//        if (isShow) {
////            [self showTitleAndFootwithAnimated:YES];
////            [UIView animateWithDuration:0.6 delay:0 options:UIViewAnimationOptionRepeat animations:^{
//                //初始设置view的位置
//                        
//            //lee894设置首页的高度~~
//            //适配屏幕及系统版本
////            [self fitIOSFrame];
//            
////                [viewbtns setFrame:CGRectMake(0, 60, 320, 40)];
////                producttabV.frame = CGRectMake(0, 100, 320, self.view.frame.size.height-100);
////            } completion:^(BOOL finished) {
////            }];
//        }
//        isShow = NO;
//    }
//}

//#pragma mark 刷新
//-(void)getData
//{
//    current = 1;
//    NSString *PageCurr = [NSString stringWithFormat:@"%d",current];
//    [mainSev getProductlist:self.params andOrder:self.orderStr andKeyword:self.key andPage:PageCurr andPer_page:@"10"];
//    
//    [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
//}
//
//#pragma mark 下拉加载数据
//- (void)nextPage
//{
//    current ++;
//    NSString *PageCurr = [NSString stringWithFormat:@"%d",current];
//    [mainSev getProductlist:self.params andOrder:self.orderStr andKeyword:self.key andPage:PageCurr andPer_page:@"10"];
//}
//- (void)updateTableViewCount:(NSInteger)theCount
//{
//    BOOL status = NO;
//    if (theCount < totalCount) {//小于
//        status = YES;
//    }
//    producttabV.isCloseFooter = !status;
//    
//    if (status) {//还有数据
//        // 一定要调用本方法，否则下拉/上拖视图的状态不会还原，会一直转菊花
//        [producttabV reloadData:NO];
//    } else {//没有数据
//        //  一定要调用本方法，否则下拉/上拖视图的状态不会还原，会一直转菊花
//        [producttabV reloadData:YES];
//    }
//}
//- (void)updateThread:(NSString *)returnKey{
//    switch ([returnKey intValue]) {
//        case k_RETURN_REFRESH:
//            //            [data removeAllObjects];
//            [self getData];
//            break;
//        case k_RETURN_LOADMORE:
//            [self nextPage];
//            break;
//        default:
//            break;
//    }
//}
//
//
//#pragma mark 刷新的代理方法
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    if (!self.isSuitlist) {
//        NSInteger returnKey = [producttabV tableViewDidEndDragging];
//        if (returnKey != k_RETURN_DO_NOTHING) {
//            NSString * key = [NSString stringWithFormat:@"%d", returnKey];
//            [self updateThread:key];
//        }
//    }
//}
//
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    if (!self.isSuitlist) {
//        
//        NSInteger returnKey = [producttabV tableViewDidDragging];
//        if (returnKey == k_RETURN_LOADMORE) {
//            NSString * key = [NSString stringWithFormat:@"%d", returnKey];
//            [self updateThread:key];
//        }
//        
//    }
//}

@end
