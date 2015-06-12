//
//  CouponsListTableViewController.h
//  爱慕商场
//
//  Created by malan on 14-9-25.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullToRefreshTableView.h"
#import "CouponcardListCouponcardListModel.h"
#import "CheckOutViewController.h"
#import "LBaseViewController.h"
#import "BlockTextPromptAlertView.h"


@interface CouponsListTableViewController : LBaseViewController <UITableViewDelegate,UITableViewDataSource,ServiceDelegate,UIAlertViewDelegate,UIScrollViewDelegate,BlockAlertViewDelegate,UITextFieldDelegate>
{
    UILabel *_labelInfo;
    PullToRefreshTableView *mytableView;

    NSInteger totalCount;
    NSInteger current;
    MainpageServ *mainSer;//兑换用
    
    
    UITextField *nametextfield;
}

@property (nonatomic, retain)CouponcardListCouponcardListModel *couponcardListModel;
@property (retain, nonatomic) NSMutableArray *arrCard;
@property (retain, nonatomic) NSMutableArray *contentArr;
@property (nonatomic, retain) NSString *phoneNum;
@property (nonatomic, assign) CheckOutViewController *checkOutViewCtrl;

@property (nonatomic, retain)PullToRefreshTableView *mytableView;


@property (nonatomic, assign) BOOL isAimer;
//单元格上按钮的点击事件
- (void)btnClicked:(UIButton *) btn onCell:(UITableViewCell *)cell;

//- (void)Sendcodes;

- (void)initRequest;
@end
