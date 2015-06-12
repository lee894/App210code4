//
//  ProductContentViewController.h
//  MySuperApp
//
//  Created by LEE on 14-7-23.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductCell.h"
#import "PullToRefreshTableView.h"
#import "LBaseViewController.h"
#import "BrandsProductListModel.h"
#import "MainpageServ.h"
#import "NewFilter20ViewController.h"


@interface ProductContentViewController : LBaseViewController <UITableViewDataSource,UITableViewDelegate,ServiceDelegate,ProductIdDelegate,FilterViewDataDelegate>
{
    NSInteger totalCount;
    NSInteger current;
    
    NSMutableArray *contentArr;
    BrandsProductListModel *brandList;
    
}

@property (nonatomic, retain) IBOutlet PullToRefreshTableView *tableList;
@property (nonatomic, retain) IBOutlet UrlImageView *imgBackground;

@property (nonatomic, retain) NSString *params;//标记是哪个品牌
@property (nonatomic, assign) NSInteger current;
@property (nonatomic, retain) NSArray *arrayImg;//背景图的图片数组


@property (nonatomic, retain) NSString *strtitle;//标题





@end
