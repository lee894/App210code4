//
//  MoreRateViewController.h
//  MySuperApp
//
//  Created by 昝驹 on 13-12-5.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullToRefreshTableView.h"
#import "LBaseViewController.h"

@interface MoreRateViewController : LBaseViewController<ServiceDelegate, UITableViewDataSource,UITableViewDelegate> {
    NSInteger totalCount;
    NSInteger current;
    
    MainpageServ *mainSev;
    
    IBOutlet PullToRefreshTableView *tableList;
}

@property (nonatomic, retain) NSString *goodid;
@property (nonatomic, retain) NSMutableArray *contentArr;


@property (assign,nonatomic) BOOL isFromMyAimer;
@property (assign,nonatomic) BOOL isHiddenBar;


@end
