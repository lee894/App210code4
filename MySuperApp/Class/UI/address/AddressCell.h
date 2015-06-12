//
//  AddressCell.h
//  MySuperApp
//
//  Created by LEE on 14-4-1.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressAddresslist.h"


@interface AddressCell : UITableViewCell{

    IBOutlet UIImageView *imageBackground;
    IBOutlet UILabel *labelName;
    IBOutlet UILabel *labelMessage;
    IBOutlet UILabel *labelPhone;

}

@property(nonatomic,retain) IBOutlet UIImageView *imageCheck;//选择收货地址显示的图片


- (void)setContentWithArray:(AddressAddresslist *)address;//设置cell详细信息
@end
