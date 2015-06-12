//
//  GifesCell.h
//  MySuperApp
//
//  Created by bonan on 14-4-10.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UrlImageView.h"

@protocol GifesCellDelegate <NSObject>

@optional
- (void)giftsCellWithStates:(BOOL)states indexPath:(int)index;

@end

@interface GifesCell : UITableViewCell

@property (nonatomic, assign) id<GifesCellDelegate> delegate;
@property (nonatomic, weak) IBOutlet UIButton *selectBtn;//选择按钮
@property (nonatomic, weak) IBOutlet UrlImageView *picImgView;//图片
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;//标题

@property (nonatomic, weak) IBOutlet UIButton *colorBtn;//选择颜色
@property (nonatomic, weak) IBOutlet UIButton *chimaBtn;//选择尺码
@property (nonatomic, weak) NSIndexPath *indexPath;
@end
