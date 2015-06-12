////
////  NewPageViewController.m
////  aimerOnline
////
////  Created by lee on 14-3-3.
////  Copyright (c) 2014年 aimer. All rights reserved.
////
//
//#import "NewPageViewController.h"
//#import "AppDelegate.h"
//#import "AKTabBarController.h"
//#import "ProductDetailViewController.h"
//
//
//@interface NewPageViewController ()
//
//@end
//
//@implementation NewPageViewController
//
//- (NSString *)tabImageName
//{
//	return @"tab02_icon_new";
//}
//- (NSString *)tabTitle
//{
//	return @"新品";
//}
//
//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}
//
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    
//    self.title = @"新品";
//    
//    [self createBackBtnWithType:0];
//    
//    
//    //创建右边按钮
////    [self createRightBtn];
////    [self.navbtnRight setBackgroundImage:[UIImage imageNamed:@"nav_icon_mine.png"] forState:UIControlStateNormal];
////    [self.navbtnRight setTitle:@"" forState:UIControlStateNormal];
////    [self.navbtnRight setTitle:@"" forState:UIControlStateHighlighted];
////    [self.navbtnRight setBackgroundImage:[UIImage imageNamed:@"nav_icon_mine_press.png"] forState:UIControlStateHighlighted];
////    [self.navbtnRight setFrame:CGRectMake(0, 10, 25, 25)];
////    [self.navbtnRight addTarget:self action:@selector(gotoUserCenter) forControlEvents:UIControlEventTouchUpInside];
//    
//    
//    //lee999 200版本 新增筛选界面
//    [self createRightBtn];
//    [self.navbtnRight setTitle:@"筛选" forState:UIControlStateNormal];
//    [self.navbtnRight setTitle:@"筛选" forState:UIControlStateSelected];
//    
//    
//    [self NewHiddenTableBarwithAnimated:YES];
//    
//    
//    isPriceDown = YES;
//    self.isHot = NO;
//
//    //添加手势动作
//    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeUp:)];
//    swipe.direction = UISwipeGestureRecognizerDirectionUp;
//    swipe.numberOfTouchesRequired = 1;
//    swipe.delegate = self;
//    
//    UISwipeGestureRecognizer *swipe2 = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeDown:)];
//    swipe2.direction = UISwipeGestureRecognizerDirectionDown;
//    swipe2.numberOfTouchesRequired = 1;
//    swipe2.delegate = self;
//    
//    [producttabV addGestureRecognizer:swipe];
//    [producttabV addGestureRecognizer:swipe2];
//    
//    contentArr = [NSMutableArray array];
//    
//    mainSev = [[MainpageServ alloc] init];
//    mainSev.delegate = self;
//    
//    //lee894设置首页的高度~~
//    //适配屏幕及系统版本
//    [self fitIOSFrame];
//    
//    
//    //lee999 不用每次都刷新
//    UIButton *tmpBut = nil;
//    if (self.isHot) {
//        tmpBut = (UIButton *)[viewbtns viewWithTag:101];
//    }else  if (self.isOrder){
//        tmpBut = (UIButton *)[viewbtns viewWithTag:102];
//    }else {
//        tmpBut = (UIButton *)[viewbtns viewWithTag:100];
//    }
//    [self sortBtnClick:tmpBut];
//    [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
//}
//
//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//
//    //lee999 不用每次都刷新
////    UIButton *tmpBut = nil;
////    if (self.isHot) {
////        tmpBut = (UIButton *)[viewbtns viewWithTag:101];
////    }else  if (self.isOrder){
////        tmpBut = (UIButton *)[viewbtns viewWithTag:102];
////    }else {
////        tmpBut = (UIButton *)[viewbtns viewWithTag:100];
////    }
////    
////    [self sortBtnClick:tmpBut];
////    [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
//
//}
//
//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:YES];
//    
//    //临走跳转之前，显示这些按钮
//    [self showTitleAndFootwithAnimated:NO];
//}
//
//////到用户中心  todo
////-(void)gotoUserCenter{
////    //切换到我的爱慕 来源于竖屏的商场~~
////    [SingletonState sharedStateInstance].myaimerIsFrom = 2;
////    [self changeToMyaimer];
////}
//#pragma mark-- 筛选按钮
//-(void)rightButAction{
//    NewFilter20ViewController *newfvc = [[NewFilter20ViewController alloc] init];
//    newfvc.delegate = self;
//    newfvc.arrfilter = [NSMutableArray arrayWithArray:productListModel.productlistFilter];
//    newfvc.params = self.params;
//    newfvc.orderStr = self.orderStr;
//    newfvc.key = self.key;
//    newfvc.strcurrentpage = [NSString stringWithFormat:@"%d",current];
//    newfvc.strperpage = @"10";
//    
//    [self.navigationController pushViewController:newfvc animated:YES];
//}
//
//
//-(void)sureFilter:(NSString *)prama{
//    NSLog(@"---%@",prama);
//    
//    current = 1;
//    self.params = prama;
//    
//    [mainSev getProductlist:self.params andOrder:self.orderStr andKeyword:self.key andPage:[NSString stringWithFormat:@"%d",current] andPer_page:@"10"];
//    [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
//    [SBPublicAlert hideMBprogressHUD:self.view];
//}
//
//
//
//
////适配不同屏幕及尺寸
//-(void)fitIOSFrame{
////    if (isIOS7up) {
////        [viewbtns setFrame:CGRectMake(0, 60, 320, 40)];
////        producttabV.frame = CGRectMake(0, 100, 320, self.view.frame.size.height-100);
////    }else{
//        [viewbtns setFrame:CGRectMake(0, 0, 320, 40)];
//        producttabV.frame = CGRectMake(0, 40, 320, self.view.frame.size.height-40);
////    }
//}
//
////旋转图片问题
//
//- (IBAction)sortBtnClick:(id)sender {
//    
//    for (int i = 100; i < 104; i++) {
//        UIButton *tmpBut = (UIButton *)[viewbtns viewWithTag:i];
//        [tmpBut setSelected:NO];
//    }
//    
//    current = 1;
//    newkeyImg.hidden = YES;
//    hotkeyImg.hidden = YES;
//    pricekeyImg.hidden = YES;
//    
//    newarrowImg.hidden = YES;
//    hotarrowImg.hidden = YES;
//    pricearrowImg.hidden = YES;
//    
//    [sender setSelected:YES];
//    
//    UIButton *btn = (UIButton*)sender;
//    
//    switch (btn.tag) {
//        case 100:
//        {//最新上架
//            self.isOrder = NO;
//            self.isHot = NO;
//            self.orderStr = @"desc";
//            newbtn.selected = YES;
//            newkeyImg.hidden = NO;
//            newarrowImg.hidden = NO;
//        }
//            break;
//        case 101:
//        {//人气
//            self.isOrder = NO;
//            self.isHot = YES;
//            self.orderStr = @"hot";
//            hotbtn.selected = YES;
//            hotkeyImg.hidden = NO;
//            hotarrowImg.hidden = NO;
//            
//        }
//            break;
//        case 102:
//        {//价格
//            self.isOrder = YES;
//            self.isHot = NO;
//            if (isPriceDown) {
//                isPriceDown = NO;
//                self.orderStr = @"price_down";
//                pricearrowImg.transform = CGAffineTransformMakeRotation(0);
//            }else{
//                isPriceDown = YES;
//                self.orderStr = @"price_up";
//                pricearrowImg.transform = CGAffineTransformMakeRotation(M_PI);
//            }
//            pricebtn.selected = YES;
//            pricekeyImg.hidden = NO;
//            pricearrowImg.hidden = NO;
//        }
//            break;
//        default:
//            break;
//    }
//
//    //lee999recode有时候新品/价格按钮无效，点了不排序。奇怪的很
////    if (!self.isSearch) {
////        
////        if (!self.isProduct) {
////            [self getData];
////        }
////    }else {
//        viewbtns.hidden = NO;
////        if (!isShow){
//            [mainSev getProductlist:self.params andOrder:self.orderStr andKeyword:self.key andPage:@"" andPer_page:@"10"];
//            [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
////            [SBPublicAlert hideMBprogressHUD:self.view];
////        }
////    }
//}
//
//
//#pragma mark -- net request delegate
//-(void)serviceStarted:(ServiceType)aHandle{
//}
//
//-(void)serviceFailed:(ServiceType)aHandle{
//    [SBPublicAlert hideMBprogressHUD:self.view];
//}
//
//-(void)serviceFinished:(ServiceType)aHandle withmodel:(id)amodel{
//    
//    [SBPublicAlert hideMBprogressHUD:self.view];
//    LBaseModel *model = (LBaseModel *)amodel;
//    
//    switch (model.requestTag) {
//        case Http_Productlist_Tag:
//        {
//            if (!model.errorMessage) {
//                [SBPublicAlert hideMBprogressHUD:self.view];
//                
//                productListModel = (BrandsProductListModel *)model;
//                
//                if (self.isSearch&&productListModel.recordCount == 0) {
//                    [SBPublicAlert showMBProgressHUD:@"没有查到此商品" andWhereView:self.view hiddenTime:0.6];
//                    return;
//                }
//                if (current == 1) {
//                    [contentArr removeAllObjects];
//                    [contentArr addObjectsFromArray:(NSMutableArray *)productListModel.productlistPictext];
//                }else {
//                    [contentArr addObjectsFromArray:(NSMutableArray *)productListModel.productlistPictext];
//                }
//                totalCount = productListModel.recordCount;
//                [self updateTableViewCount:contentArr.count];
//            }else {
//                if (current > 1) {
//                    
//                    NSLog(@"进入了 失败  分页页码--------- 你懂吗？");
//                    current--;
//                    
//                }
//                [SBPublicAlert hideMBprogressHUD:self.view];
//                [self updateTableViewCount:contentArr.count];
//            }
//        }
//            break;
//        case Http_SuitList_Tag:
//        {
//            if (!model.errorMessage) {
//                [SBPublicAlert hideMBprogressHUD:self.view];
//                contentArr = (NSMutableArray *)[(SuitListSuitListModel *)model suitlist];
//                [producttabV reloadData];
//                
//            }else{
//                [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:0.6];
//            }
//            return;
//        }
//            break;
//        case 10086:
//        {
//            [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:0.6];
//            return;
//        }
//            break;
//        case 100861:
//        {
//            if (current > 1) {
//                current--;
//            }
//            [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:0.6];
//        }
//        default:
//            [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:0.6];
//            [self updateTableViewCount:contentArr.count];
//            break;
//    }
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return ceil(contentArr.count/2.0);
//}
//
//- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *CellIdentifier=@"MyCostomsCell";
//    
//    NSInteger row = [indexPath row];
//    
//    CollectCell *cell=[_tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell==nil) {
//        cell=[[[NSBundle mainBundle] loadNibNamed:@"CollectCell" owner:nil options:nil] objectAtIndex:0];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    }
//    [cell setImageData:row withArray:contentArr];
//    cell.delegate = self;
//    [cell setbuttonCancel:YES];
//    
//    return cell;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//}
//
//
//
//- (void) forkWithTag:(NSInteger)tag withProductId:(NSString *)productId{
//}
//
//- (void)forkProductList:(NSString *)productId {
//    self.isProduct = YES;
//    
//    //    if (self.isSuit) {
//    //
//    //        //        套装信息
//    //
//    //        YKPreferentialSuit *controller = [[YKPreferentialSuit alloc] init];
//    //        controller.mill_Tag = self.mill_Tag;
//    //        controller.strStuit = productID;
//    //        [self.navigationController pushViewController:controller animated:YES];
//    //        [controller release];
//    //
//    //
//    //    }else {
//    
//    ProductDetailViewController *productDetailVC = [[ProductDetailViewController alloc] init];
//    productDetailVC.thisProductId = productId;
//    //        productDetailVC.mill_Tag = self.mill_Tag;
//    productDetailVC.isPush = YES;
//    productDetailVC.isHiddenBar = YES;
//
//    //        productDetailVC.MillVC = self.MillVC;
//    [self.navigationController pushViewController:productDetailVC animated:YES];
//    //    }
//}
//
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
////            //            [UIView animateWithDuration:0.6 delay:0 options:UIViewAnimationOptionRepeat animations:^{
////            [viewbtns setFrame:CGRectMake(0, -40, 320, 40)];
////            producttabV.frame = CGRectMake(0, 0, 320, self.view.frame.size.height);
//            //            } completion:^(BOOL finished) {
//            //            }];
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
////            //            [UIView animateWithDuration:0.6 delay:0 options:UIViewAnimationOptionRepeat animations:^{
////            //初始设置view的位置
////            
////            //lee894设置首页的高度~~
////            //适配屏幕及系统版本
////            [self fitIOSFrame];
//            
//            //                [viewbtns setFrame:CGRectMake(0, 60, 320, 40)];
//            //                producttabV.frame = CGRectMake(0, 100, 320, self.view.frame.size.height-100);
//            //            } completion:^(BOOL finished) {
//            //            }];
//        }
//        isShow = NO;
//    }
//}
//
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
//    if (!self.isSuit) {
//        NSInteger returnKey = [producttabV tableViewDidEndDragging];
//        if (returnKey != k_RETURN_DO_NOTHING) {
//            NSString * key = [NSString stringWithFormat:@"%d", returnKey];
//            [self updateThread:key];
//        }
//    }
//    
//}
//
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    
//    //lee999 增加上拉隐藏tablebar的功能
//    newContentOffsetY = scrollView.contentOffset.y;
//    if (newContentOffsetY - lastPosition > 30 || newContentOffsetY >= scrollView.contentSize.height)
//    {
//        //隐藏
////        [self hiddenTitleAndFootwithAnimated:YES];
////        [viewbtns setFrame:CGRectMake(0, -40, 320, 40)];
////        producttabV.frame = CGRectMake(0, 0, 320, self.view.frame.size.height);
//    }
//    else if(lastPosition - newContentOffsetY > 30 && newContentOffsetY < scrollView.contentSize.height){
//        //显示
////        [self showTitleAndFootwithAnimated:YES];
//        
//        //lee999recode
////        if ([[[UIDevice currentDevice] systemVersion] intValue]<7) {
////            [self performSelector:@selector(showTableBar) withObject:nil afterDelay:0.5f];
////        }
//        //end
//        
//        //lee894设置首页的高度~~
//        //适配屏幕及系统版本
//        [self fitIOSFrame];
//    }
//    //end
//    
//    
//    if (!self.isSuit) {
//        NSInteger returnKey = [producttabV tableViewDidDragging];
//        if (returnKey == k_RETURN_LOADMORE) {
//            NSString * key = [NSString stringWithFormat:@"%d", returnKey];
//            [self updateThread:key];
//        }
//    }
//}
//
//-(void)showTableBar{
//    [self ShowFooterwithAnimated:YES];
//}
//
//
////bool ishidden;
////-(void)yinyuanLook:(id)sender{
////    
////    AppDelegate* app = (AppDelegate*)[UIApplication sharedApplication].delegate;
////    if (!ishidden) {
////        [self.navigationController setNavigationBarHidden:YES animated:YES];
////        [app.aktabBarController hideTabBar:AKShowHideFromLeft animated:YES];
////        ishidden = YES;
////    }else{
////        [self.navigationController setNavigationBarHidden:NO animated:YES];
////        [app.aktabBarController showTabBar:AKShowHideFromLeft animated:YES];
////        ishidden = NO;
////    }
////}
//
//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//@end
