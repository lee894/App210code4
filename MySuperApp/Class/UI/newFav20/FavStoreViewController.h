//
//  FavStoreViewController.h
//  MyAimerApp
//
//  Created by yanglee on 15/4/24.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "LBaseViewController.h"

@interface FavStoreViewController : LBaseViewController<UITableViewDataSource,UITableViewDelegate,ServiceDelegate>
{
    
    NSMutableArray *contentdataArr;
    MainpageServ *mainSer;
    
}

@end
