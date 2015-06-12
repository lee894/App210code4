//
//  SearchpageViewController.h
//  aimerOnline
//
//  Created by lee on 14-3-3.
//  Copyright (c) 2014年 aimer. All rights reserved.
//

#import "LBaseViewController.h"

@interface SearchpageViewController : LBaseViewController<ServiceDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    IBOutlet UIView *viewBut;
    IBOutlet UIButton *refreshBut;
    
    MainpageServ *mainSev;
    
    SearchSearchHotModel *searchModel;
    
    IBOutlet UITableView *tableViewConetnt;
    
    
    IBOutlet UIImageView *rightJianImage;
    IBOutlet UIImageView *leftJianImage;
    NSArray *arrSearch;

    UITextField *serchField ;

    __weak IBOutlet UIView *myallView;
}

- (IBAction)seacheHotAndZuijingButActionChicked:(UIButton *)sender;


@end
