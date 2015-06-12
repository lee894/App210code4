//
//  AimerHeadCell.h
//  MySuperApp
//
//  Created by LEE on 14-3-30.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UrlImageButton.h"
#import "MoerUserinfo.h"

@interface AimerHeadCell : UITableViewCell
{
    IBOutlet UILabel *labelShopCar;//购物车
    IBOutlet UILabel *labelUnhandel;//未处理
    IBOutlet UILabel *labelUnaccess;//未评价
    
    IBOutlet UILabel *labelName;//昵称

    
}
@property (weak, nonatomic) IBOutlet UIButton *buttonintegral;
@property (weak, nonatomic) IBOutlet UIButton *changeBut;
@property (weak, nonatomic) IBOutlet UrlImageButton *InfterFaceBut;

- (void)setContent:(MoerUserinfo *)userInfo;//购物车，待处理，待评价内容
@end
