//
//  ProductView.h
//  MySuperApp
//
//  Created by LEE on 14-7-24.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YKStrikePriceLabel.h"
#import "UrlImageView.h"

@interface ProductView : UIView

@property (nonatomic, retain) IBOutlet UrlImageView *imageViewBackground;
@property (nonatomic, retain) IBOutlet UILabel *labelMessage;
@property (nonatomic, retain) IBOutlet UILabel *labelMoney;
@property (nonatomic, retain) IBOutlet UIButton *buttonconfirm;
@property (nonatomic, retain) IBOutlet YKStrikePriceLabel *labeMoneyOld;

@end
