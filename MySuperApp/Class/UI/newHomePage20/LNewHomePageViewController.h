//
//  LNewHomePageViewController.h
//  MyAimerApp
//
//  Created by yanglee on 15/4/8.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "LBaseViewController.h"
#import "UIScrollView+MJRefresh.h"

#import "SGFocusImageFrame.h"
#import "SGFocusImageItem.h"


@interface LNewHomePageViewController : LBaseViewController<UITableViewDataSource,UITableViewDelegate,ServiceDelegate,SGFocusImageFrameDelegate,UIAlertViewDelegate>
{
    MainpageServ *mainSev;

}


@end


/*
 MJ  使用方法：

1.添加头部控件的方法
[self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
或者
[self.tableView addHeaderWithCallback:^{ }];

2.添加尾部控件的方法
[self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
或者
[self.tableView addFooterWithCallback:^{ }];

3.自动进入刷新状态
[self.tableView headerBeginRefreshing];
[self.tableView footerBeginRefreshing];

4.结束刷新
[self.tableView headerEndRefreshing];
[self.tableView footerEndRefreshing];

*/