//
//  ShowcomMentViewController.h
//  MySuperApp
//
//  Created by bonan on 14-4-9.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBaseViewController.h"
@interface ShowcomMentViewController : LBaseViewController <ServiceDelegate> {

    MainpageServ *mainSev;
    ShowcomMentModel *showModel;
    
    IBOutlet UIScrollView *scrollContent;
    IBOutlet UIView *viewBackground;
    
    UIButton *buttonText;//点击此button textview的键盘消失
    
    IBOutlet UILabel *chimaScore1Label;
    IBOutlet UILabel *chimaScore2Label;
    IBOutlet UILabel *chimaScore3Label;
    
    IBOutlet UILabel *zhaobeiScore1Label;
    IBOutlet UILabel *zhaobeiScore2Label;
    IBOutlet UILabel *zhaobeiScore3Label;
    
    IBOutlet UILabel *juScore1Label;
    IBOutlet UILabel *juScore2Label;
    IBOutlet UILabel *juScore3Label;
    
    
    IBOutlet UILabel *dingweiUserLabel;
    
    IBOutlet UILabel *labelTitleTow;
    IBOutlet UILabel *labelTow;
    IBOutlet UILabel *labelTow2;
    IBOutlet UILabel *labelTow3;
    IBOutlet UILabel *labelTitileThree;
    IBOutlet UILabel *labelThree;
    IBOutlet UILabel *labelThree2;
    IBOutlet UILabel *labelThree3;
    IBOutlet UIImageView *imageOrder_tow;
    IBOutlet UIImageView *imageOrder_three;
}


@property (retain,nonatomic) NSString *goodId;
@property (retain,nonatomic) NSString *pingjian;

@property (assign,nonatomic) BOOL isFromMyAimer;
@property (assign,nonatomic) BOOL isHiddenBar;

@end
