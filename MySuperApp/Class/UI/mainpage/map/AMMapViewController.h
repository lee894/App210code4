//
//  AMMapViewController.h
//  MySuperApp
//
//  Created by yang on 14-3-25.
//  Copyright (c) 2014年 aimer. All rights reserved.
//

#import "LBaseViewController.h"

#import <BaiduMapAPI/BMapKit.h>//引入所有的头文件
#import "MainpageServ.h"
#import "StoresStoresModel.h"

#import "StoreDetail20ViewController.h"

//lee999附近的店200

@interface AMMapViewController : LBaseViewController<BMKMapViewDelegate,ServiceDelegate,CLLocationManagerDelegate,UITableViewDelegate,UITableViewDataSource,StoreDetail20Delegate,BMKLocationServiceDelegate>
{
    __weak IBOutlet UILabel *sizelab;
}


- (IBAction)changeMapFrame:(id)sender;
@end
