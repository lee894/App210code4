//
//  MyFavViewController.h
//  MySuperApp
//
//  Created by LEE on 14-7-31.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectCell.h"
#import "PullToRefreshTableView.h"
#import "LBaseViewController.h"

@interface MyFavViewController : LBaseViewController <UITableViewDataSource,UITableViewDelegate,ServiceDelegate,CollectForkDelegate>

{
    NSInteger isEdit;
    
    NSInteger totalCount;
    NSInteger current;
    
    NSString *productID;
    
    IBOutlet PullToRefreshTableView *tableList;
    UIView *clearView;
    FavoriteFavoriteModel *favoriteModel;
    
    NSMutableArray *contentArr;
    
    MainpageServ *mainSer;

}



- (IBAction)edit:(UIButton *)sender;//编辑
- (IBAction)empty:(id)sender;//清空
- (IBAction)clearComfirmOrCancel:(UIButton *)sender;//清空弹出视图确认or取消


@end
