//
//  HotpageViewController.h
//  aimerOnline
//
//  Created by lee on 14-3-3.
//  Copyright (c) 2014年 aimer. All rights reserved.
//

#import "LBaseViewController.h"
#import "ProductlistViewController.h"
#import "ProductDetailViewController.h"
#import "NewFilter20ViewController.h"

@interface HotpageViewController : LBaseViewController<UITableViewDataSource, UITableViewDelegate,ServiceDelegate,CollectForkDelegate,UIGestureRecognizerDelegate,FilterViewDataDelegate>
{
    MainpageServ *mainSev;
    
    NSInteger totalCount;
    NSInteger current;
    
    __weak IBOutlet UIView *viewbtns;
    __weak IBOutlet UIButton *newbtn;
    __weak IBOutlet UIButton *hotbtn;
    __weak IBOutlet UIButton *pricebtn;
    
    __weak IBOutlet UIImageView *newkeyImg;
    __weak IBOutlet UIImageView *hotkeyImg;
    __weak IBOutlet UIImageView *pricekeyImg;
    
    __weak IBOutlet UIImageView *newarrowImg;
    __weak IBOutlet UIImageView *hotarrowImg;
    __weak IBOutlet UIImageView *pricearrowImg;
    
    __weak IBOutlet UITableView *producttabV;
    
    
    BrandsProductListModel *productListModel;
    NSMutableArray *contentArr;
    BOOL isShow;
    
    BOOL isPriceDown;  //价格是否 是由低到高
    
    
    BOOL tableScrolling;
    BOOL dragging;
}

- (IBAction)sortBtnClick:(id)sender;

@property (retain, nonatomic) NSString *titleName;

@property (nonatomic, assign) BOOL isSearch;
@property (assign, nonatomic) BOOL isHot;
@property (nonatomic, assign) BOOL isProduct;
@property (nonatomic, assign) BOOL isOrder;
@property (nonatomic, assign) BOOL isSuit;
@property (nonatomic, assign) BOOL isShop;

@property (nonatomic, retain) NSString *key;
@property (nonatomic, retain) NSString *params;
@property (nonatomic, retain) NSString *orderStr;

@end
