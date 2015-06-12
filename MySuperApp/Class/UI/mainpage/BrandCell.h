
//
//  BrandCell.h
//  MySuperApp
//
//  Created by LEE on 14-7-23.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UrlImageButton.h"
#import "BrandsModel.h"

@interface BrandCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UrlImageButton *buttonFirst;
@property (nonatomic, retain) IBOutlet UrlImageButton *buttonSecond;
@property (nonatomic, retain) IBOutlet UrlImageButton *buttonThird;

- (void)setBackgroundImage:(NSInteger)indexpathRow withArray:(BrandsModel *)array;//设置背景图片

@end
