//
//  MagezineCell.h
//  MySuperApp
//
//  Created by LEE on 14-4-7.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UrlImageView.h"

@interface MagezineCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UrlImageView *imgsmall;//cell显示图片
@property (nonatomic, weak) IBOutlet UILabel *labelTitle;
@property (nonatomic, weak) IBOutlet UILabel *labelBrief;

@end
