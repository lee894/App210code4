//
//  OrderViewController.m
//  MySuperApp
//
//  Created by LEE on 14-4-5.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "OrderViewController.h"
#import "OrderCell.h"
#import "OrderDetailViewController.h"
#import "AlipayHelper.h"
#import "WXPayClient.h"
#import "CommOrderScrollViewController.h"

#import "LogisticsViewController.h"
#import "JSBadgeView.h"

#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#import "UPPayPlugin.h"


@interface OrderViewController () {
    UILabel *noorderlabel;
    
    NSInteger selectTag;//选中的tag
    BOOL isMakesureGetgood;  //是否点击了确认收货
    
    BOOL isGetNotice;  //是否弹出了升级提示框
    BOOL isAddNotification;
    
}

@end

@implementation OrderViewController

@synthesize howEnter;
@synthesize enterWhere;

@synthesize bandgeNum1,bandgeNum2;
@synthesize ishowHeadView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    
    isAddNotification = NO;
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"alipayOKanjumptoOrderDetail" object:nil];
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [SingletonState sharedStateInstance].alipayisShowAlert = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideSeeButPay:) name:@"alipayOKanjumptoOrderDetail" object:nil];

    //lee999从viewDidLoad 移动到这个地方，为了每次进来都刷新数据
    [self getData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self NewHiddenTableBarwithAnimated:YES];
    
    isAddNotification = NO;
    isGetNotice = NO;
    
    contentArr = [NSMutableArray array];
    current = 1;
    
    if (howEnter == 1) {
        self.title = @"我的订单";
        allkeyImg.hidden = NO;
        needpayImg.hidden = YES;
        needcommkeyImg.hidden = YES;
        needHandlekeyImg.hidden = YES;
        
        [allbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [needpayBtn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        [needcommbtn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        [needHandlebtn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        
    }else if(howEnter == 2){
        self.title = @"待处理";
        allkeyImg.hidden = YES;
        needpayImg.hidden = YES;
        needcommkeyImg.hidden = YES;
        needHandlekeyImg.hidden = NO;
        
        [allbtn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        [needpayBtn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        [needcommbtn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        [needHandlebtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
    }else if(howEnter == 3){
        self.title = @"待评价";
        allkeyImg.hidden = YES;
        needpayImg.hidden = YES;
        needcommkeyImg.hidden = NO;
        needHandlekeyImg.hidden = YES;
        
        [allbtn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        [needpayBtn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        [needcommbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [needHandlebtn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        
    }
    else if(howEnter == 4){
        self.title = @"待付款";
        allkeyImg.hidden = YES;
        needpayImg.hidden = NO;
        needcommkeyImg.hidden = YES;
        needHandlekeyImg.hidden = YES;
        
        [allbtn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        [needpayBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [needcommbtn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        [needHandlebtn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
    }
    
    [SingletonState sharedStateInstance].isInCheckOKView = NO;
    
    
//    [tableList addHeaderWithTarget:self action:@selector(getData)];
//    [tableList addFooterWithTarget:self action:@selector(nextPage)];
    
    
    //lee999  全部订单加上分类的头头
//    if (!ishowHeadView) {
//        headview.hidden = YES;
//        CGRect oldframe = tableList.frame;
//        oldframe.origin.y = 0;
//        oldframe.size.height += 40;
//        tableList.frame = oldframe;
//    }else{
//        headview.hidden = NO;
//        [self.view addSubview:headview];
//    }
    
//    if (isIOS7up) {
////        if (ishowHeadView) {
//            [headview setFrame:CGRectMake(0, 0, ScreenWidth, 40)];
//            [tableList setFrame:CGRectMake(0, 40, ScreenWidth, self.view.frame.size.height-40)];
////        }else{
////            [tableList setFrame:CGRectMake(0, 60, 320, self.view.frame.size.height-60)];
////        }
//    }
    //lee999
    
    //返回按钮
    [self createBackBtnWithType:0];

    mainSev = [[MainpageServ alloc] init];
    mainSev.delegate = self;
    
    
    
    
    noorderlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, NowViewsHight)];
    noorderlabel.textAlignment = UITextAlignmentCenter;
    noorderlabel.text = @"您暂时没订单";
    
    [self.view addSubview:noorderlabel];
    
    [self createBandgeView];
    
}


-(void)createBandgeView{

    //lee999recode
//    JSBadgeView *badgeView = [[JSBadgeView alloc] initWithParentView:bandgeV1 alignment:JSBadgeViewAlignmentCenterRight];
//    badgeView.badgeText = bandgeNum2;
//    badgeView.badgeBackgroundColor = [UIColor colorWithHexString:@"#C60932"];
//    badgeView.badgeOverlayColor = [UIColor colorWithHexString:@"#C60932"];
//    badgeView.badgeOverlayColor = [UIColor colorWithHexString:@"#C60932"];
//
//    JSBadgeView *badgeView2 = [[JSBadgeView alloc] initWithParentView:bandgeV2 alignment:JSBadgeViewAlignmentCenterRight];
//    badgeView2.badgeText = bandgeNum1;
//    badgeView2.badgeBackgroundColor = [UIColor colorWithHexString:@"#C60932"];
//    badgeView2.badgeOverlayColor = [UIColor colorWithHexString:@"#C60932"];
//    badgeView2.badgeOverlayColor = [UIColor colorWithHexString:@"#C60932"];
    
    //lee999 我的爱慕——全部订单：没有订单时，不要显示气泡。
//    if ([bandgeNum2 intValue] == 0) {
//        badgeView.hidden = YES;
//    }
//    if ([bandgeNum1 intValue] == 0) {
//        badgeView2.hidden = YES;
//    }

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -- NetRequest delegate
-(void)serviceStarted:(ServiceType)aHandle{
}

-(void)serviceFailed:(ServiceType)aHandle{
    [SBPublicAlert hideMBprogressHUD:self.view];
}

-(void)serviceFinished:(ServiceType)aHandle withmodel:(id)amodel
{
    [SBPublicAlert hideMBprogressHUD:self.view];
    LBaseModel *model = (LBaseModel *)amodel;
    
    switch (model.requestTag) {
        case Http_Orders_Tag:
            if (!model.errorMessage) {
                [SBPublicAlert hideMBprogressHUD:self.view];
                
                orderModel = (OrdersOrdersModel *)model;

                if (current == 1) {
                    [contentArr removeAllObjects];
                    [contentArr addObjectsFromArray:(NSMutableArray *)orderModel.ordersList];
                }else {
                    
                    [contentArr addObjectsFromArray:(NSMutableArray *)orderModel.ordersList];
                }
                if (contentArr.count != 0) {
                    [noorderlabel setHidden:YES];
                }else{
                    [noorderlabel setHidden:NO];
                }
            
                totalCount = [orderModel.recordCount intValue];
                [self updateTableViewCount:contentArr.count];
                
                [tableList reloadData];
                
            }else{
                [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:2.0];
            }
            break;
            
        case Http_Makesuregetgood_Tag:{
            [SBPublicAlert showMBProgressHUD:@"恭喜您，已经确认收货" andWhereView:self.view hiddenTime:2.0];
            //lee999 确认收货之后，去订单详情。
            
            [SingletonState sharedStateInstance].isFromCheckOKView = NO;
            
            OrderDetailViewController *tempOrderDetail = [[OrderDetailViewController alloc] initWithNibName:@"OrderDetailViewController" bundle:nil];
            OrdersOrdersList *item = (OrdersOrdersList*)[contentArr objectAtIndex:selectTag];
            tempOrderDetail.isUnAccess = self.enterWhere;
            tempOrderDetail.orderID = item.orderid;
            tempOrderDetail.userName = userName;
            tempOrderDetail.isFromCar = NO;
            //lee999recode
            tempOrderDetail.isFromAimer = YES;
            [self.navigationController pushViewController:tempOrderDetail animated:YES];
            //end
        }
            break;
            
        case Http_TrdnoByOrderld_Tag: //银联支付返回流水号
        {
            if (!model.errorMessage) {
                [SBPublicAlert hideMBprogressHUD:self.view];
                
                [self UnpaybuttonClicked:mainSev.unpayTN];
                
            }else {
                [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:1.0];
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
    
    //lee999新增刷新界面
    if (isMakesureGetgood) {
//        [self getData]; //刷新数据
        isMakesureGetgood = NO;
    }
    
}

#pragma mark -- UITableViewdelegate and Datesource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return contentArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        //用户地址
        return [self tableView:tableList cellForRowAtIndexPath:indexPath].frame.size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cellIdentifier";
    OrderCell *orderCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (orderCell == nil) {
        orderCell = [[[NSBundle mainBundle] loadNibNamed:@"OrderCell" owner:self options:nil] lastObject];
    }
    orderCell.tag = [indexPath row];
    
    [orderCell setCellContent:[contentArr objectAtIndex:indexPath.row]];
    orderCell.selectionStyle = UITableViewCellSelectionStyleNone;
    orderCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return orderCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [SingletonState sharedStateInstance].isFromCheckOKView = NO;
    
    OrderDetailViewController *tempOrderDetail = [[OrderDetailViewController alloc] initWithNibName:@"OrderDetailViewController" bundle:nil];
    OrdersOrdersList *templist = [contentArr objectAtIndex:indexPath.row];
    tempOrderDetail.isUnAccess = self.enterWhere;
    tempOrderDetail.orderID = templist.orderid;
    tempOrderDetail.userName = userName;
    tempOrderDetail.isFromCar = NO;
    tempOrderDetail.isHiddenBar = YES;
    //lee999recode
    tempOrderDetail.isFromAimer = YES;
    //end
    [self.navigationController pushViewController:tempOrderDetail animated:YES];
}

#pragma mark 刷新的代理方法
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
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


#pragma mark 点击进行分类编辑
- (IBAction)orderBtnClick:(id)sender {
    
    UIButton *btn = (UIButton*)sender;
    switch (btn.tag) {
        case 100:
        {
            //全部
            self.title = @"我的订单";
            allkeyImg.hidden = NO;
            needpayImg.hidden = YES;
            needcommkeyImg.hidden = YES;
            needHandlekeyImg.hidden = YES;
            howEnter = 1;
            
            [allbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [needpayBtn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
            [needcommbtn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
            [needHandlebtn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
            
            [self getData];
        }
            break;
        case 101:
        {
            //待付款
            self.title = @"待付款";
            allkeyImg.hidden = YES;
            needpayImg.hidden = NO;
            needcommkeyImg.hidden = YES;
            needHandlekeyImg.hidden = YES;
            howEnter = 4;
            
            [allbtn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
            [needpayBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [needcommbtn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
            [needHandlebtn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
            
            [self getData];
            
       
        }
            break;
        case 102:
        {
            //待评价
            self.title = @"待评价";
            allkeyImg.hidden = YES;
            needpayImg.hidden = YES;
            needcommkeyImg.hidden = NO;
            needHandlekeyImg.hidden = YES;
            howEnter = 3;
            
            [allbtn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
            [needpayBtn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
            [needcommbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [needHandlebtn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
            
            [self getData];
        }
            break;
        case 103:
        {
            //待处理s
            self.title = @"待处理";
            allkeyImg.hidden = YES;
            needpayImg.hidden = YES;
            needcommkeyImg.hidden = YES;
            needHandlekeyImg.hidden = NO;
            howEnter = 2;
            
            [allbtn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
            [needpayBtn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
            [needcommbtn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
            [needHandlebtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            [self getData];
        }
            break;
            
        default:
            break;
    }

}


#pragma mark 刷新
-(void)getData
{
    current = 1;
    NSString *PageCurr = [NSString stringWithFormat:@"%ld",(long)current];
    
    switch (howEnter) {
        case 1://我的订单
            [mainSev getOrderlists:@"" andPage:PageCurr andPer_page:@"10"];
            [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
            self.enterWhere = NO;
            break;
        case 2://待处理
            [mainSev getOrderlists:@"nodispose" andPage:PageCurr andPer_page:@"10"];
            [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
            self.enterWhere = NO;
            break;
        case 3://待评价
            [mainSev getOrderlists:@"norates" andPage:PageCurr andPer_page:@"10"];
            [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
            self.enterWhere = YES;
            break;
        case 4://待付款
            [mainSev getOrderlists:@"nopay" andPage:PageCurr andPer_page:@"10"];
            [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
            self.enterWhere = YES;
            break;
        default:
            break;
    }
    
    [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
    
}

#pragma mark 加载
- (void)nextPage
{
    current ++;
    NSString *PageCurr = [NSString stringWithFormat:@"%ld",(long)current];
    
    switch (howEnter) {
        case 1://我的订单
            [mainSev getOrderlists:@"" andPage:PageCurr andPer_page:@"10"];
            [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
            self.enterWhere = NO;
            break;
        case 2://待处理
            [mainSev getOrderlists:@"nodispose" andPage:PageCurr andPer_page:@"10"];
            [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
            self.enterWhere = NO;
            break;
        case 3://待评价
            [mainSev getOrderlists:@"norates" andPage:PageCurr andPer_page:@"10"];
            [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
            self.enterWhere = YES;
            break;
        case 4://待付款
            [mainSev getOrderlists:@"nopay" andPage:PageCurr andPer_page:@"10"];
            [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
            self.enterWhere = YES;
            break;
        default:
            break;
    }
    
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


#pragma mark---  订单列表各个按钮的点击
-(IBAction)MyorderRed:(id)sender{
    UIButton *btn = (UIButton*)sender;
    
    selectTag = btn.tag;
    OrdersOrdersList *item = (OrdersOrdersList*)[contentArr objectAtIndex:selectTag];

    if ([btn.titleLabel.text isEqualToString:@"立即支付"]) {
        
        CGFloat xWidth = self.view.bounds.size.width - 20.0f;
        CGFloat yHeight = 272.0f-60.f;
        CGFloat yOffset = (self.view.bounds.size.height - yHeight)/2.0f;
        
        //lee999 适配高度
        OrdersOrdersList *item = (OrdersOrdersList*)[contentArr objectAtIndex:selectTag];
        NSArray *arrtype = item.itemAllowpaytype;
        if ([arrtype count] ==1) {
            yHeight = 90;
        }
        if ([arrtype count] ==2) {
            yHeight = 90+60;
        }
        if ([arrtype count] ==3) {
            yHeight = 90+120;
        }
        //end
        
        
        UIPopoverListView *poplistview = [[UIPopoverListView alloc] initWithFrame:CGRectMake(10, yOffset, xWidth, yHeight)];
        poplistview.delegate = self;
        poplistview.datasource = self;
        poplistview.listView.scrollEnabled = FALSE;
        [poplistview setTitle:@"立即支付"];
        [poplistview show];
        
    }
    if ([btn.titleLabel.text isEqualToString:@"确认收货"]) {
        
        UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"爱慕提示" message:@"请收到货品再操作哦，确认收货后可以去评价商品哟" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alertV.tag = 10099922;
        [alertV show];
    }
    if ([btn.titleLabel.text isEqualToString:@"评价"]) {
        
        CommOrderScrollViewController *accessCtrl = [[CommOrderScrollViewController alloc]init];
        accessCtrl.co_ID = item.orderid;
        [self.navigationController pushViewController:accessCtrl animated:YES];
    }
}

#pragma mark--- 查看物流
-(IBAction)MyorderGray:(id)sender{
    
    UIButton *btn = (UIButton*)sender;
    selectTag = btn.tag;
    OrdersOrdersList *item = (OrdersOrdersList*)[contentArr objectAtIndex:selectTag];

    //查看物流
    LogisticsViewController *tempLogistics = [[LogisticsViewController alloc] initWithNibName:@"LogisticsViewController" bundle:nil];
    tempLogistics.delivery_type = item.delivery_type;
    tempLogistics.expressid = item.expressid;
    [self.navigationController pushViewController:tempLogistics animated:YES];
}

#pragma mark-- Alert
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 10099922) {
        if (buttonIndex == 1) {
            OrdersOrdersList *item = (OrdersOrdersList*)[contentArr objectAtIndex:selectTag];
            [mainSev makesuregetgood:item.orderid];
            
            isMakesureGetgood = YES;
        }
    }
    
    
    //支付成功的回调 返回商城首页~~~~
    if (alertView.tag == 19998) {
        
        isGetNotice = NO;
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        [SingletonState sharedStateInstance].isNewHomePageScrollToTop = YES;
        [self changeToShop];
    }
}

#pragma mark - UIPopoverListViewDelegate  支付相关

- (UITableViewCell *)popoverListView:(UIPopoverListView *)popoverListView
                    cellForIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                   reuseIdentifier:identifier];
    
    OrdersOrdersList *item = (OrdersOrdersList*)[contentArr objectAtIndex:selectTag];
    YKAllowPayType *type = [item.itemAllowpaytype objectAtIndex:indexPath.row];
    //cell.textLabel.text = type.paytypeDesc;
    
    
    //lee999 150503 增加icon
    UIImage *img = [UIImage imageNamed:@"zf_cxk_.png"];
    UIImageView* imageV = [[UIImageView alloc] initWithFrame:CGRectMake(20, 12, img.size.width, img.size.height)];
    [cell addSubview:imageV];
    
    UILabel * nameLab = [[UILabel alloc] initWithFrame:CGRectMake(70, 14, 200, 30)];
    [nameLab setText:type.paytypeDesc];
    [cell addSubview:nameLab];
    
    switch (type.payid) {
        case 0:
        {
            //货到付款
            [imageV setImage:[UIImage imageNamed:@"zf_hdfk_.png"]];
        }
            break;
            
        case 1:
        {
            //支付宝
            [imageV setImage:[UIImage imageNamed:@"zf_zfb_.png"]];
        }
            break;
            
        case 2:
        {
            //[imageV setImage:[UIImage imageNamed:@"zf_zfb_.png"]];
        }
            break;
            
        case 3:
        {
            //银联支付
            [imageV setImage:[UIImage imageNamed:@"zf_cxk_.png"]];
        }
            break;
            
        case 4:
        {
            //微信
            [imageV setImage:[UIImage imageNamed:@"zf_wx_.png"]];
        }
            break;
            
        default:
            break;
    }

    return cell;
}

- (CGFloat)popoverListView:(UIPopoverListView *)popoverListView
   heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

- (NSInteger)popoverListView:(UIPopoverListView *)popoverListView
       numberOfRowsInSection:(NSInteger)section
{
    OrdersOrdersList *item = (OrdersOrdersList*)[contentArr objectAtIndex:selectTag];
    return [item.itemAllowpaytype count];
}

- (void)popoverListView:(UIPopoverListView *)popoverListView
     didSelectIndexPath:(NSIndexPath *)indexPath
{
    OrdersOrdersList *item = (OrdersOrdersList*)[contentArr objectAtIndex:selectTag];
    YKAllowPayType *type = [item.itemAllowpaytype objectAtIndex:indexPath.row];
    //支付宝
    if (type.payid ==1) {
        if (!isAddNotification) {
            isAddNotification = YES;
//            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideSeeButPay:) name:@"alipayOKanjumptoOrderDetail" object:nil];
        }
        
        [AlipayHelper alipayActionwithPrice:item.price
                                 andOrderid:item.orderid];
    }
    
    //微信支付
    if (type.payid ==4) {
        if (!isAddNotification) {
            isAddNotification = YES;
//            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideSeeButPay:) name:@"alipayOKanjumptoOrderDetail" object:nil];
        }
        
        if (![WXApi isWXAppInstalled]) {
            [LCommentAlertView showMessage:@"您还未安装微信，请换其他支付方式" target:nil];
            return;
        }
        
        [[WXPayClient shareInstance] payProductwithorderid:item.orderid Money:item.price];
    }
    
    //银联支付
    if (type.payid == 3) {
        
        [mainSev upmpTradno:item.orderid];

//        str_orderid = item.orderid;
//        [self UnpaybuttonClicked:nil];
    }
}





#pragma mark =======银联支付的相关事件
- (void)UnpaybuttonClicked:(NSString*)sender{
    
    NSLog(@"-交易流水号---%@",sender);
    
  if (sender && ![@"" isEqualToString:sender]) {
        //交易流水号   @"00":代表接入生产环境  @"01":代表接入开发测试环境
        [UPPayPlugin startPay:sender mode:@"00" viewController:self delegate:self];
  }
}

- (void)UPPayPluginResult:(NSString *)result
{
    //支付成功后 调用客户端服务器 提示服务器支付成功的信息
    if ([result isEqualToString:@"success"]) {
//        [mainSev getLinkageconfirmpay:str_orderid];
        
        [self hideSeeButPay:nil];
        
    }else if ([result isEqualToString:@"fail"]){
        [SBPublicAlert showAlertTitle:@"爱慕提示" Message:@"支付失败"];
    }else if ([result isEqualToString:@"cancel"]){
        [SBPublicAlert showAlertTitle:@"爱慕提示" Message:@"用户中途取消"];
    }else{
//        [SBPublicAlert showAlertTitle:@"爱慕提示" Message:@"支付失败"];
    }
}

#pragma mark----- 支付成功之后跳转到商城首页
- (void)hideSeeButPay:(NSNotification *)notion {
    
    if ([SingletonState sharedStateInstance].alipayisShowAlert == YES && [SingletonState sharedStateInstance].isInCheckOKView == NO) {
        [SingletonState sharedStateInstance].alipayisShowAlert = NO;
    UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"支付成功" message:@"更多漂亮宝贝等你挑选，再去逛逛吧！" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles: nil];
    alertV.tag = 19998;
    [alertV show];
    }
}

#pragma mark -- 屏幕旋转
//iOS 5
- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}
//iOS 6
- (BOOL)shouldAutorotate
{
	return NO;
}
- (NSUInteger)supportedInterfaceOrientations
{
	return UIInterfaceOrientationMaskPortrait;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
	return UIInterfaceOrientationPortrait;
}
@end
