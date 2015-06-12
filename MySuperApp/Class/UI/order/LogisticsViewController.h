//
//  LogisticsViewController.h
//  爱慕商场
//
//  Created by LEE on 14-8-5.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "LBaseViewController.h"

@interface LogisticsViewController : LBaseViewController <UITableViewDataSource,UITableViewDelegate,ServiceDelegate,UIAlertViewDelegate>
{
    MainpageServ *mainSer;
    
    
    IBOutlet UILabel *labelDelivery;
    IBOutlet UILabel *labelNum;
    IBOutlet UITableView *tableList;
    
    LookCheckDetails *checkDetail;
    
    __weak IBOutlet UILabel *nowuliuLab;
}

@property (nonatomic, retain) NSString *delivery_type;
@property (nonatomic, retain) NSString *expressid;


@end
