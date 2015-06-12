//
//  YKReferOrderViewController.h
//  YKProduct
//
//  Created by caiting on 11-12-14.
//  Copyright 2011 yek. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "Umpay.h"
#import "LBaseViewController.h"
#import "UPPayPluginDelegate.h"
#import "APService.h"


@interface YKReferOrderViewController : LBaseViewController <ServiceDelegate, UITableViewDelegate,UITableViewDataSource,UPPayPluginDelegate> {//UmpayDelegate
	UITableView* orderTable;
	NSMutableArray* cells;
	
	NSString* price;
	NSString* orderid;
	NSString* payway;
    BOOL   m_bShowPay;
    
    MainpageServ *mainSer;
    
    UIButton * seeButtonPay;
    
    BOOL isRoot;
    BOOL isNotGoBacktoRootCar;
    
    
    UILabel* labelok;//订单已提交的文案
    UILabel* labeldesc;
    
    
    BOOL isOrderPayOK;//是否支付成功
    
}

@property(nonatomic,retain) NSString* price;
@property(nonatomic,retain) NSString* orderid;
@property(nonatomic,retain) NSString* payway;
@property(nonatomic, assign) BOOL   m_bShowPay;

@property (nonatomic, retain) NSString *tf_tradeNo;

@property (nonatomic, retain) NSDictionary *dicID;

//lee999
@property (nonatomic, assign) BOOL isZhunxiangkaHUIyuanAlert;
@property(nonatomic,strong)NSString* sendStrng;


@property (nonatomic, retain) OrderInfoOrderInfoModel *orderInfoModel;

- (void)createCells;

@end



