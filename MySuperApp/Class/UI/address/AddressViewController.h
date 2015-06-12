//
//  AddressViewController.h
//  MySuperApp
//
//  Created by LEE on 14-4-1.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "LBaseViewController.h"
#import "CheckOutViewController.h"

@interface AddressViewController : LBaseViewController <UITableViewDataSource,UITableViewDelegate,ServiceDelegate>
{
    MainpageServ *mainSer;
    
    IBOutlet UITableView *tableList;
    IBOutlet UIButton *buttonEdit;
    
    IBOutlet UILabel *noaddrssslab;
    AddressAddressLIstModel *addresslistModel;
    
    
    BOOL isDelAddress; //是否是删除了地址
}

@property (nonatomic, assign) BOOL isCar;//是否从购物车或其他界面进入

@property (nonatomic, retain) CheckOutViewController *chectOutViewC;
@property (nonatomic, retain) NSString *PublicStringAddressId;

- (IBAction)editAddress:(id)sender;//编辑地址

@end
