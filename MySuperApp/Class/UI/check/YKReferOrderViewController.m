//
//  YKReferOrderViewController.m
//  YKProduct
//
//  Created by caiting on 11-12-14.
//  Copyright 2011 yek. All rights reserved.
//

#import "YKReferOrderViewController.h"
#import "YKItem.h"
#import "AlipayHelper.h"
#import "OrderDetailViewController.h"
#import "WXPayClient.h"
#import "BlockAlertView.h"
#import "ImproveInformationViewController.h"
#import "YKCanReuse_webViewController.h"

#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#import "UPPayPlugin.h"

@implementation YKReferOrderViewController

@synthesize price;
@synthesize orderid;
@synthesize payway;
@synthesize m_bShowPay;
@synthesize isZhunxiangkaHUIyuanAlert,sendStrng;

- (void) viewDidLoad {
    [super viewDidLoad];

    //leee999 增加返回按钮
    [self createBackBtnWithType:799];
    
    isNotGoBacktoRootCar = NO;
    
    self.title = @"提交订单";
    
    isOrderPayOK = NO;
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
	//[UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"totalNUM"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TotleNumber" object:nil];
    
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [[[[app.mytabBarController tabBar] items] objectAtIndex:3] setBadgeValue:@""];
    
    
    labelok = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 60)];
    labelok.textAlignment = UITextAlignmentCenter;
	labelok.backgroundColor = [UIColor clearColor];
	labelok.font = [UIFont systemFontOfSize:22];
	labelok.textColor =  [UIColor blackColor];
	labelok.text = @"订单已提交!";
	[self.view addSubview:labelok];
    
	orderTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, 320, 150) style:UITableViewStyleGrouped];
	orderTable.delegate     =   self;
	orderTable.dataSource   =   self;
    orderTable.backgroundView = nil;
    orderTable.backgroundColor  =   [UIColor clearColor];
	orderTable.scrollEnabled    =   NO;
    orderTable.showsVerticalScrollIndicator =   NO;
    orderTable.separatorStyle   =   UITableViewCellSeparatorStyleNone;
	[self.view addSubview:orderTable];


    [SingletonState sharedStateInstance].isInCheckOKView = YES;
    
    labeldesc = [[UILabel alloc] initWithFrame:CGRectMake(10, 235, 300, 40)];
    if ([[[UIDevice currentDevice] systemVersion] intValue]<7) {
        [labeldesc setFrame:CGRectMake(10, 180, 300, 40)];
    }
    labeldesc.textAlignment = UITextAlignmentCenter;
	labeldesc.backgroundColor = [UIColor clearColor];
	labeldesc.font = [UIFont systemFontOfSize:14];
	labeldesc.textColor =  [UIColor grayColor];
	labeldesc.text = @"在线支付订单未付款24小时后将自动取消";
    [self.view addSubview:labeldesc];
    labeldesc.hidden = YES;
    
    if (isIOS7up) {
        [labelok setFrame:CGRectMake(90, 20, 150, 60)];
        [orderTable setFrame:CGRectMake(0, 40, 320, 150)];
    }
	
	cells = [[NSMutableArray alloc] init];
	[self createCells];
    
    mainSer = [[MainpageServ alloc] init];
    mainSer.delegate = self;
  
    
    //lee999 150506 关闭下单接口请求订单详情
    [self loadData];
}

-(void)nullAction{

}


- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    

    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(payOKChangeLabelAndBtn) name:@"alipayOKanjumptoOrderDetail" object:nil];


    if (self.isZhunxiangkaHUIyuanAlert)
    {
        //lee999 提交订单页的入会弹框，点我为什么要入会也跳到购物车去了
        isNotGoBacktoRootCar = YES;
        //end
        
        BlockAlertView *alert = [[BlockAlertView alloc]initWithTitle:@"爱慕提示" message:@"此次购物完成后可以成为爱慕集团尊享卡会员，请问您是否愿意加入？"];
        alert.isTag = YES;
        [alert setDestructiveButtonWithTitle:@"我为什么要入会？>" block:^(void) {
            
            self.isZhunxiangkaHUIyuanAlert = YES;
            
            YKCanReuse_webViewController *webView = [[YKCanReuse_webViewController alloc] init];
            webView.strURL = @"http://m.aimer.com.cn/method/v6codeinfo";
            webView.strTitle = @"尊享卡会员";
            [self.navigationController pushViewController:webView animated:YES];
        }];
        
        [alert addButtonWithTitle:@"是" block:^(void)
         {
             ImproveInformationViewController *iminfo = [[ImproveInformationViewController alloc] initWithNibName:@"ImproveInformationViewController" bundle:nil];
             iminfo.key = sendStrng;//submitOrderModel.key;
             [self.navigationController pushViewController:iminfo animated:YES];
         }];
        [alert setCancelButtonWithTitle:@"否" block:nil];
        
        [alert show];
        
        self.isZhunxiangkaHUIyuanAlert = NO;
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"alipayOKanjumptoOrderDetail" object:nil];

}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:YES];
}

