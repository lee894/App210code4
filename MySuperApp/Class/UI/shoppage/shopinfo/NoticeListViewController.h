//
//  NoticeListViewController.h
//  MySuperApp
//
//  Created by bonan on 14-4-26.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBaseViewController.h"

@interface NoticeListViewController : LBaseViewController <ServiceDelegate> {

    MainpageServ *mainSev;
    IBOutlet UrlImageView *noticeImageView;
    IBOutlet UITextView *noticeTextView;
     NoticesNoticesModel *noticeModel;
    __weak IBOutlet UIView *myallView;
}

@property (nonatomic, retain) NSString  *noticeID;

@end
