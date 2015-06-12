//
//  OrderCell.m
//  MySuperApp
//
//  Created by LEE on 14-4-5.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "OrderCell.h"


@implementation OrderCell
@synthesize labelOrderNum,labelTime,labelStatus,labelDelivery,labelDeliveryNum,labelName,labelMoney;
@synthesize tag;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellContent:(OrdersOrdersList *)orderList//设置cell上面的数据
{
//    self.labelOrderNum.text = orderList.orderid;
    self.labelTime.text = [orderList.time substringToIndex:10];
    self.labelStatus.text = orderList.status;
    self.labelDelivery.text = orderList.pay_status;
    self.labelDeliveryNum.text = orderList.goodscount;
    self.labelName.text = orderList.name;
    self.labelMoney.text = orderList.price?[NSString stringWithFormat:@"￥%@",orderList.price]:@"";
    
    [_orderImage setImageWithURL:[NSURL URLWithString:orderList.order_pic]  placeholderImage:[UIImage imageNamed:@"pic_default_product_list_03.png"]];

    _redBtn.tag = tag;
    _graybtn.tag = tag;
    
    NSLog(@"订单列表里面，按钮的状态：------%@",orderList.order_status);
    //lee999  增加不同的判断按钮
    if (orderList.order_status.length>1) {
        if ([orderList.order_status isEqualToString:@"立即支付"]) {
            [_redBtn setTitle:@"立即支付" forState:UIControlStateNormal];
            [_redBtn setTitle:@"立即支付" forState:UIControlStateHighlighted];
        }
        if ([orderList.order_status isEqualToString:@"确认收货"]) {
            [_redBtn setTitle:@"确认收货" forState:UIControlStateNormal];
            [_redBtn setTitle:@"确认收货" forState:UIControlStateHighlighted];
        }
        if ([orderList.order_status isEqualToString:@"评价"]) {
            [_redBtn setTitle:@"评价" forState:UIControlStateNormal];
            [_redBtn setTitle:@"评价" forState:UIControlStateHighlighted];
        }
    }else{
        _redBtn.hidden = YES;
    }
    if (orderList.expressid.length > 1) {
        //如果没有查看物流按钮
        _graybtn.hidden = NO;
    }else{
    //有查看物流的按钮
        _graybtn.hidden = YES;
        
        CGRect oldframe = _redBtn.frame;
        oldframe.origin.x += 50;
        [_redBtn setFrame:oldframe];
    }
    //如果两个按钮都没有的话，那么就减小高度
    if (_redBtn.hidden == YES && _graybtn.hidden == YES) {
        CGRect oldframe1 = self.frame;
        oldframe1.size.height -= 50;
        [self setFrame:oldframe1];

        CGRect oldframe2 = self.cellbg2.frame;
        oldframe2.size.height -= 50;
        self.cellbg2.frame = oldframe2;
        
        CGRect oldframe3 = self.cellbg3.frame;
        oldframe3.origin.y -= 50;
        self.cellbg3.frame = oldframe3;

    }
    
    //end
}

@end
