//
//  OrderDetailViewController.m
//  MySuperApp
//
//  Created by LEE on 14-4-5.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "OrderMessageCell.h"
#import "HeadOrderCell.h"
#import "ProductListCell.h"
#import "AddressOrderCell.h"
#import "OrderEndCell.h"
#import "CancelOrderViewController.h"
#import "AlipayHelper.h"

#import "LogisticsViewController.h"
#import "AccessViewController.h"

#import "CommOrderScrollViewController.h"

#import "ProductDetailViewController.h"
#import "YKPreferentialSuit.h"

#import "BlockAlertView.h"
#import "AlipayHelper.h"
#import "WXPayClient.h"

#import "OrderpaynowEndCell.h"
#import "UIPopoverListView.h"

#import "UIImage+ImageSize.h"

#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#import "UPPayPlugin.h"


@interface OrderDetailViewController () {
    
    NSInteger four;
    NSInteger five;
    NSInteger six;
    NSInteger seven;
    
    UIView *viewBg;
    
    BOOL isMakesureGetgood;  //是否点击了确认收货
    
    BOOL isGetNotice;  //是否得到通知消息   lee999 150120
    BOOL isAddNotification;  //是否添加观察者

    OrderpaynowEndCell *endCell2;
}

@end

@implementation OrderDetailViewController
@synthesize orderID;
@synthesize isUnAccess;
@synthesize isFromCar;
@synthesize isOrderPayOK; //是否支付成功
@synthesize isHiddenBar;
@synthesize isFromAimer;

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
    
    self.title = @"订单详情";

    
    isGetNotice = NO;
    isAddNotification = NO;
    
    if (isOrderPayOK&&isFromCar) {
        //如果是支付成功了的话。进来之后要返回到  商城首页
        [self createBackBtnWithType:799];
    }else{
        [self createBackBtnWithType:0];
    }
    
    
    [SingletonState sharedStateInstance].isInCheckOKView = NO;


    mainSev = [[MainpageServ alloc] init];
    mainSev.delegate = self;
    
    
    _suitlistcell = [[NSMutableArray alloc] init];

    [tableList setFrame:CGRectMake(0, 0, ScreenWidth, self.view.frame.size.height)];
    
    endCell2 = [[[NSBundle mainBundle] loadNibNamed:@"OrderpaynowEndCell" owner:self options:nil] lastObject];
    
    tableList.hidden = YES;
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideSeeButPay:) name:@"alipayOKanjumptoOrderDetail" object:nil];
    [SingletonState sharedStateInstance].alipayisShowAlert = YES;
    
//    if (isIOS7up) {
//        [tableList setFrame:CGRectMake(0, 0, ScreenWidth, self.view.frame.size.height)];
//    }
    
    //lee999
    if ([SingletonState sharedStateInstance].isFromCheckOKView == YES) {
//        AppDelegate* app = (AppDelegate*)[UIApplication sharedApplication].delegate;
//        [app.aktabBarVerticalController hideTabBar:AKShowHideFromLeft animated:YES];
    }
    //end
    
    [mainSev getOrderdetail:self.orderID];
    [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
}


-(void)viewWillDisappear:(BOOL)animated{
    //显示footview
    
    isAddNotification = NO;
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"alipayOKanjumptoOrderDetail" object:nil];
    
    
    //lee999recode增加了|| !isHiddenBar
    //lee999recode
//    if (isFromCheckOKView || !isHiddenBar) {
//    AppDelegate* app = (AppDelegate*)[UIApplication sharedApplication].delegate;
//    [app.aktabBarVerticalController showTabBar:AKShowHideFromLeft animated:YES];
//    }
}

#pragma mark -- 按钮事件  银联支付后的回调

//银联支付后的回调
//- (void)onPayResult:(NSString*)orderId resultCode:(NSString*)resultCode resultMessage:(NSString*)resultMessage{
//    //支付成功后 调用客户端服务器 提示服务器支付成功的信息
//
//    if ([resultCode isEqualToString:@"0000"]) {
//        [mainSev getLinkageconfirmpay:self.orderID];
//    }else {
//        [SBPublicAlert showAlertTitle:@"爱慕提示" Message:resultMessage];
//    }
//}

#pragma mark--  立即支付
-(void)rightButAction//立即支付
{
    CGFloat xWidth = self.view.bounds.size.width - 20.0f;
    CGFloat yHeight = 272.0f-60.f;
    CGFloat yOffset = (self.view.bounds.size.height - yHeight)/2.0f;
    
    
    //lee999 适配高度
    NSLog(@"支付按钮的个数是：----%ld",(unsigned long)[orderDetail.itemAllowpaytype count]);
    if ([orderDetail.itemAllowpaytype count] ==1) {
        yHeight = 90;
    }
    if ([orderDetail.itemAllowpaytype count] ==2) {
        yHeight = 90+60;
    }
    if ([orderDetail.itemAllowpaytype count] ==3) {
        yHeight = 90+120;
    }
    //end
    
    UIPopoverListView *poplistview = [[UIPopoverListView alloc] initWithFrame:CGRectMake(10, yOffset, xWidth, yHeight)];
    poplistview.delegate = self;
    poplistview.datasource = self;
    poplistview.listView.scrollEnabled = FALSE;
    [poplistview setTitle:@"支付方式"];
    [poplistview show];
}

#pragma mark - 支付相关

- (UITableViewCell *)popoverListView:(UIPopoverListView *)popoverListView
                    cellForIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                   reuseIdentifier:identifier];
    
    YKAllowPayType *type = [orderDetail.itemAllowpaytype objectAtIndex:indexPath.row];
//    cell.textLabel.text = type.paytypeDesc;
    
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
    return [orderDetail.itemAllowpaytype count];
}

- (void)popoverListView:(UIPopoverListView *)popoverListView
     didSelectIndexPath:(NSIndexPath *)indexPath
{
    YKAllowPayType *type = [orderDetail.itemAllowpaytype objectAtIndex:indexPath.row];
    //支付宝
    if (type.payid ==1) {
        
        if (!isAddNotification) {
            isAddNotification  = YES;
//            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideSeeButPay:) name:@"alipayOKanjumptoOrderDetail" object:nil];
        }
        
        [AlipayHelper alipayActionwithPrice:orderDetail.orderdetailInfo.price
                                 andOrderid:self.orderID];
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
        
        [[WXPayClient shareInstance] payProductwithorderid:self.orderID Money:orderDetail.orderdetailInfo.price];
    }
    
    //银联支付
    if (type.payid == 3) {
        
        //lee999
        [mainSev upmpTradno:self.orderID];
    }
}

