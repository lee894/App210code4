//
//  AddAddressViewController.h
//  MySuperApp
//
//  Created by LEE on 14-4-2.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "LBaseViewController.h"
#import "AddressPickerView.h"
@class CheckOutViewController;
@interface AddAddressViewController : LBaseViewController <UITextFieldDelegate,AreaPickerDelegate,ServiceDelegate,UIScrollViewDelegate>
{
    MainpageServ *mainSer;
    
    __weak IBOutlet UIView *myallView;
    __weak IBOutlet UIScrollView *myallscrollView;
    
    IBOutlet UITextField *textFieldName;
    IBOutlet UITextField *textFieldDetail;
    IBOutlet UITextField *textFieldZip;
    IBOutlet UITextField *textFieldTel;
    IBOutlet UITextField *textFieldPhone;
    IBOutlet UITextField *textFieldEmail;
    
    IBOutlet UILabel *labelCity;
    
    AddressPickerView *addressPicker;
    
    
    NSString *province;
    NSString *city;
    NSString *area;
    
    NSString *provinceId;
    NSString *cityId;
    NSString *areaId;
}



@property (nonatomic, assign) BOOL addOrEdit; // 新增进入or编辑进入 YES新增 NO编辑

@property (nonatomic, assign) BOOL isFromcheck; // isFromCheckView
@property (nonatomic, retain) AddressAddresslist *addressList;//用于显示编辑地址时信息
@property (nonatomic, assign) CheckOutViewController* covc;
- (IBAction)chooseCity:(id)sender;//选择城市
@end
