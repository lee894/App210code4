//
//  BrandMessageCell.h
//  MySuperApp
//
//  Created by LEE on 14-7-25.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UrlImageView.h"
#import "ZixunZixunInfo.h"

@interface BrandMessageCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UIButton *buttonVodie;
@property (retain, nonatomic) IBOutlet UILabel *mainTititleLabel;
@property (nonatomic, retain) IBOutlet UrlImageView *imageViewShop;
@property (nonatomic, retain) IBOutlet UILabel *labelDescription;

- (void)addData:(ZixunZixunInfo *)data withRow:(NSInteger)row;//添加数据
@end
