//
//  ExchangeRecordViewController.h
//  爱慕商场
//
//  Created by malan on 14-9-26.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBaseViewController.h"
#import "PullToRefreshTableView.h"
#import "GetexchangescorerecordGetModel.h"

@interface ExchangeRecordViewController : LBaseViewController<ServiceDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    MainpageServ *mainSer;
    PullToRefreshTableView *_tableView;
    NSInteger totalCount;
    NSInteger current;
    NSMutableArray *_arrData;
}
@property (nonatomic, copy) NSString *cardId;
@property (nonatomic, retain) GetexchangescorerecordGetModel *getexchangescorerecordGetModel;
@end
