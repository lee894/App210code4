//
//  ProductListCell.h
//  MySuperApp
//
//  Created by LEE on 14-4-5.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UrlImageView.h"


@interface ProductListCell : UITableViewCell
{
    IBOutlet UIView *allcellBg;
    
}
@property (nonatomic, retain) IBOutlet UrlImageView *imageViewCommodity;
@property (nonatomic, retain) IBOutlet UILabel *labelIntroduce;
@property (nonatomic, retain) IBOutlet UILabel *labelStock;
@property (nonatomic, retain) IBOutlet UILabel *labelColor;
@property (nonatomic, retain) IBOutlet UILabel *labelNum;
@property (nonatomic, retain) IBOutlet UILabel *labelSize;
@property (nonatomic, retain) IBOutlet UILabel *labelPrice;
@property (nonatomic, retain) IBOutlet UILabel *labelTotal;
@property (nonatomic, retain) IBOutlet UIButton *buttonAccess;

@property (retain, nonatomic) IBOutlet UILabel *labelTextTotal;

@property (weak, nonatomic) IBOutlet UIImageView *iconImagV;

@end
