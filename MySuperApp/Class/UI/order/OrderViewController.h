//
//  OrderViewController.h
//  MySuperApp
//
//  Created by LEE on 14-4-5.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "LBaseViewController.h"
#import "PullToRefreshTableView.h"
#import "UIPopoverListView.h"
#import "UPPayPluginDelegate.h"


@interface OrderViewController : LBaseViewController <UITableViewDataSource,UITableViewDelegate,ServiceDelegate,UIPopoverListViewDataSource, UIPopoverListViewDelegate,UIAlertViewDelegate,UPPayPluginDelegate>
{
    
    MainpageServ *mainSev;

    NSInteger totalCount;
    NSInteger current;
    
    IBOutlet PullToRefreshTableView *tableList;
    OrdersOrdersModel *orderModel;
    NSString *userName;
 
    NSMutableArray *contentArr;
    
    //lee999
    __weak IBOutlet UIView *headview;
    
    __weak IBOutlet UIButton *allbtn;
    __weak IBOutlet UIButton *needpayBtn;
    __weak IBOutlet UIButton *needcommbtn;
    __weak IBOutlet UIButton *needHandlebtn;
    
    __weak IBOutlet UIImageView *allkeyImg;
    __weak IBOutlet UIImageView *needpayImg;
    __weak IBOutlet UIImageView *needcommkeyImg;
    __weak IBOutlet UIImageView *needHandlekeyImg;
    
    __weak IBOutlet UIView *bandgeV1;
    __weak IBOutlet UIView *bandgeV2;
    
    NSString *str_orderid;

}


@property (nonatomic, assign) NSInteger howEnter;//判断从哪里进入（1.我的订单 2.待处理 3.待评价，4，代付款）

@property (nonatomic, assign) BOOL enterWhere;//判断是否是从待评价按钮进入到订单详情

@property (nonatomic, strong) NSString* bandgeNum1;
@property (nonatomic, strong) NSString*  bandgeNum2;
@property (nonatomic, assign) BOOL ishowHeadView;//判断是否显示头文件
@property (nonatomic, retain) NSString *tf_tradeNo;



@end
