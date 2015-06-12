//
//  OrderDetailViewController.h
//  MySuperApp
//
//  Created by LEE on 14-4-5.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "LBaseViewController.h"
#import "UPPayPluginDelegate.h"
#import "UIPopoverListView.h"

@class UPPayPluginDelegate;
@class UIPopoverListView;

@interface OrderDetailViewController : LBaseViewController <UITableViewDataSource,UITableViewDelegate,ServiceDelegate,UIAlertViewDelegate,UIPopoverListViewDataSource, UIPopoverListViewDelegate,UPPayPluginDelegate>//UmpayDelegate
{

    MainpageServ *mainSev;
    
    IBOutlet UITableView *tableList;
    IBOutlet UITextView *textViewLeaveWords;
    IBOutlet UIButton *buttonNav;
    OrderInfoOrderInfoModel *orderDetail;

}


@property (nonatomic, retain) NSString *orderID;//订单ID
@property (nonatomic, assign) BOOL isUnAccess;//是否从待评价按钮进入;
@property (nonatomic, retain) NSString *userName;
@property (nonatomic, assign) BOOL isFromCar;
@property (nonatomic, retain) NSString *tf_tradeNo;
@property(nonatomic,retain) NSMutableArray* suitlistcell;//套装

@property (nonatomic, assign) BOOL isOrderPayOK;//是否支付成功


@property (nonatomic, assign) BOOL isHiddenBar;//是否隐藏bar
@property (nonatomic, assign) BOOL isFromAimer;//是否来自爱慕



- (IBAction)OrderdetailBtnAciton:(UIButton *)sender;
@end
