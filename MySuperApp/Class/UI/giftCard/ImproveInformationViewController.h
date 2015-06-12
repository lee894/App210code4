//
//  ImproveInformationViewController.h
//  爱慕商场
//
//  Created by 念肆 on 14-9-17.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+LayoutFrame.h"
#import "ChangScrollView.h"
#import "ModifyCell.h"
#import "LBaseViewController.h"

@interface ImproveInformationViewController : LBaseViewController <UITextFieldDelegate,UIScrollViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UITableViewDelegate,UITableViewDataSource,ServiceDelegate,ModifyCellDelegate>
{
    
    MainpageServ *mainSer;
    
    IBOutlet UIScrollView *scrollView;
    IBOutlet UITextField *nameTField;
    IBOutlet UIButton *ladyBtn;
    IBOutlet UIButton *gentlemanBtn;
    IBOutlet UITextField *nicknameTField;
    IBOutlet UIButton *yearBtn;
    IBOutlet UIButton *monthBtn;
    IBOutlet UIButton *dayBtn;
    IBOutlet UITextField *telephoneTFiled;
    IBOutlet UIButton *provingBtn;
    IBOutlet UITextField *verificationCodeTField;
    IBOutlet UITextField *addressTField;
    IBOutlet UITextField *postcodeTField;
    IBOutlet UITextField *emailTField;
    IBOutlet UIButton *incomeBtn;
    IBOutlet UIButton *professionBtn;
    IBOutlet UIButton *underwearBtn;
    IBOutlet UIButton *underpantsBtn;
    IBOutlet UIButton *adultBtn;
    IBOutlet UIButton *confirmBtn;
    IBOutlet UILabel *remarkLabel;

    int currentData;
//    UIActionSheet * actionSheet;
    NSMutableArray * dataArray;
    NSMutableArray * lastSelectArray;
    NSString * gender;
    UITableView * mytableView;
    int children;
    int deleteRow;
    
    NSMutableArray * tableViewDataArray;
}

@property (nonatomic, retain) NSString *key;

- (IBAction)btnClick:(id)sender;

@end