#pragma mark =======银联支付的相关事件
- (void)UnpaybuttonClicked:(NSString*)sender{
    
    
    NSLog(@"-交易流水号---%@",sender);
    
    if (sender && ![@"" isEqualToString:sender]) {
        
        [self hiddenFooterwithAnimated:NO];
        //交易流水号   @"00":代表接入生产环境  @"01":代表接入开发测试环境
        [UPPayPlugin startPay:sender mode:@"00" viewController:self delegate:self];
    }
}
- (void)UPPayPluginResult:(NSString *)result
{
    //支付成功后 调用客户端服务器 提示服务器支付成功的信息
    if ([result isEqualToString:@"success"]) {
//        [mainSev getLinkageconfirmpay:self.orderID];
        
        [self hideSeeButPay:nil];
        
    }else if ([result isEqualToString:@"fail"]){
        [SBPublicAlert showAlertTitle:@"爱慕提示" Message:@"支付失败"];
    }else if ([result isEqualToString:@"cancel"]){
        [SBPublicAlert showAlertTitle:@"爱慕提示" Message:@"用户中途取消"];
    }else{
//        [SBPublicAlert showAlertTitle:@"爱慕提示" Message:@"支付失败"];
    }
}

- (void)hideSeeButPay:(NSNotification *)notion {
    
    [mainSev getConfim_alipay:self.orderID];
    
    
    
    //lee999 支付成功之后 刷新界面，
//    isMakesureGetgood = YES;
    
    
//    if (isFromCheckOKView) {
//        [self.navigationController popToRootViewControllerAnimated:YES];
//    }else{
    
    //
    
    if ([SingletonState sharedStateInstance].alipayisShowAlert == YES && [SingletonState sharedStateInstance].isInCheckOKView == NO ) {
        [SingletonState sharedStateInstance].alipayisShowAlert = NO;
        UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"支付成功" message:@"更多漂亮宝贝等你挑选，再去逛逛吧！" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles: nil];
        alertV.tag = 19998;
        [alertV show];
    }
        
    
//    }
}

#pragma mark-- 取消订单 & 物流查询 & 支付订单 & 评价订单
- (IBAction)OrderdetailBtnAciton:(UIButton *)sender
{
    if (sender.tag == 6) {
        //取消订单
        if (orderDetail.iscancle) {
            CancelOrderViewController *tempCancel = [[CancelOrderViewController alloc] initWithNibName:@"CancelOrderViewController" bundle:nil];
            tempCancel.isCar = self.isFromCar;
            tempCancel.orderid = self.orderID;
            tempCancel.userName = self.userName;
            tempCancel.payWay = orderDetail.orderdetailInfo.payway;
            [self.navigationController pushViewController:tempCancel animated:YES];

        }else{
            [SBPublicAlert showAlertTitle:@"订单已关闭，不能取消" Message:nil];
        }
        
    }
    else if (sender.tag == 1){
        //查看物流
        LogisticsViewController *tempLogistics = [[LogisticsViewController alloc] initWithNibName:@"LogisticsViewController" bundle:nil];
        tempLogistics.delivery_type = orderDetail.orderdetailInfo.deliveryType;
        tempLogistics.expressid = orderDetail.orderdetailInfo.expressid;
        [self.navigationController pushViewController:tempLogistics animated:YES];
    }
    else if (sender.tag == 1000001){
        //支付
        [self rightButAction];
    }
    else if (sender.tag == 1000002){
        //评价
        CommOrderScrollViewController *accessCtrl = [[CommOrderScrollViewController alloc]init];
        accessCtrl.co_ID = self.orderID;
        [self.navigationController pushViewController:accessCtrl animated:YES];
    }
    else if (sender.tag == 1000003){
        //确认收货
        UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"爱慕提示" message:@"请收到货品再操作哦，确认收货后可以去评价商品哟" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alertV.tag = 10099922;
        [alertV show];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 10099922) {
        if (buttonIndex == 1) {
            [mainSev makesuregetgood:self.orderID];
            isMakesureGetgood = YES;
        }
    }
    
    
    //支付成功的回调 返回商城首页~~~~
    if (alertView.tag == 19998) {

        [self.navigationController popToRootViewControllerAnimated:YES];
        
        [SingletonState sharedStateInstance].isNewHomePageScrollToTop = YES;
        [self changetableBarto:0];
        
//        isGetNotice = NO;
//        if ([SingletonState sharedStateInstance].isFromCheckOKView == YES) {
//            
//            [self.navigationController popToRootViewControllerAnimated:NO];
//            
//            
//            AppDelegate* app = (AppDelegate*)[UIApplication sharedApplication].delegate;
//            [app.aktabBarVerticalController showTabBar:AKShowHideFromLeft animated:NO];
//            [SingletonState sharedStateInstance].isFromCheckOKView = NO;
//            
//            UIViewController *vc4 = [app.aktabBarVerticalController.viewControllers objectAtIndex:4];
//            if (app.aktabBarVerticalController.selectedViewController != vc4)
//            {
//                if ([vc4 isKindOfClass:[UINavigationController class]])
//                    [(UINavigationController *)vc4 popToRootViewControllerAnimated:NO];
//            }
//            
//            UIViewController *vc = [app.aktabBarVerticalController.viewControllers objectAtIndex:0];
//            if (app.aktabBarVerticalController.selectedViewController != vc)
//            {
//                if ([vc isKindOfClass:[UINavigationController class]])
//                    [(UINavigationController *)vc popToRootViewControllerAnimated:NO];
//            }
//            
//            [self changetableBarto:0];
//        }else{
//            [self changeToShop];
//        }
    }
    
}


