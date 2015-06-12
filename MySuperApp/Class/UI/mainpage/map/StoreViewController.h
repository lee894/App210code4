//
//  StoreViewController.h
//  MySuperApp
//
//  Created by LEE on 14-4-8.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "LBaseViewController.h"
#import "StoresStores.h"

@interface StoreViewController : LBaseViewController

@property (nonatomic, assign) NSInteger num;

@property (nonatomic, retain) IBOutlet UILabel *labelTitle;
@property (nonatomic, retain) IBOutlet UILabel *labelAddr;
@property (nonatomic, retain) IBOutlet UILabel *labelBrand;
@property (nonatomic, retain) IBOutlet UIButton *buttonPhone;
@property (nonatomic, retain) IBOutlet UrlImageView *img;
@property (nonatomic, retain) StoresStores *store;
@property (nonatomic, retain) NSString *myPositionWeiduString;
@property (nonatomic, retain) NSString *myPositionJinduString;



- (IBAction)telPhone:(id)sender;//打电话
- (IBAction)mapNavigation:(id)sender;

@end
