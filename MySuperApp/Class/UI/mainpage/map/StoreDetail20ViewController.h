//
//  StoreDetail20ViewController.h
//  MyAimerApp
//
//  Created by yanglee on 15/4/20.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "LBaseViewController.h"
#import <BaiduMapAPI/BMapKit.h>//引入所有的头文件
#import <BaiduMapAPI/BMKNavigation.h>//引入所有的头文件

#import "MainpageServ.h"

#import "StoresStoresModel.h"
#import "StoresStores.h"

#import "NewFavInfo.h"

@protocol StoreDetail20Delegate <NSObject>
@required

- (void)sureFavStore:(BOOL)isfav withIndex:(int)index;

@end

@interface StoreDetail20ViewController : LBaseViewController<BMKMapViewDelegate,ServiceDelegate,CLLocationManagerDelegate,UIScrollViewDelegate>//UITableViewDelegate  UITableViewDataSource


@property (nonatomic,assign) id<StoreDetail20Delegate>delegate;

@property (nonatomic, retain)StoresStores *store;

@property (nonatomic, assign)NSInteger index;



//- (IBAction)changeMapFrame:(id)sender;


@end