#pragma mark 创建立即支付的浮动条
-(void)createPayBar{

    //lee999 让按钮固定在底部
    endCell2.laborderPrice.text = [NSString stringWithFormat:@"￥%@",orderDetail.orderdetailInfo.price];
    CGRect oldframe = endCell2.frame;
    oldframe.origin.y = self.view.frame.size.height - oldframe.size.height+3;
    [endCell2 setBackgroundColor:[UIColor whiteColor]];
    [endCell2 setFrame:oldframe];
    
    CGRect oldframe2 = CGRectMake(0, 0, ScreenWidth, self.view.frame.size.height);
    oldframe2.size.height = oldframe2.size.height - endCell2.frame.size.height;
    [tableList setFrame:oldframe2];
    
    if ([orderDetail.orderdetailInfo.orer_status isEqualToString:@"立即支付"]) {
        endCell2.buttonLogistics.tag = 1000001;
    }
    if ([orderDetail.orderdetailInfo.orer_status isEqualToString:@"评价"]) {
        endCell2.buttonLogistics.tag = 1000002;
        
//        //lee999 注释掉，这个地方不用评论
//        endCell2.buttonLogistics.hidden = YES;
//        //end
        
        [endCell2.buttonLogistics setTitle:@"评价" forState:UIControlStateNormal];
        [endCell2.buttonLogistics setTitle:@"评价" forState:UIControlStateHighlighted];
    }
    if ([orderDetail.orderdetailInfo.orer_status isEqualToString:@"确认收货"]) {
        endCell2.buttonLogistics.tag = 1000003;
        [endCell2.buttonLogistics setTitle:@"确认收货" forState:UIControlStateNormal];
        [endCell2.buttonLogistics setTitle:@"确认收货" forState:UIControlStateHighlighted];
    }
    [self.view addSubview:endCell2];
    
    //lee999增加判断 如果是已经取消的订单 就不显示这个按钮
    if (!orderDetail.isshowpaybar) {
        endCell2.hidden = YES;
        //恢复table为原来的高度
        [tableList setFrame:CGRectMake(0, 0, ScreenWidth, self.view.frame.size.height)];
    }
}

#pragma mark -- net request delegate
-(void)serviceStarted:(ServiceType)aHandle{
}

-(void)serviceFailed:(ServiceType)aHandle{
    [SBPublicAlert hideMBprogressHUD:self.view];
    
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"爱慕提示" message:@"网络异常，请您重试。" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles: nil];
    alert.tag=332111111;
    [alert show];
    
    
}

