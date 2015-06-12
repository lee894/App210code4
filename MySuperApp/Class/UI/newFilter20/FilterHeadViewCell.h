//
//  FilterHeadViewCell.h
//  paipaiiphone
//
//  Created by zhangwenguang on 15/3/25.
//  Copyright (c) 2015年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum
{
    FilterViewTypeNormal = 0,          // 普通项
    FilterViewTypeNoArrow =  1 << 0,     // 开始项
    FilterViewTypeArrowAndDetail =    1 << 1,     // 结束项
}FilterViewType;





@interface FilterHeadViewCell : UITableViewCell




@property (nonatomic, retain) UILabel *sectionNameLabel;
@property (nonatomic, retain) NSString *sectionName;

@property (nonatomic, retain) UILabel *rightLabel;
@property (nonatomic, retain) NSString *rightName;

@property (nonatomic, retain) UIImageView *stateView;
@property (nonatomic, retain) UIView *tapView;

@property (nonatomic, assign) BOOL open;
@property (nonatomic, assign) NSInteger headerType;



- (id)initWithFrame:(CGRect)frame isShowArrow:(BOOL)show;
- (void)setOpen:(BOOL)open animation:(BOOL)anim; //展开、关闭 cell右端的箭头



@end
