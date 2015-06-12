//
//  EndCell.h
//  MySuperApp
//
//  Created by LEE on 14-4-5.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderpaynowEndCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UIButton *buttonLogistics;
@property (weak, nonatomic) IBOutlet UILabel *laborderPrice;


- (void)setImageAndTitlewithRow:(NSInteger)section andBool:(NSInteger )suitCount;
@end