-(void)serviceFinished:(ServiceType)aHandle withmodel:(id)amodel{
    
    [SBPublicAlert hideMBprogressHUD:self.view];
    LBaseModel *model = (LBaseModel *)amodel;
    
    tableList.hidden = NO;
    
    switch (model.requestTag) {
        case Http_Orderdetail_Tag:
            if (!model.errorMessage) {
                
                [viewBg removeFromSuperview];
                
                [SBPublicAlert hideMBprogressHUD:self.view];
                orderDetail = (OrderInfoOrderInfoModel *)model;
                
                NSDictionary *dic1  = [NSDictionary dictionaryWithObjectsAndKeys:orderDetail.orderdetailReceiveinfo.name, @"UserName",self.orderID, @"CoId",orderDetail.orderdetailInfo.price, @"Coprice",orderDetail.orderdetailInfo.payway, @"Payment",[NSNumber numberWithInt:[orderDetail.itemList count] + [orderDetail.itemSuit count]], @"Number",nil];
                [TalkingData trackEvent:@"5011" label:@"订单详情" parameters:dic1];

                //lee999 创建套装cell
                [self createSuitlistcells];

                NSLog(@"---expressid:--------%lu",(unsigned long)orderDetail.orderdetailInfo.expressid.length);
                
                
                [tableList reloadData];
                
                //lee999 创建浮动条
//                if (endCell2) {
//                    [endCell2 removeFromSuperview];
//                }
                [self createPayBar];
                //end
                
            }else{
                [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:0.6];
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
        [mainSev getOrderdetail:self.orderID]; //刷新数据
        isMakesureGetgood = NO;
    }
}

#pragma mark --  UITableView delegate and datesource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    if (isUnAccess) {
//            return orderDetail.itemSuit.count+1;
//    }else
    {
        if (orderDetail.iscancle) {
            return 8+orderDetail.itemSuit.count +1; //lee999 在这个地方加1，为了在最后显示 查看物流按钮
        }else {
            return 7+orderDetail.itemSuit.count +1;
        }
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (isUnAccess) {
//        if (0 == section) {
//            return orderDetail.itemList.count;
//        }else {
//            YKSuitListItem *suitListItem = (YKSuitListItem *)[orderDetail.itemSuit objectAtIndex:section-1];
//            return  [[suitListItem suits] count] +1; //lee999 加了1 为了显示套装的总计信息
//        }
//    }else
    {
        
        if (orderDetail.itemSuit.count == 0) {
            four = 4 + orderDetail.itemSuit.count;
            five = 5 + orderDetail.itemSuit.count;
            six = 6 +  orderDetail.itemSuit.count;
            seven = 7+ orderDetail.itemSuit.count;
        }else {
            four = 3 + orderDetail.itemSuit.count;
            five = 4 + orderDetail.itemSuit.count;
            six = 5 +  orderDetail.itemSuit.count;
            seven = 6+ orderDetail.itemSuit.count;
        }
        
        if (section == 0) {
            //这里是头信息
             return 2;
        }else if (section == 1) {
            //这里是显示 是否有查看物流按钮
            if (orderDetail.orderdetailInfo.expressid.length>1) {
                return 1;
            }else{
                return 0;
            }
        }else if (section == 2) {
            //这里是普通商品列表
            if (orderDetail.itemList.count == 0) {
                return 1;
            }else{
                return orderDetail.itemList.count + 1;
            }
        }
        else if (section == four) {
            return 2;
        }else if (section == five) {
            return 2;
        }else if (section == six) {
            
            //lee999 增加COD订单 取消按钮
            if (!orderDetail.iscancle) {
                return 0;
            }else{
                return 1;
            }
            //lee999
            
            if (!orderDetail.ispay) {
                return 0;
            }else{
                return 1;
            }
        }else if (section == seven) {
            //lee999 将查看物流按钮，移动到最后一行9999999
//            if (!orderDetail.iscancle) {
//                return 0;
//            }else{
//                return 1;
//            }
            if (orderDetail.orderdetailInfo.expressid.length>1) {
                return 1;
            }else{
                return 0;
            }
            
        }else if (section >= 3&&section <four) {
            //这里是套装
            if (orderDetail.itemSuit.count == 0) {
                return 0;
            }else{
                YKSuitListItem *suitListItem = (YKSuitListItem *)[orderDetail.itemSuit objectAtIndex:section-3];
                if (orderDetail.itemList.count == 0) {
                    return [[suitListItem suits] count]+1; //lee999 加了1 为了显示套装的总计信息
                }else{
                    return  [[suitListItem suits] count]+1; //lee999 加了1 为了显示套装的总计信息
                }
            }
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (isUnAccess) {
//        //未评价
//        static NSString *unAccessID = @"unaccessIdentifier";
//        ProductListCell *listCell = [tableView dequeueReusableCellWithIdentifier:unAccessID];
//        if (listCell == nil) {
//            listCell = [[[NSBundle mainBundle] loadNibNamed:@"ProductListCell" owner:self options:nil] lastObject];
//        }
//        listCell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//        NSLog(@"%d",indexPath.row);
//        if (0 == indexPath.section) {
//            YKItem *productList = (YKItem *)[orderDetail.itemList objectAtIndex:indexPath.row];
//            [listCell.imageViewCommodity setImageFromUrl:YES withUrl:productList.imgurl];
//            [listCell.imageViewCommodity setImageWithURL:[NSURL URLWithString:productList.imgurl] placeholderImage:[UIImage imageNamed:@"pic_default_product_list_02.png"]];
//            
//            
//            listCell.labelIntroduce.text = productList.name;
//            listCell.labelColor.text = productList.color;
//            listCell.labelNum.text = productList.number;
//            listCell.labelSize.text = productList.size;
//            listCell.labelPrice.text = [NSString stringWithFormat:@" ￥%.2f", [productList.price floatValue]];
//            
//            listCell.labelTotal.hidden = YES;
//            listCell.labelTextTotal.hidden = YES;
//            listCell.buttonAccess.tag = indexPath.row+5000;
//            
////            [listCell.buttonAccess addTarget:self action:@selector(evaluateProduct:) forControlEvents:UIControlEventTouchUpInside];
//            
//            if (productList.rate_flag) {
//                listCell.buttonAccess.hidden = NO;
//            }else{
//                listCell.buttonAccess.hidden = YES;
//            }
//            //lee999 隐藏评论按钮
//            listCell.buttonAccess.hidden = YES;
//            
//            //end
//            return listCell;
//
//        }else {
//            //lee999 这里是套装的cell
//            return [[self.suitlistcell objectAtIndex:indexPath.section-1] objectAtIndex:indexPath.row];
//        }
//    }else{
    {
        static NSString *idenEnd = @"IdentifierEnd";
        static NSString *idenOrderMessage = @"IdentifierMessage";
        static NSString *idenProductList = @"IdentifierProductList";
        static NSString *idenAddress = @"IdentifierAddress";
        static NSString *idenHeadOrder = @"IdentifierHeadOrder";
        
        if (indexPath.section == 0) {
            if (indexPath.row != 0) {
                //lee999  这个是头信息
               OrderMessageCell* messageCellhead = [tableView dequeueReusableCellWithIdentifier:idenOrderMessage];
                //end
                
                if (messageCellhead == nil) {
                    messageCellhead = [[[NSBundle mainBundle] loadNibNamed:@"OrderMessageCell" owner:self options:nil] lastObject];
                }
                
                messageCellhead.labelOrderNum.text =[self objectOrNil:self.orderID];
                messageCellhead.labelStatus.text = [self objectOrNil:orderDetail.orderdetailInfo.status];
                messageCellhead.labelPayMode.text = [self objectOrNil:orderDetail.orderdetailInfo.payway];
                messageCellhead.labelFare.text = [NSString stringWithFormat:@"￥%@",[self objectOrNil:orderDetail.orderdetailInfo.freight]];
                messageCellhead.labelCouponMoney.text = [NSString stringWithFormat:@"￥%@",[self objectOrNil:orderDetail.orderdetailInfo.discountprice]];
                messageCellhead.labelCouponMessage.text = orderDetail.orderdetailInfo.discountdes;
                //电子劵抵扣
                messageCellhead.labelDemicMessage.text = [NSString stringWithFormat:@"￥%@",[self objectOrNil:orderDetail.orderdetailInfo.eticket]];
                messageCellhead.labelOrderMoney.text = [NSString stringWithFormat:@"￥%@",[self objectOrNil:orderDetail.orderdetailInfo.price]];
                
                //lee999 新增属性
                messageCellhead.labordertime.text = orderDetail.orderdetailInfo.ordertime;
                NSString *sendtype = orderDetail.orderdetailInfo.expresscorn;
                messageCellhead.labsendtype.text = orderDetail.orderdetailInfo.expresscorn;
                if (sendtype.length<1) {
                   messageCellhead.labsendtype.text = @"无";
                }
                messageCellhead.laborderallprice.text = [NSString stringWithFormat:@"￥%@",orderDetail.orderdetailInfo.co_price];
                messageCellhead.labgetscore.text = [NSString stringWithFormat:@"%d",[orderDetail.orderdetailInfo.co_score intValue]];

                
                NSLog(@"订单详情里面，按钮的状态：------%@",orderDetail.orderdetailInfo.orer_status);
                //lee999  增加不同的判断按钮
                if (orderDetail.orderdetailInfo.orer_status.length>1) {
                    if ([orderDetail.orderdetailInfo.orer_status isEqualToString:@"立即支付"]) {
                        [messageCellhead.paynowBtn setTitle:@"立即支付" forState:UIControlStateNormal];
                        [messageCellhead.paynowBtn setTitle:@"立即支付" forState:UIControlStateHighlighted];
                        messageCellhead.paynowBtn.tag = 1000001;

                    }
                    if ([orderDetail.orderdetailInfo.orer_status isEqualToString:@"评价"]) {
                        messageCellhead.paynowBtn.tag = 1000002;
                        
                        //lee999 隐藏评价按钮
//                        messageCellhead.paynowBtn.hidden = YES;
                        //end
                        
                        [messageCellhead.paynowBtn setTitle:@"评价" forState:UIControlStateNormal];
                        [messageCellhead.paynowBtn setTitle:@"评价" forState:UIControlStateHighlighted];
                    }
                    if ([orderDetail.orderdetailInfo.orer_status isEqualToString:@"确认收货"]) {
                        messageCellhead.paynowBtn.tag = 1000003;
                        [messageCellhead.paynowBtn setTitle:@"确认收货" forState:UIControlStateNormal];
                        [messageCellhead.paynowBtn setTitle:@"确认收货" forState:UIControlStateHighlighted];
                    }
                }else{
                    messageCellhead.paynowBtn.hidden = YES;
                }
                
//                if ([orderDetail.orderdetailInfo.orer_status isEqualToString:@"立即支付"]) {
//                    messageCellhead.paynowBtn.tag = 1000001;
//                }
//                if ([orderDetail.orderdetailInfo.orer_status isEqualToString:@"评价"]) {
//                    messageCellhead.paynowBtn.tag = 1000002;
//                    [messageCellhead.paynowBtn setTitle:@"评价" forState:UIControlStateNormal];
//                    [messageCellhead.paynowBtn setTitle:@"评价" forState:UIControlStateHighlighted];
//                }
//                
//                if (orderDetail.ispay) {
//                    messageCellhead.paynowBtn.hidden = NO;
//                }else{
//                    messageCellhead.paynowBtn.hidden = YES;
//                }
                //end
                
                messageCellhead.selectionStyle = UITableViewCellSelectionStyleNone;
                return messageCellhead;
            }

        }else if (indexPath.section == 1)
        {
            OrderEndCell *endCell = [tableView dequeueReusableCellWithIdentifier:idenEnd];
            if (endCell == nil) {
                endCell = [[[NSBundle mainBundle] loadNibNamed:@"OrderEndCell" owner:self options:nil] lastObject];
            }
                [endCell setImageAndTitlewithRow:indexPath.section andBool:0];
            if (orderDetail.orderdetailInfo.expressid&&orderDetail.orderdetailInfo.deliveryType) {
                endCell.buttonLogistics.hidden = NO;
            }else {
                endCell.buttonLogistics.hidden = YES;
            }
            
            endCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return endCell;
        
        } else if (indexPath.section == 2) {
            //lee999 这里是普通商品列表
            if (indexPath.row != 0) {
                ProductListCell *productCell = [tableView dequeueReusableCellWithIdentifier:idenProductList];
                if (productCell == nil) {
                    productCell = [[[NSBundle mainBundle] loadNibNamed:@"ProductListCell" owner:self options:nil] lastObject];
                }
                if (orderDetail.itemList.count > 0) {
                    YKItem *productList = (YKItem *)[orderDetail.itemList objectAtIndex:indexPath.row - 1];
                    [productCell.imageViewCommodity setImageFromUrl:YES withUrl:productList.imgurl];
                    productCell.labelIntroduce.text = productList.name;
                    //lee999 变为两行
                    productCell.labelIntroduce.numberOfLines = 2;
                    //end
                    productCell.labelColor.text = productList.color;
                    productCell.labelNum.text = productList.number;
                    productCell.labelSize.text = productList.size;
                    productCell.labelPrice.text = [NSString stringWithFormat:@" ￥%.2f", [productList.price floatValue]];
                    
//                    productCell.labelPrice.text = [NSString stringWithFormat:@" ￥%.2f", [productList.mkt_price floatValue]];

                    //lee999 增加积分label
//                    productCell.labelTotal.text =[NSString stringWithFormat:@"%d",productList.score];
                    //lee999 增加赠品icon的显示
                    if ([productCell.labelPrice.text isEqualToString:@" ￥0.00"]) {
                        [productCell.iconImagV setImage:[UIImage imageNamed:@"icon_gift.png"]];
                    }
                    //end
                    productCell.buttonAccess.tag = indexPath.row+5000;
//                    [productCell.buttonAccess addTarget:self action:@selector(evaluateProduct:) forControlEvents:UIControlEventTouchUpInside];//我要评价
                    productCell.buttonAccess.hidden = YES;

                }
            
                productCell.selectionStyle = UITableViewCellSelectionStyleNone;
                return productCell;
            }


        }else if (indexPath.section == four) {

            //这个是地址

            if (indexPath.row != 0) {
                AddressOrderCell *addressCell = [tableView dequeueReusableCellWithIdentifier:idenAddress];
                if (addressCell == nil) {
                    addressCell = [[[NSBundle mainBundle] loadNibNamed:@"AddressOrderCell" owner:self options:nil] lastObject];
                }
                
                addressCell.labelName.text = orderDetail.orderdetailReceiveinfo.name;
                
                NSString *str = orderDetail.orderdetailReceiveinfo.province;
                NSString *str2 = orderDetail.orderdetailReceiveinfo.city;
                NSString *str3 = orderDetail.orderdetailReceiveinfo.area;
                NSString *str4 = orderDetail.orderdetailReceiveinfo.detail;
                
                
                addressCell.labelAddress.text = [NSString stringWithFormat:@"%@ %@%@%@",[self objectOrNil:str],[self objectOrNil:str2],[self objectOrNil:str3],[self objectOrNil:str4]];
                
                addressCell.labelPhone.text = orderDetail.orderdetailReceiveinfo.mobilephone;
                
                addressCell.selectionStyle = UITableViewCellSelectionStyleNone;
                return addressCell;
            }else{
                HeadOrderCell *headCell = [tableView dequeueReusableCellWithIdentifier:idenHeadOrder];
                if (headCell == nil) {
                    headCell = [[[NSBundle mainBundle] loadNibNamed:@"HeadOrderCell" owner:self options:nil] lastObject];
                }
                
                headCell.backgroundColor = [UIColor clearColor];
                headCell.labelHead.text = @"收货人信息";
                headCell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                return headCell;
            }

        }else if (indexPath.section == five) {
            
            //lee999 这里是订单留言
            
            if (indexPath.row != 0) {
                
                UITableViewCell *messageCell =[[[NSBundle mainBundle] loadNibNamed:@"MessageCell" owner:self options:nil] lastObject];
                textViewLeaveWords.text = orderDetail.orderdetailInfo.remarskmsg;
                messageCell.selectionStyle = UITableViewCellSelectionStyleNone;
                return messageCell;
            }else {
                HeadOrderCell *headCell = [tableView dequeueReusableCellWithIdentifier:idenHeadOrder];
                if (headCell == nil) {
                    headCell = [[[NSBundle mainBundle] loadNibNamed:@"HeadOrderCell" owner:self options:nil] lastObject];
                }
                
                headCell.backgroundColor = [UIColor clearColor];
                headCell.labelHead.text = @"订单附言";
                headCell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                return headCell;
            }
        }else if (indexPath.section == six ){
            
            //lee999 取消订单按钮
            
            OrderEndCell *endCell = [tableView dequeueReusableCellWithIdentifier:idenEnd];
            if (endCell == nil) {
                endCell = [[[NSBundle mainBundle] loadNibNamed:@"OrderEndCell" owner:self options:nil] lastObject];
            }
            [endCell setImageAndTitlewithRow:indexPath.section andBool:orderDetail.itemSuit.count];
            endCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return endCell;
        }else if (indexPath.section == seven) {
            
            //lee999 将查看物流按钮，移动到最后
            OrderEndCell *endCell = [tableView dequeueReusableCellWithIdentifier:idenEnd];
            if (endCell == nil) {
                endCell = [[[NSBundle mainBundle] loadNibNamed:@"OrderEndCell" owner:self options:nil] lastObject];
            }
            [endCell setImageAndTitlewithRow:999222 andBool:orderDetail.itemSuit.count];
            
            if (orderDetail.orderdetailInfo.expressid.length < 1) {
                endCell.buttonLogistics.hidden = YES;
            }
            endCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return endCell;
            //end

        } else  if (indexPath.section >=3&&indexPath.section <four) {
            
            //lee999 这里是套装cell
            
            ProductListCell *productCell = [tableView dequeueReusableCellWithIdentifier:idenProductList];
            if (productCell == nil) {
                productCell = [[[NSBundle mainBundle] loadNibNamed:@"ProductListCell" owner:self options:nil] lastObject];
            }
            if (orderDetail.itemSuit.count > 0) {
                
                //lee999 修改套装的UI
                NSInteger sectionRow = indexPath.section -3;
                
                return [[self.suitlistcell objectAtIndex:sectionRow] objectAtIndex:indexPath.row];
            }
            productCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return productCell;
        }
        
        if ((indexPath.section == 0 || indexPath.section == 2 || indexPath.section == four) && indexPath.row == 0 ){
            HeadOrderCell *headCell = [tableView dequeueReusableCellWithIdentifier:idenHeadOrder];
            if (headCell == nil) {
                headCell = [[[NSBundle mainBundle] loadNibNamed:@"HeadOrderCell" owner:self options:nil] lastObject];
            }
            
            headCell.backgroundColor = [UIColor clearColor];
            [headCell setName:indexPath.section andBool:orderDetail.itemSuit.count];
            headCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return headCell;
        }
    }
    return nil;
}

- (NSString *)objectOrNil:(NSString *)_str {
    
    return _str == nil?@"":_str;;
}


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (isUnAccess) {
//        if (indexPath.section == 0) {
//            if (orderDetail.itemList == 0) {
//                return 0;
//            }
//        }else {
//            //lee999
//            YKSuitListItem *suitListItem = (YKSuitListItem *)[orderDetail.itemSuit objectAtIndex:indexPath.section-1];
//            if (indexPath.row == [[suitListItem suits] count] +1) {
//                return 60;
//            }
//            //end
//            //商品列表
//            return 160;
//        }
//        
//        return 160;
//    }else
    {

        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                return 23;
            }else
            {
                //lee999 新增高度  修改订单信息cell的高度  ordermessagecell
                return 177+20 + 150;
            }

        }else if (indexPath.section == 1) {
            //lee999 将查看物流按钮放在最下面了
            return 10;
//            if (orderDetail.orderdetailInfo.expressid.length>1) {
//                return 53;
//            }
        }else if (indexPath.section == 2) {
            if (indexPath.row == 0) {
                return 23;
            }else{
                //这里是普通的商品列表
                return 160;
            }

        }else if (indexPath.section == four) {
            if (indexPath.row == 0) {
                return 23;
            }else
            {
                return 100;
            }

        }else if (indexPath.section == five) {
            if (indexPath.row == 0) {
                return 23;
            }else
            {
                return 60;
            }
        }else if (indexPath.section == six) {
           return 50;
        }else if (indexPath.section == seven) {
            //lee999 将查看物流按钮放在最下面
            //return 10;
            if (orderDetail.orderdetailInfo.expressid.length>1) {
                return 53;
            }
        }else if (indexPath.section >=3&&indexPath.section <four) {
//            //lee999
            YKSuitListItem *suitListItem = (YKSuitListItem *)[orderDetail.itemSuit objectAtIndex:indexPath.section-3];
            if (indexPath.row == [[suitListItem suits] count]) {
                return 60;
            }
//            //end
            return 160;
        }

    }
    return 0;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
    
            if (indexPath.row != 0) {
                if (orderDetail.itemList.count > 0) {
                    
                    YKItem *item = (YKItem *)[orderDetail.itemList objectAtIndex:indexPath.row - 1];
                    
                    NSLog(@"item----:%@",item);

                    ProductDetailViewController* detail = [[ProductDetailViewController alloc] init];
                    detail.thisProductId = item.goodsid;
                    detail.ThisPorductName=item.name;
                    detail.isPush = YES;
                    detail.isFromCar = isFromCar;  //lee999recode来自car了
                    detail.isHiddenBar = self.isHiddenBar;
                    //lee999recode
                    detail.isFromMyAimer = self.isFromAimer;
                    //end
                    [self.navigationController pushViewController:detail animated:YES];
                }
            }
    }else if (indexPath.section >2&&indexPath.section < four){
        if (orderDetail.itemSuit.count > 0) {
            
//            YKSuitListItem *suitListItem = (YKSuitListItem *)[orderDetail.itemSuit objectAtIndex:indexPath.section-3];
//            YKPreferentialSuit *controller = [[YKPreferentialSuit alloc] init];
//            controller.strStuit = suitListItem.suitid;
//            controller.isFromMyAimer = YES;
//           [self.navigationController pushViewController:controller animated:YES];
            
            
            
            //lee999小莹要求 套装也要到商品详情界面
            YKSuitListItem *suitListItem = (YKSuitListItem *)[orderDetail.itemSuit objectAtIndex:indexPath.section-3];
            YKItem *item = (YKItem *)[suitListItem.suits objectAtIndex:indexPath.row];
            ProductDetailViewController* detail = [[ProductDetailViewController alloc] init];
            detail.thisProductId = item.goodsid;
            detail.ThisPorductName=item.name;
            detail.isPush = YES;
            detail.isHiddenBar = self.isHiddenBar;
            detail.isFromCar = isFromCar;  //lee999recode来自car了
            //lee999recode
            detail.isFromMyAimer = self.isFromAimer;
            //end
            [self.navigationController pushViewController:detail animated:YES];

        }
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark  创建套装
-(void)createSuitlistcells
{
    [self.suitlistcell removeAllObjects];
    
    for (int j=0; j<[orderDetail.itemSuit count]; j++) {
        YKSuitListItem* item = [orderDetail.itemSuit objectAtIndex:j];
        
        NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:1];
        
        for (int k = 0; k<[item.suits count]; k++) {
            static NSString	*CellIdentifier2 = @"Cell2";
            UITableViewCell *Cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                           reuseIdentifier:CellIdentifier2];
            Cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UIImageView *icon = nil;
            if (k==0) {
                
                UIImageView *topImageV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 300, 160)];
                [topImageV setImage:[[UIImage imageNamed:@"list_bg_01.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(16, 14, 250, 100)]];
                
                [Cell.contentView addSubview:topImageV];
                
                icon  = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 21, 38)];
                [icon setImage:[UIImage imageNamed:@"icon_suit.png"]];
                [Cell.contentView addSubview:icon];
                
            }else {
                UIImageView *modile = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 300, 160)];
                [modile setImage:[[UIImage imageNamed:@"list_bg_02.png"]resizableImageWithCap:UIEdgeInsetsMake(5, 5, 0, 0)]];
                [Cell.contentView addSubview:modile];
            }
            
            YKProductsItem *pItem = [item.suits objectAtIndex:k];
            BOOL showStock = NO;
            if (pItem.stock && ![pItem.stock isKindOfClass:[NSNull class]] && ![pItem.stock isEqualToString:@""]) {
                showStock = YES;
            }
            
            //lee999将图片往下移动了。
            UrlImageView* shoppingImg = [[UrlImageView alloc] init];
            [shoppingImg setImageFromUrl:YES withUrl:pItem.pic];
            shoppingImg.frame = CGRectMake(16, 25, 84, 103);
            shoppingImg.backgroundColor = [UIColor clearColor];
            [Cell.contentView addSubview:shoppingImg];
            
            int yOffset = 6;
            if (!showStock) {
                yOffset += 8;
            }
            
            //lee999 原来是40  变成了70，改为了2行
            int nameHeight = showStock?60:65;
            UILabel* shoppingName = [[UILabel alloc] initWithFrame:CGRectMake(110, yOffset, 190, nameHeight)];
            shoppingName.backgroundColor = [UIColor clearColor];
            shoppingName.numberOfLines = 2;
//            shoppingName.lineBreakMode = UILineBreakModeWordWrap;
            shoppingName.text = [NSString stringWithFormat:@"%@\n",pItem.name];
            shoppingName.font = [UIFont systemFontOfSize:13];
            shoppingName.textColor = [UIColor blackColor];
            [Cell.contentView addSubview:shoppingName];
            
            yOffset += nameHeight-20;
            
            if (showStock) {
                UILabel* desc = [[UILabel alloc] initWithFrame:CGRectMake(110, yOffset, 150, 18)];
                desc.backgroundColor = [UIColor clearColor];
                desc.text = pItem.stock;
                desc.font = [UIFont systemFontOfSize:12];
                desc.textColor = [UIColor redColor];
                [Cell.contentView addSubview:desc];
                
                yOffset += 8;
            }
            
            UILabel* colorName = [[UILabel alloc] initWithFrame:CGRectMake(110, yOffset,170, 30)];
            colorName.backgroundColor = [UIColor clearColor];
//            colorName.lineBreakMode = UILineBreakModeMiddleTruncation;
            colorName.text = [NSString stringWithFormat:@"颜色: %@    尺码: %@", pItem.color, pItem.size];
            colorName.font = [UIFont systemFontOfSize:13];
            colorName.textColor = UIColorFromRGB(0x666666);
            [Cell.contentView addSubview:colorName];
            
            yOffset += 20;
            
            UILabel* priceName = [[UILabel alloc] initWithFrame:CGRectMake(110, yOffset, 50, 30)];
            priceName.backgroundColor = [UIColor clearColor];
            priceName.text = @"单价: ";
            priceName.font = [UIFont systemFontOfSize:13];
            priceName.textColor = UIColorFromRGB(0x666666);
            [Cell.contentView addSubview:priceName];
            
            
            UILabel* priceValue = [[UILabel alloc] initWithFrame:CGRectMake(150, yOffset-1, 100, 30)];
            priceValue.backgroundColor = [UIColor clearColor];
            priceValue.text = [NSString stringWithFormat:@"￥%.2f", pItem.mkt_price];
            priceValue.font = [UIFont systemFontOfSize:14];
            priceValue.textColor = UIColorFromRGB(0xB90023);
            [Cell.contentView addSubview:priceValue];
            
            [Cell.contentView bringSubviewToFront:icon];
            
            
            //lee999
            
//            UIButton *buttonAccess = [UIButton buttonWithType:UIButtonTypeCustom];
//            [buttonAccess setFrame:CGRectMake(215, 114, 85, 32)];
//            [buttonAccess setTitle:@"评价" forState:UIControlStateNormal];
//            [buttonAccess setTitle:@"评价" forState:UIControlStateHighlighted];
//            [buttonAccess setBackgroundImage:[UIImage imageNamed:@"button_red.png"] forState:UIControlStateNormal];
//            [buttonAccess  setBackgroundImage:[UIImage imageNamed:@"button_red.png"] forState:UIControlStateHighlighted];
////            [buttonAccess addTarget:self action:@selector(evaluateProduct:) forControlEvents:UIControlEventTouchUpInside];
//            buttonAccess.titleLabel.font = [UIFont systemFontOfSize:14.0];
//            buttonAccess.tag = j+5000;
//
////            if (pItem.rate_flag) {
////                buttonAccess.hidden = NO;
////            }else{
////                buttonAccess.hidden = YES;
////            }
//            
//            [Cell.contentView addSubview:buttonAccess];

            //end
            
            [array addObject:Cell];

            
        }
        
        static NSString	*CellSuitlist3 = @"Cell3";
        UITableViewCell *viewSuitlistCell3 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellSuitlist3];
        viewSuitlistCell3.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *buttom = [[UIImageView alloc] initWithFrame:CGRectMake(10, -8, 300, 60)];
        
        [buttom setImage:[[UIImage imageNamed:@"list_bg_03.png"] resizableImageWithCap:UIEdgeInsetsMake(5, 5, 0, 0)]];
        [viewSuitlistCell3.contentView addSubview:buttom];
        
        UIFont *font = [UIFont systemFontOfSize:13];
        int xOffset = 15;
        int yOffset = 0;
        int height = (70-yOffset-10)/2;
        
        
        UILabel* desc = [[UILabel alloc] initWithFrame:CGRectMake(xOffset, yOffset, 200, height)];
        desc.backgroundColor = [UIColor clearColor];
