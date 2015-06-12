//
//  HeadCell.h
//  MySuperApp
//
//  Created by LEE on 14-4-5.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadOrderCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UILabel *labelHead;

- (void)setName:(NSInteger)section andBool:(NSInteger)Count;
@end