#pragma mark ======UITableViewCell=======
- (void) createCells {
	[cells removeAllObjects];
	for (int i = 0; i < 3 ; i ++) {
		static NSString	*CellIdentifier = @"Cell1";
		UITableViewCell *shoppingCarCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                  reuseIdentifier:CellIdentifier];
		shoppingCarCell.selectionStyle = UITableViewCellSelectionStyleNone;
		
		UILabel* orderName = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 20)];
		orderName.backgroundColor = [UIColor clearColor];
		if (i == 0) {
			orderName.text = @"订单号：";
		}
		if (i == 1) {
			orderName.text = @"应付金额：";
		}
		if (i == 2) {
			orderName.text = @"支付方式：";
		}
		orderName.font = [UIFont systemFontOfSize:14];
		[shoppingCarCell.contentView addSubview:orderName];

		
		UILabel* orderValue = [[UILabel alloc] initWithFrame:CGRectMake(150, 10, 140, 20)];
		orderValue.textAlignment = UITextAlignmentRight;
		orderValue.backgroundColor = [UIColor clearColor];
		if (i == 0) {
			orderValue.text = self.orderid;
			orderValue.textColor = [UIColor colorWithHexString:@"0x666666"];
		}
		if (i == 1) {
			orderValue.text = self.price?[NSString stringWithFormat:@"¥%@",self.price]:@"";
			orderValue.textColor = [UIColor redColor];
		}
		if (i == 2) {
			orderValue.text = self.payway;
			orderValue.textColor = [UIColor colorWithHexString:@"0x666666"];//UIColorFromRGB(0x666666);
		}
		orderValue.textAlignment = UITextAlignmentRight;
		orderValue.font = [UIFont systemFontOfSize:14];
		
		[shoppingCarCell.contentView addSubview:orderValue];

		
		[cells addObject:shoppingCarCell];
	}
    
    if (self.m_bShowPay) {
        //支付宝按钮
        
        labeldesc.hidden = NO;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideSeeButPay:) name:@"PaySeccuseed" object:nil];
        
        seeButtonPay = [UIButton buttonWithType:UIButtonTypeCustom];
        seeButtonPay.frame = CGRectMake(30, isIOS7up?240+40:200+40, ScreenWidth-60, 40);
        seeButtonPay.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [seeButtonPay setTitle:@"立即支付" forState:UIControlStateNormal];
        [seeButtonPay setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [seeButtonPay addTarget:self action:@selector(aliPayorder:) forControlEvents:UIControlEventTouchUpInside];
        [seeButtonPay setBackgroundImage:[UIImage imageNamed:@"big_btn_r_normal.png"] forState:UIControlStateNormal];
        [seeButtonPay setBackgroundImage:[UIImage imageNamed:@"big_btn_r_hover.png"] forState:UIControlStateHighlighted];
        [self.view addSubview:seeButtonPay];
        //查看订单按钮
        UIButton * seeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        seeButton.frame = CGRectMake(30, isIOS7up?280+45:240+45, ScreenWidth-60, 40);
        seeButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [seeButton setTitle:@"查看订单" forState:UIControlStateNormal];
        [seeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [seeButton addTarget:self action:@selector(gotoSeeorder) forControlEvents:UIControlEventTouchUpInside];
        [seeButton setBackgroundImage:[UIImage imageNamed:@"sryc_btn_big_normal.png"] forState:UIControlStateNormal];
        [seeButton setBackgroundImage:[UIImage imageNamed:@"sryc_btn_big_hover.png"] forState:UIControlStateHighlighted];
        [self.view addSubview:seeButton];
    } else {
        isRoot = YES;
        
        //查看订单按钮
        UIButton * seeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        seeButton.frame = CGRectMake(30,isIOS7up?240+45:200+45,  ScreenWidth-60, 40);
        seeButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [seeButton setTitle:@"查看订单" forState:UIControlStateNormal];
        [seeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [seeButton addTarget:self action:@selector(gotoSeeorder) forControlEvents:UIControlEventTouchUpInside];
        [seeButton setBackgroundImage:[UIImage imageNamed:@"sryc_btn_big_normal.png"] forState:UIControlStateNormal];
        [seeButton setBackgroundImage:[UIImage imageNamed:@"sryc_btn_big_hover.png"] forState:UIControlStateHighlighted];
        [self.view addSubview:seeButton];
    }
    
  }

- (void)hideSeeButPay:(NSNotification *)notion {
    
    [mainSer getConfim_alipay:self.orderid];
    seeButtonPay.hidden = YES;
    isRoot = YES;
    
    labeldesc.hidden = YES;
}

- (void)aliPayorder:(id)sender
{

    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"AliPayPageForm"];
    NSLog(@"用户选择的支付方式是：------%@",self.payway);
    //支付宝支付
    if ([self.payway rangeOfString:@"支付宝"].location != NSNotFound) {

        
        //lee999 150506 修改支付相关问题
        [AlipayHelper alipayActionwithPrice:self.price
                                 andOrderid:self.orderid];
        
    }else if ([self.payway rangeOfString:@"微信支付"].location != NSNotFound) {
        
        if (![WXApi isWXAppInstalled]) {
            [LCommentAlertView showMessage:@"您还未安装微信，请换其他支付方式" target:nil];
            return;
        }
        
        //lee999 150506 修改支付相关问题
        [[WXPayClient shareInstance] payProductwithorderid:self.orderid Money:self.price];

        
        
    }else  if ([self.payway rangeOfString:@"银联支付"].location != NSNotFound){

        [mainSer upmpTradno:self.orderid];
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
        
        seeButtonPay.hidden = YES;
        [self payOKChangeLabelAndBtn];
        
    }else if ([result isEqualToString:@"fail"]){
        
        [SBPublicAlert showAlertTitle:@"爱慕提示" Message:@"支付失败"];
    }else if ([result isEqualToString:@"cancel"]){
        
        [SBPublicAlert showAlertTitle:@"爱慕提示" Message:@"用户中途取消"];
    }else{
    }
}