//        desc.lineBreakMode = UILineBreakModeMiddleTruncation;
        desc.text = [NSString stringWithFormat:@"数量: %d", item.number];
        desc.font = [UIFont systemFontOfSize:13];
        desc.textColor = UIColorFromRGB(0x666666);
        [viewSuitlistCell3.contentView addSubview:desc];
        
        NSString *str = @"套装价: ";
        int strWidth = [str sizeWithFont:font].width;
        desc = [[UILabel alloc] initWithFrame:CGRectMake(xOffset, yOffset+height-10, strWidth, height)];
        desc.backgroundColor = [UIColor clearColor];
        desc.text = str;
        desc.font = [UIFont systemFontOfSize:13];
        desc.textColor = UIColorFromRGB(0xB90023);/*UIColorFromRGB(0x666666)*/
        [viewSuitlistCell3.contentView addSubview:desc];
        xOffset += strWidth;
        
        desc = [[UILabel alloc] initWithFrame:CGRectMake(xOffset, yOffset+height-10, 90, height)];
        desc.backgroundColor = [UIColor clearColor];
        desc.text = [NSString stringWithFormat:@"￥%.2f", item.price];
        desc.font = [UIFont systemFontOfSize:16];
        desc.textColor = UIColorFromRGB(0xB90023);
        [viewSuitlistCell3.contentView addSubview:desc];
        xOffset = 170;
        
        desc = [[UILabel alloc] initWithFrame:CGRectMake(xOffset, yOffset+height-10, 110, height)];
        desc.backgroundColor = [UIColor clearColor];
