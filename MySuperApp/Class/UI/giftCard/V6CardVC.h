//
//  V6CardVC.h
//  MyAimerApp
//
//  Created by yanglee on 15/7/6.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "LBaseViewController.h"
#import "PullToRefreshTableView.h"
#import "CouponcardListCouponcardListModel.h"
#import "CheckOutViewController.h"
#import "LBaseViewController.h"
#import "BlockTextPromptAlertView.h"


@interface V6CardVC : LBaseViewController<UITableViewDelegate,UITableViewDataSource,ServiceDelegate,UIAlertViewDelegate,UIScrollViewDelegate,BlockAlertViewDelegate,UITextFieldDelegate>
{
    UILabel *_labelInfo;
    NSInteger totalCount;
    NSInteger current;
    MainpageServ *mainSer;//兑换用
    
    
    UITextField *nametextfield;
}
@property (retain, nonatomic) NSMutableArray *contentArr;
@property (nonatomic, retain) PullToRefreshTableView *mytableView;


- (void)initRequest;


@end
