//
//  FeedBackViewController.h
//  MySuperApp
//
//  Created by lee on 14-3-27.
//  Copyright (c) 2014年 aimer. All rights reserved.
//

#import "LBaseViewController.h"

@interface FeedBackViewController : LBaseViewController <UITextFieldDelegate,UITextViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,ServiceDelegate,UIAlertViewDelegate>
{
    MainpageServ *mainSer;
    
    IBOutlet UITextField *textFieldPhone;
    IBOutlet UITextView *textViewContent;
    IBOutlet UILabel *labelContent;
    IBOutlet UILabel *labelChoose;
    IBOutlet UIPickerView *pickerChoose;
    
    UIView *viewPicker;
    NSArray *arrayPicker;
    __weak IBOutlet UIScrollView *myallscrollView;
}





- (IBAction)choosePicker:(id)sender;//PickerView弹出
- (IBAction)submit:(id)sender;//提交

- (IBAction)confirmOrCancel:(UIButton *)sender;//pickerView 确认取消
@end
