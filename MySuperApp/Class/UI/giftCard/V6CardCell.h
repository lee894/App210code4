//
//  V6CardCell.h
//  爱慕商场
//
//  Created by malan on 14-9-26.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "BaseCell.h"

@interface V6CardCell : BaseCell

@property (nonatomic, retain) IBOutlet UILabel *labelTitle;
@property (nonatomic, retain) IBOutlet UILabel *labelId;
@property (nonatomic, retain) IBOutlet UILabel *labelBalance;
@property (nonatomic, retain) IBOutlet UILabel *labelFrozenBalance;
@property (nonatomic, retain) IBOutlet UIButton *btnCard;

@property (nonatomic, retain) IBOutlet UIButton *btnCancel;//使用

@end
