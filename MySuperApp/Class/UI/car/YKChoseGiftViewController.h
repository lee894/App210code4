//
//  YKChoseGiftViewController.h
//  YKProduct
//
//  Created by caiting on 11-12-14.
//  Copyright 2011 yek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBaseViewController.h"
#import "ButtonInSection.h"
#import "GifesCell.h"
#import "PicsView.h"

@interface YKChoseGiftViewController : LBaseViewController <UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource,ServiceDelegate,ButtonInSeactionDelegate,GifesCellDelegate,PicsViewDelegate>{
    
    
	NSInteger tagnumber;
	NSMutableArray* buttonArray;
	NSMutableArray* spseidArray;
    
    NSMutableArray *resultsArray;
    
    
    MainpageServ *mainSev;
    
    NSInteger currentColor;
    NSInteger currentSize;
    NSMutableArray *_muArrSelectGift;//已加入购物车的赠品
    
    
    SelectGifesModel *selectGiftsModel;
    
    
    NSMutableArray* cells;
    IBOutlet UITableView* giftTab;
    NSMutableArray* giftArray;
    IBOutlet  UIPickerView *picker;
    IBOutlet  UIView* popView;
    
    
    __weak IBOutlet UIBarButtonItem *barbtnCancel;
    __weak IBOutlet UIBarButtonItem *barBtnOK;
    
}



-(IBAction)cancelAction;
-(IBAction)ensureAction;

@end
