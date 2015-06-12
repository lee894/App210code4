//
//  BrandListViewController.h
//  MySuperApp
//
//  Created by Sophie  on 14-3-23.
//  Copyright (c) 2014年 aimer. All rights reserved.
//

#import "LBaseViewController.h"
#import "ServiceBaseWithMK.h"
#import "BrandCell.h"
#import "MainpageServ.h"

#define BrandCellNum 2


@interface BrandListViewController : LBaseViewController<UITableViewDataSource,UITableViewDelegate,ServiceDelegate>

@property (retain, nonatomic) BrandsModel *brandModel;

- (IBAction)changebrandView:(UIButton *)sender;

@end
