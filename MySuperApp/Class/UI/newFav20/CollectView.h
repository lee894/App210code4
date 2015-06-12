//
//  CollectView.h
//  MySuperApp
//
//  Created by LEE on 14-7-31.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YKStrikePriceLabel.h"

@class UrlImageView;
@interface CollectView : UIView

@property (nonatomic, retain) IBOutlet UrlImageView *imageBackground;
@property (nonatomic, retain) IBOutlet UILabel *labelIntroduct;
@property (nonatomic, retain) IBOutlet UILabel *labelMoney;
@property (nonatomic,retain) IBOutlet YKStrikePriceLabel *label2Money;

@property (nonatomic, retain) IBOutlet UIButton *buttonCancel;
@property (nonatomic, retain) IBOutlet UIButton *buttonBack;


@end