#pragma mark---支付成功之后的回调，修改订单label文字，隐藏支付按钮
-(void)payOKChangeLabelAndBtn{
    
    
    //支付成功
    isOrderPayOK = YES;
    //end
    
    labelok.text = @"支付成功";
    seeButtonPay.hidden = YES;
    
    labeldesc.hidden = YES;
}


#pragma mark =====查看订单=====
- (void) gotoSeeorder {
    
    [SingletonState sharedStateInstance].isFromCheckOKView = YES;
    isNotGoBacktoRootCar = YES;
    OrderDetailViewController *tempOrderDetail = [[OrderDetailViewController alloc] init];
    tempOrderDetail.isUnAccess = NO;
    tempOrderDetail.isFromCar = YES;  //是否来自结算中心
    tempOrderDetail.isHiddenBar = YES; //是否隐藏bar
    tempOrderDetail.orderID = self.orderid;
    tempOrderDetail.isOrderPayOK = isOrderPayOK;
    [self.navigationController pushViewController:tempOrderDetail animated:YES];
}

-(void)popBackAnimate:(UIButton *)sender {
    if (isRoot) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    } else {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}


- (void) loadData {
    [SBPublicAlert showMBProgressHUD:@"正在请求" andWhereView:self.view states:NO];
    [mainSer getOrderdetail:self.orderid];
}

- (NSString *) pageJumpParam{
    return nil;
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
        case Http_Orderdetail_Tag:
        {
            if (!model.errorMessage) {
                [SBPublicAlert hideMBprogressHUD:self.view];

                self.orderInfoModel = (OrderInfoOrderInfoModel *)model;
                
                OrderInfoOrderdetailInfo *orderInfo = [self.orderInfoModel orderdetailInfo];
                OrderInfoOrderdetailReceiveinfo *orderRecei = [self.orderInfoModel orderdetailReceiveinfo];
                
                NSMutableDictionary *dic1  = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.orderid, @"OrderNO",orderInfo.payway, @"Payment",orderInfo.price, @"OrderAmount",orderRecei.province, @"Province",[NSNumber numberWithInt:[self.orderInfoModel.itemSuit count] + [self.orderInfoModel.itemList count]], @"Ordergoodsnum",orderInfo.ordertime, @"OrdernoTime",nil];
                [dic1 addEntriesFromDictionary:self.dicID];
                [TalkingData trackEvent:@"1009" label:@"提交订单成功" parameters:dic1];
            }else {
                [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:1.0];
            }
        }
            break;
            case Http_TrdnoByOrderld_Tag: //银联支付返回流水号
        {
            if (!model.errorMessage) {
                [SBPublicAlert hideMBprogressHUD:self.view];
                
                [self UnpaybuttonClicked:mainSer.unpayTN];
                
            }else {
                [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:1.0];
            }
        }
            break;
            case Http_CancelOrder_Tag:
        {
            if (!model.errorMessage) {
                [SBPublicAlert hideMBprogressHUD:self.view];
                [self.navigationController popViewControllerAnimated:YES];
            }else {
                [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:1.0];
            }
        }
            break;
        case 10086:
        {
            [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:1.0];
        }
            break;
        default:
        {
            [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:1.0];
        }
            break;
    }
}



- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 3;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	return [cells objectAtIndex:indexPath.row];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 40;
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
