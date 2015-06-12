//
//  EndCell.h
//  MySuperApp
//
//  Created by LEE on 14-4-5.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderEndCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UIButton *buttonLogistics;
- (void)setImageAndTitlewithRow:(NSInteger)section andBool:(NSInteger )suitCount;
@end
