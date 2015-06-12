//
//  GetCouponTableViewController.h
//  爱慕商场
//
//  Created by malan on 14-9-27.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBaseViewController.h"

@interface GetCouponTableViewController : LBaseViewController<ServiceDelegate,UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
{
    MainpageServ *mainSer;
    
    UITableView *mytableView;
    
    GetscouponModel *couponModel;
}

@property (nonatomic, assign) BOOL isHome;
@property (nonatomic, copy) NSString *couponed;
@property (nonatomic, retain) NSString *titleName;
//单元格上按钮的点击事件
- (void)btnClicked:(UIButton *) btn onCell:(UITableViewCell *)cell;
@end
