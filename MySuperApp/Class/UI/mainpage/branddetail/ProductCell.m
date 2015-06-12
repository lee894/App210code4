//
//  ProductCell.m
//  MySuperApp
//
//  Created by LEE on 14-7-23.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "ProductCell.h"
#import "ProductView.h"
#import "BrandsPrice.h"
#import "BrandsPrice1.h"
#import "BrandsProductlistPictext.h"

@implementation ProductCell
@synthesize productViewFirst;
@synthesize productViewSecond;
@synthesize productViewThird;
@synthesize delegate;
@synthesize idProduct;

#define numOfCell 2

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

#pragma mark -- 设置商品图片
- (void)setBackgroundImage:(NSInteger)indexRow withArray:(NSArray *)array
{
    int num = ceilf(array.count/numOfCell);
    BrandsProductlistPictext *first = (BrandsProductlistPictext *)[array objectAtIndex:indexRow * numOfCell];
//    [self.productViewFirst.imageViewBackground setImageFromUrl:YES withUrl:first.pic];
    NSURL *url = [NSURL URLWithString:first.pic];
    [self.productViewFirst.imageViewBackground setImageWithURL:url placeholderImage:[UIImage imageNamed:@"pic_default_product_list_03.png"]];//
    self.productViewFirst.labelMessage.text = first.name;
    BrandsPrice *priceone = (BrandsPrice *)first.price;
    BrandsPrice1 *priceOneOld = (BrandsPrice1 *)first.price1;
    self.productViewFirst.labelMoney.text = [NSString stringWithFormat:@"￥%@",priceone.value];
    
    if ([priceone.value isEqualToString:priceOneOld.value]) {
        self.productViewFirst.labeMoneyOld.hidden = YES;
    }else {
        self.productViewFirst.labeMoneyOld.text = [NSString stringWithFormat:@"￥%@",priceOneOld.value];
    }
    
    if (indexRow == num - 1) {
        if (array.count % numOfCell == 1) {
            self.productViewSecond.hidden = YES;
            self.productViewThird.hidden = YES;
        }else if (array.count % numOfCell == 2){
            
            self.productViewThird.hidden = YES;
            
            BrandsProductlistPictext *second = (BrandsProductlistPictext *)[array objectAtIndex:indexRow * numOfCell + 1];
            NSURL *urlSecond = [NSURL URLWithString:second.pic];
            [self.productViewSecond.imageViewBackground setImageWithURL:urlSecond placeholderImage:[UIImage imageNamed:@"pic_default_product_list_03.png"]];
            self.productViewSecond.labelMessage.text = second.name;
            BrandsPrice *priceSecond = (BrandsPrice *)second.price;
            BrandsPrice1 *priceSecondOld = (BrandsPrice1 *)second.price1;
            
            self.productViewSecond.labelMoney.text = [NSString stringWithFormat:@"￥%@",priceSecond.value];
            
            if ([priceSecond.value isEqualToString:priceSecondOld.value]) {
                self.productViewSecond.labeMoneyOld.hidden = YES;
            }else {
                self.productViewSecond.labeMoneyOld.text = [NSString stringWithFormat:@"￥%@",priceSecondOld.value];
            }
        }
    }else{
        
        BrandsProductlistPictext *second = (BrandsProductlistPictext *)[array objectAtIndex:indexRow * numOfCell + 1];
        NSURL *urlSecond = [NSURL URLWithString:second.pic];
        [self.productViewSecond.imageViewBackground setImageWithURL:urlSecond placeholderImage:[UIImage imageNamed:@"pic_default_product_list_03.png"]];
        self.productViewSecond.labelMessage.text = second.name;
        BrandsPrice *priceSecond = (BrandsPrice *)second.price;
        self.productViewSecond.labelMoney.text = [NSString stringWithFormat:@"￥%@",priceSecond.value];
        
        BrandsPrice1 *priceSecondOld = (BrandsPrice1 *)second.price1;
        
        if ([priceSecond.value isEqualToString:priceSecondOld.value]) {
            self.productViewSecond.labeMoneyOld.hidden = YES;
        }else {
            self.productViewSecond.labeMoneyOld.text = [NSString stringWithFormat:@"￥%@",priceSecondOld.value];
        }
        
        
        
       BrandsProductlistPictext *third = (BrandsProductlistPictext *)[array objectAtIndex:indexRow * numOfCell + 2];
        NSURL *urlThird = [NSURL URLWithString:third.pic];
        [self.productViewThird.imageViewBackground setImageWithURL:urlThird placeholderImage:[UIImage imageNamed:@"pic_default_product_list_03.png"]];
        self.productViewThird.labelMessage.text = third.name;
        BrandsPrice *priceThird = (BrandsPrice *)third.price;
        BrandsPrice1 *priceThirdOld = (BrandsPrice1 *)third.price1;

        self.productViewThird.labelMoney.text = [NSString stringWithFormat:@"￥%@",priceThird.value];
        if ([priceThird.value isEqualToString:priceThirdOld.value]) {
            self.productViewThird.labeMoneyOld.hidden = YES;
        }else {
            self.productViewThird.labeMoneyOld.text = [NSString stringWithFormat:@"￥%@",priceThirdOld.value];
        }
        
    }
    
    self.productViewFirst.buttonconfirm.tag =  indexRow * numOfCell + 40;
    self.productViewSecond.buttonconfirm.tag = indexRow * numOfCell + 41;
    self.productViewThird.buttonconfirm.tag =  indexRow * numOfCell + 42;
}

- (IBAction)productId:(UIButton *)sender//获得点击产品的ID
{
    if ([delegate respondsToSelector:@selector(getProductId:)]) {
        [delegate getProductId:sender.tag-40];
   }
}
@end
