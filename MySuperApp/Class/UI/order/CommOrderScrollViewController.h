//
//  CommOrderScrollViewController.h
//  MySuperApp
//
//  Created by lee on 14-7-10.
//  Copyright (c) 2014年 aimer. All rights reserved.
//

#import "LBaseViewController.h"

@interface CommOrderScrollViewController : LBaseViewController<UITextViewDelegate,ServiceDelegate,UIAlertViewDelegate,UITextFieldDelegate,UIScrollViewDelegate,UITextViewDelegate>
{
    
    __weak IBOutlet UIScrollView *myscrollView;

    MainpageServ *mainSev;

    UrlImageButton *buttonLast;
    UrlImageButton *buttonBra;
    UrlImageButton *buttonDegree;
    
    
    UITextView* textV1;
    
    
    int sectionCount;  //区域的个数

    AssessAssessModel *assessModel;

}


@property (nonatomic, retain) NSString *co_ID;


@end
