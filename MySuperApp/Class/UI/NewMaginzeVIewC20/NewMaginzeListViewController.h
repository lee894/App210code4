//
//  NewMaginzeListViewController.h
//  MyAimerApp
//
//  Created by yanglee on 15/4/11.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "LBaseViewController.h"
#import "NewFilter20ViewController.h"
#import "ProductlistViewController.h"
#import "ProductDetailViewController.h"

@interface NewMaginzeListViewController : LBaseViewController<UITableViewDataSource,UITableViewDelegate,ServiceDelegate,CollectForkDelegate,FilterViewDataDelegate>
{

    MainpageServ *mainSev;

    NSMutableArray *contentdataArr;

    
}


@property(nonatomic,assign)BOOL isShowSwitchBtn;  //是否显示切换按钮，如果首页，就显示切换按钮。 如果不是就不显示

@property(nonatomic,retain) NSString *strtitle; //标题

@property(nonatomic,retain) NSString *params; //筛选参数

@end
