//
//  CollectCell.m
//  MySuperApp
//
//  Created by LEE on 14-7-31.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "CollectCell.h"
#import "CollectView.h"
#import "ProductlistPictext.h"
#import "SuitListSuitlist.h"
#import "Price.h"
#import "FavoriteFavoritePic.h"
#import "BrandsProductlistPictext.h"


@implementation CollectCell
@synthesize collectFirst,collectSecond;
@synthesize delegate;
@synthesize idProduct;

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

- (void)setbuttonCancel:(BOOL)bools//视图上x按钮状态
{
    self.collectFirst.buttonCancel.hidden = bools;
    self.collectSecond.buttonCancel.hidden = bools;
}

- (void)setImageData:(NSInteger)row withArray:(NSMutableArray *)array//设置背景图片
{
    int num = ceilf(array.count/2.0);
    id favoriteFirst = [array objectAtIndex:row * 2];
    
    //lee999
    NSString *imageurl = @"";//[self changeimageToSmall:[favoriteFirst pic]];
    if ([favoriteFirst pic].length > 0) {
        imageurl = [self changeimageToSmall:[favoriteFirst pic]];
    }else{
        imageurl = [self changeimageToSmall:[favoriteFirst image_file_path]];
    }
    
    if ([favoriteFirst isKindOfClass:[FavoriteFavoritePic class]]) {
        //lee999  收藏
        [self.collectFirst.imageBackground setImageWithURL:[NSURL URLWithString:imageurl] placeholderImage:nil];

        self.collectFirst.labelIntroduct.text = [(FavoriteFavoritePic *)favoriteFirst name];

        self.collectFirst.labelMoney.text = [NSString stringWithFormat:@"￥%@",[(FavoriteFavoritePic *)favoriteFirst price]];
        self.collectFirst.label2Money.hidden = YES;

        self.idProduct = [favoriteFirst productid];

    }else if([favoriteFirst isKindOfClass:[BrandsProductlistPictext class]]) {

        //品牌馆列表
        [self.collectFirst.imageBackground setImageWithURL:[NSURL URLWithString:imageurl] placeholderImage:nil];

        BrandsPrice *favorFirst = (BrandsPrice *)[(BrandsProductlistPictext *)favoriteFirst price];
        BrandsPrice1 *favorFirst1 = (BrandsPrice1 *)[(BrandsProductlistPictext *)favoriteFirst price1];

        self.collectFirst.labelIntroduct.text = [(ProductlistPictext *)favoriteFirst name];
        self.idProduct = [(ProductlistPictext *)favoriteFirst productlistPictextIdentifier];

        self.collectFirst.labelMoney.text = [NSString stringWithFormat:@"￥%@",favorFirst.value];
        
        if ([favorFirst.value isEqualToString:favorFirst1.value]) {
            self.collectFirst.label2Money.hidden = YES;
        }else {
            self.collectFirst.label2Money.text = [NSString stringWithFormat:@"￥%@",favorFirst1.value];
        }

    }else {
        //套装
        
        [self.collectFirst.imageBackground setImageWithURL:[NSURL URLWithString:[self changeimageToSmall:[favoriteFirst image_file_path]]] placeholderImage:nil];

        self.collectFirst.labelIntroduct.text = [(SuitListSuitlist *)favoriteFirst name];
        
        self.collectFirst.labelMoney.text = [NSString stringWithFormat:@"￥%@",[(SuitListSuitlist *)favoriteFirst price]];
        
        if ([[(SuitListSuitlist *)favoriteFirst price] isEqualToString:[(SuitListSuitlist *)favoriteFirst mkt_price]]) {
            self.collectFirst.label2Money.hidden = YES;

        }else {
            self.collectFirst.label2Money.text = [NSString stringWithFormat:@"￥%@",[(SuitListSuitlist *)favoriteFirst mkt_price]];
        }

        self.idProduct = [favoriteFirst suitid];
    }
    
    
    if (row == num - 1 && array.count % 2 == 1) {
        self.collectSecond.hidden = YES;
    }else {
        id favoriteSecond = [array objectAtIndex:row * 2 + 1];
        
        //lee999
        NSString *imageurl2 =[self changeimageToSmall:[favoriteSecond pic]];
        
        if ([favoriteSecond isKindOfClass:[FavoriteFavoritePic class]]) {
            [self.collectSecond.imageBackground setImageWithURL:[NSURL URLWithString:imageurl2] placeholderImage:nil];

            self.collectSecond.labelIntroduct.text = [(FavoriteFavoritePic *)favoriteSecond name];
            
            self.collectSecond.labelMoney.text = [NSString stringWithFormat:@"￥%@",[(FavoriteFavoritePic *)favoriteSecond price]];;
            self.collectSecond.label2Money.hidden = YES;

            self.idProduct2 = [favoriteSecond productid];
            
        }else if([favoriteFirst isKindOfClass:[BrandsProductlistPictext class]]) {
            [self.collectSecond.imageBackground setImageWithURL:[NSURL URLWithString:imageurl2] placeholderImage:nil];

            BrandsPrice *favorSecond = (BrandsPrice *)[(BrandsProductlistPictext *)favoriteSecond price];
            BrandsPrice1 *favorSecond1 = (BrandsPrice1 *)[(BrandsProductlistPictext *)favoriteSecond price1];

            self.collectSecond.labelIntroduct.text = [(ProductlistPictext *)favoriteSecond name];
            
            self.collectSecond.labelMoney.text = [NSString stringWithFormat:@"￥%@",favorSecond.value];
            
            if ([favorSecond.value isEqualToString:favorSecond1.value]) {
                self.collectSecond.label2Money.hidden = YES;
            }else {
                self.collectSecond.label2Money.text = [NSString stringWithFormat:@"￥%@",favorSecond1.value];
            }
            self.idProduct2 = [(ProductlistPictext *)favoriteSecond productlistPictextIdentifier];
    
        }else{
        
            [self.collectSecond.imageBackground setImageWithURL:[NSURL URLWithString:[self changeimageToSmall:[favoriteSecond image_file_path]]] placeholderImage:nil];

            self.collectSecond.labelIntroduct.text = [(SuitListSuitlist *)favoriteSecond name];
            
            self.collectSecond.labelMoney.text =[NSString stringWithFormat:@"￥%@",[(SuitListSuitlist *)favoriteSecond price]];
            
            if ([[(SuitListSuitlist *)favoriteSecond price] isEqualToString:[(SuitListSuitlist *)favoriteSecond mkt_price]]) {
                self.collectSecond.label2Money.hidden = YES;
                
            }else {
                self.collectSecond.label2Money.text = [NSString stringWithFormat:@"￥%@",[(SuitListSuitlist *)favoriteSecond mkt_price]];
            }
            self.idProduct2 = [favoriteSecond suitid];
        }
    }
    self.collectFirst.buttonBack.tag = 11;
    self.collectSecond.buttonBack.tag = 12;
    
    self.collectFirst.buttonCancel.tag = row * 2 + 90;
    self.collectSecond.buttonCancel.tag = row * 2 + 91;
}




