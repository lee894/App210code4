//
//  YKPreferentialSuit.h
//  YKProduct
//
//  Created by 耶客 on 12-7-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBaseViewController.h"
@interface YKPreferentialSuit :LBaseViewController <UITableViewDelegate, UITableViewDataSource,UIPickerViewDataSource,UIPickerViewDelegate,ServiceDelegate,UIAlertViewDelegate>
{
    UITableView *mytable;

    MainpageServ *mainSer;
    
    NSString *strStuit;
    
    NSMutableArray *cellArray;
    
    UIPickerView *pickerForSelectColor;//颜色下拉列表
    UIToolbar *toolBarForPicker;//picker上的toolbar
    UIPickerView *pickerForSelectSize;//尺寸下来列表
    UIToolbar *toolBarForSizePicker;//尺寸picker的toolbar
    
    NSInteger currentSelectRow;   //当前选中的行
}
@property (nonatomic, assign) BOOL isFromMyAimer;
@property (nonatomic, assign) BOOL isHiddenBar;

@property (nonatomic, retain) SuitServiceModel *suitListModel;

@property(nonatomic,retain) NSString *strStuit;

@end
