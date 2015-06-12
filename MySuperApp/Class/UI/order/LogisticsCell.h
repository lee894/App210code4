//
//  LogisticsCell.h
//  爱慕商场
//
//  Created by LEE on 14-8-5.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingletonState.h"

@interface LogisticsCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UIImageView *imageBackground;
@property (nonatomic, retain) IBOutlet UILabel *labelAddr;
@property (nonatomic, retain) IBOutlet UILabel *labelTime;

- (void)setBackgroundImageWithRow:(NSInteger)Row withCount:(NSInteger)count;//设置cell的背景图片
@end