//        desc.lineBreakMode = UILineBreakModeMiddleTruncation;
        desc.text = [NSString stringWithFormat:@"优惠: ￥%.2f", item.save];
        desc.font = [UIFont systemFontOfSize:13];
        desc.textColor = UIColorFromRGB(0x666666);
        [viewSuitlistCell3.contentView addSubview:desc];
        
        
//        desc = [[UILabel alloc] initWithFrame:CGRectMake(xOffset, yOffset, 110, height)];
//        desc.backgroundColor = [UIColor clearColor];
//        desc.lineBreakMode = UILineBreakModeMiddleTruncation;
//        desc.text = [NSString stringWithFormat:@"积分: %d", item.suit_score];
//        desc.font = [UIFont systemFontOfSize:13];
//        desc.textColor = UIColorFromRGB(0x666666);
//        [viewSuitlistCell3.contentView addSubview:desc];
        
        [array addObject:viewSuitlistCell3];
        
        [self.suitlistcell addObject:array];
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



#pragma mark-- 我要评价
//- (void)evaluateProduct:(UIButton *)sender
//{
//    AccessViewController *accessV = [[AccessViewController alloc] initWithNibName:@"AccessViewController" bundle:nil];
//    accessV.co_ID = self.orderID;
//    if (sender.tag>=5000) {
//        YKItem *productList = (YKItem *)[orderDetail.itemList objectAtIndex:sender.tag-5000];
//        accessV.goodId = productList.goodsid;
//        accessV.productID = productList.productid;
//        [self.navigationController pushViewController:accessV animated:YES];
//    }else {
//        NSLog(@"%d",sender.tag/100);
//        YKSuitListItem *suitListItem = (YKSuitListItem *)[orderDetail.itemSuit objectAtIndex:sender.tag/100];
//        YKProductsItem *productList = (YKProductsItem *)[suitListItem.suits objectAtIndex:sender.tag%100];
//        accessV.goodId = productList.goodsid;
//        accessV.productID = productList.product_id;
//        [self.navigationController pushViewController:accessV animated:YES];
//    }
//
//
////    CommentOrderViewController *accessV = [[CommentOrderViewController alloc] initWithNibName:@"CommentOrderViewController" bundle:nil];
////    accessV.co_ID = self.orderID;
////    [self.navigationController pushViewController:accessV animated:YES];
////
////    //    if (sender.tag>=5000) {
//////            YKItem *productList = (YKItem *)[orderDetail.itemList objectAtIndex:sender.tag-5000];
//////            accessV.goodId = productList.goodsid;
//////            accessV.productID = productList.productid;
//////            [self.navigationController pushViewController:accessV animated:YES];
//////        }else {
//////            NSLog(@"%d",sender.tag/100);
//////            YKSuitListItem *suitListItem = (YKSuitListItem *)[orderDetail.itemSuit objectAtIndex:sender.tag/100];
//////            YKProductsItem *productList = (YKProductsItem *)[suitListItem.suits objectAtIndex:sender.tag%100];
//////            accessV.goodId = productList.goodsid;
//////            accessV.productID = productList.product_id;
//////            [self.navigationController pushViewController:accessV animated:YES];
//////    }
//}

