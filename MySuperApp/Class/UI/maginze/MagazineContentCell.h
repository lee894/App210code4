//
//  MagazineContentCell.h
//  MySuperApp
//
//  Created by LEE on 14-4-7.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UrlImageView.h"

@interface MagazineContentCell : UITableViewCell <UIScrollViewDelegate>

@property (nonatomic, weak) IBOutlet UrlImageView *imageBig;
@property (nonatomic, weak) IBOutlet UILabel *labelTitle;
@property (nonatomic, weak) IBOutlet UITextView *textContext;
@property (nonatomic, weak) IBOutlet UIButton *buttonBigImg;
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollview;

@end
