//
//  CarpageViewController.h
//  aimerOnline
//
//  Created by lee on 14-3-3.
//  Copyright (c) 2014年 aimer. All rights reserved.
//

#import "LBaseViewController.h"
#import "RDVTabBarController.h"


@interface CarpageViewController : LBaseViewController<ServiceDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIAlertViewDelegate> {
    
    MainpageServ *mainSer;
    
    BOOL isCheck; //判断是不是登录
    
    BOOL isDisable;
    
    BOOL isaddfav;
    
    NSMutableArray* textproductNumArray;
//    NSMutableArray* textsuitNumArray;

    NSInteger suitCount;  //套装拥有数量
    NSInteger packageCount;
    NSInteger productCount;
    UIButton *toChectButton;
    UIButton *editButton;
    UIButton *toChectButton2;
    
    
    UIPickerView *pickerForSelectNumber;
    UIToolbar *toolBarForNumber;
    NSMutableArray *numberProduct;//物品数量的数据源
    NSInteger currentNumber; //商品的数量
    
    UITextField *currentFiled;
    
    
   IBOutlet UITableView* shoppingCarTab;
    
}

@property (nonatomic, retain) UIButton* btnBack;

@property (nonatomic, retain) CarCarModel *carModel;

@property(nonatomic,retain) UIView* nullView;

@property(nonatomic,retain) NSMutableArray* tableCells;
@property(nonatomic,retain) NSMutableArray* favCells;
@property(nonatomic,retain) NSMutableArray* suitlistcell;//套装
@property(nonatomic,retain) NSMutableArray* packagelistcell;//套装


@property(nonatomic,retain) UIButton* addfavButton; //选择赠品


@property (nonatomic, assign) BOOL isPush;

-(void)loadData;

@end
