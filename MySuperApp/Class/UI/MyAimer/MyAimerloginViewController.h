//
//  MyAimerloginViewController.h
//  MySuperApp
//
//  Created by LEE on 14-3-30.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBaseViewController.h"

@interface MyAimerloginViewController : LBaseViewController <UITableViewDataSource,UITableViewDelegate,ServiceDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>
{
    NSArray *arraySectionThird;
    NSArray *arraySectionTwo;
    BOOL isPush;
}


@property (nonatomic, retain) UIImage *headimage;

- (IBAction)makeCall:(id)sender;//拨打电话

- (IBAction)shopOrUnhandelOrUnaccess:(UIButton *)sender;//购物车||待处理||待评价
@end

