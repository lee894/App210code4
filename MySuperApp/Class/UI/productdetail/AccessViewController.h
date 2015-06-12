//
//  AccessViewController.h
//  MySuperApp
//
//  Created by LEE on 14-4-22.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "LBaseViewController.h"

@interface AccessViewController : LBaseViewController <UITextViewDelegate,ServiceDelegate,UIAlertViewDelegate>
{
    UIButton *buttonLast;
    UIButton *buttonBra;
    UIButton *buttonDegree;

    MainpageServ *mainSev;
    
    IBOutlet UIScrollView *scrollContent;
    IBOutlet UILabel *labelAccess;
    IBOutlet UITextView *textAccess;
    IBOutlet UIView *viewBackground;

     IBOutlet UILabel *labelOne;
    
     IBOutlet UILabel *labelOrder_tow;
     IBOutlet UILabel *labelOrder_three;
     IBOutlet UIImageView *imageOrder_tow;
     IBOutlet UIImageView *imageOrder_three;
    
    UIButton *buttonText;//点击此button textview的键盘消失

}

@property (nonatomic, retain) NSString *goodId;
@property (nonatomic, retain) NSString *productID;
@property (nonatomic, retain) NSString *co_ID;

@property (nonatomic, assign) BOOL isMyAccess;


- (IBAction)size:(UIButton *)sender;//尺码
- (IBAction)braSize:(UIButton *)sender;//罩杯薄厚
- (IBAction)degress:(UIButton *)sender;//聚拢度
@end