- (IBAction)fork:(UIButton *)sender//叉子按钮删除单个收藏
{
    if ([delegate respondsToSelector:@selector(forkWithTag:withProductId:)]) {
        

        //NSLog(@"tag:------%d",sender.tag);

//        if (sender.tag == 11) {
        //lee999recode
        if (sender.tag%2<1) {
            [delegate forkWithTag:sender.tag - 90 withProductId:self.idProduct];
        } else {
            [delegate forkWithTag:sender.tag - 90 withProductId:self.idProduct2];
        }
    }
}

- (IBAction)productList:(UIButton *)sender
{
    if ([delegate respondsToSelector:@selector(forkProductList:)]) {
        if (sender.tag == 11) {
            [delegate forkProductList:self.idProduct];

        } else {
            [delegate forkProductList:self.idProduct2];
        }
    }
}


//lee999 修改商品列表图片为小图
-(NSString*)changeimageToSmall:(NSString*)aimageStr{

    NSLog(@"剪切后的图片url是：%@",[aimageStr hasSuffix:@".jpg"]?[aimageStr stringByReplacingOccurrencesOfString:@".jpg" withString:@"_169x210.jpg"]:aimageStr);
    
    return [aimageStr hasSuffix:@".jpg"]?[aimageStr stringByReplacingOccurrencesOfString:@".jpg" withString:@"_169x210.jpg"]:aimageStr;
}

@end
