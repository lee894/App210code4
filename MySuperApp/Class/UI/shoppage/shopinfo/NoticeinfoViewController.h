//
//  NoticeinfoViewController.h
//  MySuperApp
//
//  Created by lee on 14-4-10.
//  Copyright (c) 2014年 aimer. All rights reserved.
//

#import "LBaseViewController.h"
#import "MyPageControl.h"

@interface NoticeinfoViewController : LBaseViewController<ServiceDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView *makedonetable;
    MainpageServ *mainSev;
    NoticeListNoticeListModel *noticeModel;

}


@end
