//
//  BonusCell.h
//  爱慕商场
//
//  Created by LEE on 14-7-31.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCell.h"

@interface BonusCell : BaseCell
{
    __weak IBOutlet UIImageView *cellbg;


}
@property (nonatomic, retain) IBOutlet UIButton *btnBonus;
@property (nonatomic, retain) IBOutlet UILabel *labelTime;
@property (nonatomic, retain) IBOutlet UIImageView *imageViewIsUsed;
@property (nonatomic, retain) IBOutlet UIButton *buttonUsed;

@property (nonatomic, retain) IBOutlet UILabel *labelTitle;
@property (nonatomic, retain) IBOutlet UILabel *labelDesc;
@property (nonatomic, retain) IBOutlet UILabel *labelPrice;

@end
