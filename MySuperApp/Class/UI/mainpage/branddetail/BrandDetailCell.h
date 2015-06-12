//
//  BrandDetailCell.h
//  aimeronle
//
//  Created by gaoge on 14-3-25.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UrlImageButton.h"
#import "UrlImageView.h"


@interface BrandDetailCell : UITableViewCell



@property (retain, nonatomic) IBOutlet UrlImageView *cellBgImagView;

@property (nonatomic, retain) IBOutlet UrlImageButton *buttonProduct;
@property (nonatomic, retain) IBOutlet UrlImageButton *buttonStory;
@property (nonatomic, retain) IBOutlet UrlImageButton *buttonNew;
@property (nonatomic, retain) IBOutlet UrlImageButton *buttonMessage;
@property (nonatomic, retain) IBOutlet UrlImageButton *buttonWeibo;
@property (nonatomic, retain) IBOutlet UIImageView *imageViewWeibo;
@property (nonatomic, retain) IBOutlet UILabel *labelWeibo;

- (void)setKindImageWithArray:(NSArray *)arrayKind;//设置各个小模块的背景图片

- (void)attentionWeibo:(NSString *)content;//关注微博文字内容和微博图片
@end
