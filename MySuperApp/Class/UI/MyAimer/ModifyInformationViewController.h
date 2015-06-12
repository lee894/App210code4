//
//  ModifyInformationViewController.h
//  MySuperApp
//
//  Created by 念肆 on 14-9-17.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBaseViewController.h"
#import "ChangScrollView.h"
#import "UIView+LayoutFrame.h"
#import "ModifyCell.h"


@interface ModifyInformationViewController : LBaseViewController <UITextFieldDelegate,UIScrollViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UITableViewDataSource,UITableViewDelegate,ServiceDelegate,UIAlertViewDelegate,ModifyCellDelegate>
{
    MainpageServ *mainSer;
 
    
    InfoInfoModel *infoModel;
    
    IBOutlet UITextField *nameLabel;
    IBOutlet UIButton *birthdayLabelBtn;
    IBOutlet UITextField *telephoneLabel;
    IBOutlet ChangScrollView *scrollView;
    IBOutlet UIButton *ladyBtn;
    IBOutlet UIButton *gentlemanBtn;
    IBOutlet UITextField *nicknameTField;
    IBOutlet UITextField *addressTField;
    IBOutlet UITextField *postcodeTField;
    IBOutlet UITextField *emailTField;
    IBOutlet UIButton *incomeBtn;
    IBOutlet UIButton *professionBtn;
    IBOutlet UIButton *underwearBtn;
    IBOutlet UIButton *underpantsBtn;
    IBOutlet UIButton *adultBtn;
     int currentData;
//    UIActionSheet * actionSheet;
    NSMutableArray * dataArray;
    NSMutableArray * lastSelectArray;
    NSString * gender;
    UITableView * mytableView;
    NSMutableArray * tableViewDataArray;
    IBOutlet UIButton *confirmBtn;
     int deleteRow;
     float lastOffset;
     BOOL isCellOffset;
    
     int children;    
}

- (IBAction)btnClick:(id)sender;


@end
