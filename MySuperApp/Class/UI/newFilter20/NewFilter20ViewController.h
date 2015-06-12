//
//  NewFilter20ViewController.h
//  MyAimerApp
//
//  Created by yanglee on 15/4/20.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "LBaseViewController.h"
#import "NewSortInfo.h"


@protocol FilterViewDataDelegate <NSObject>
@required

- (void)sureFilter:(NSString*)prama;

@end


@interface NewFilter20ViewController : LBaseViewController<UITableViewDelegate,UITableViewDataSource,ServiceDelegate>
{
    MainpageServ *mainSev;
    BrandsProductListModel *productListModel;
}
@property (nonatomic, retain)NSMutableArray *arrfilter; //上一个界面返回的，筛选信息的数组
@property (nonatomic, retain)NSMutableArray *arrSelectfilter; //上一个界面返回的，已选中筛选信息的数组


@property (nonatomic,assign) id<FilterViewDataDelegate> delegate;


@property (nonatomic, retain)NSString *params;
@property (nonatomic, retain)NSString *orderStr;
@property (nonatomic, retain)NSString *key;
@property (nonatomic, retain)NSString *strcurrentpage;
@property (nonatomic, retain)NSString *strperpage;



@end
